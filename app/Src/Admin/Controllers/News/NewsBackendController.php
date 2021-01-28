<?php

namespace App\Src\Admin\Controllers\News;

use App\Http\Controllers\BackendController;
use App\Src\Admin\Extensions\Core\CustomForm;
use App\Src\Models\News\ModNews;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Grid\Filter;
use Encore\Admin\Layout\Content;
use Encore\Admin\Show;

class NewsBackendController extends BackendController
{
    use HasResourceActions;

    public $_resource = 'news';

    /**
     * Index interface.
     *
     * @return Content
     */
    public function index(Content $content)
    {
        $this->setTitle($this->resources[$this->_resource]['name']);

        $content->header($this->resources[$this->_resource]['name'])
            ->description($this->resources[$this->_resource]['description']);

        if ($this->lCheckPermission('read')) {
            $content->body($this->grid());
        }

        return $content;
    }

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $can_delete = $this->lCheckPermission('delete');
        $can_edit = $this->lCheckPermission('update');
        $can_create = $this->lCheckPermission('create');

        $grid = new Grid(new ModNews());

        $grid->model()->orderBy('id', 'DESC');

        $grid->paginate(20);

        $grid->id('ID')->sortable()->setAttributes(['style' => 'width:40px;']);
        $grid->log_name('Название')->sortable();
        $grid->alias('Алиас')->sortable();
        $grid->created_at('Добавлено')->sortable();
        $grid->updated_at('Обновлено')->sortable();

        // set the `text`、`color`、and `value`
        $states = [
            'on'  => ['value' => 1, 'text' => 'Вкл', 'color' => 'success'],
            'off' => ['value' => 0, 'text' => 'Выкл', 'color' => 'danger'],
        ];
        if ($can_edit) {
            $grid->comments_enabled('Коммент.')->switch($states);
            $grid->state('Статус')->switch($states);
        } else {
            $grid->state('Коммент.')->display(function ($state) {
                if ($state == 1) {
                    return "<span class='label label-success'>Да</span>";
                } else {
                    return "<span class='label label-danger'>Нет</span>";
                }
            });

            $grid->state('Статус')->display(function ($state) {
                if ($state == 1) {
                    return "<span class='label label-success'>Вкл.</span>";
                } else {
                    return "<span class='label label-danger'>Выкл.</span>";
                }
            });
        }

        $grid->filter(function (Filter $filter) {
            //$filter->disableIdFilter();
            $filter->like('log_name', 'Название');
            $filter->equal('state')->select(['0' => 'Отключено', 1 => 'Включено']);
        });

        $grid->actions(function ($actions) use ($can_delete, $can_edit) {
            $actions->disableView();

            if (!$can_delete) {
                $actions->disableDelete();
            }
            if (!$can_edit) {
                $actions->disableEdit();
            }

            $actions->column->setAttributes(['class' => 'row_actions']);
        });

        if (!$can_delete) {
            $grid->disableRowSelector();
        }

        if (!$can_create) {
            $grid->disableCreateButton();
        }

        return $grid;
    }

    /**
     * @param $id
     * @param Content $content
     *
     * @return Content
     */
    public function edit($id, Content $content)
    {
        $this->setTitle($this->resources[$this->_resource]['name'].' - Редактирование');
        $this->breadcrumbs->addCrumb('Редактирование', '');

        $content->header($this->resources[$this->_resource]['name'])
            ->description('Редактирование');

        if ($this->lCheckPermission('update')) {
            $content->body($this->form($id)->edit($id));
        }

        return $content;
    }

    /**
     * Make a form builder.
     *
     * @param mixed $id
     *
     * @return Form
     */
    protected function form($id = 0)
    {
        $form = new CustomForm(new ModNews());
        $form->disableViewCheck();
        $form->disableEditingCheck();

        $form->tools(function (Form\Tools $tools) {
            // Disable `Veiw` btn.
            $tools->disableView();
        });

        $form->tab('Общее', function (Form $form) use ($id) {
            $form->html('<div class="form-group"><div class="col-md-12"><h4 class="form-header">Основная информация</h4></div></div>');

            $form->text('log_name', 'Название')->rules(
                'required',
                ['required' => 'Поле обязательно для заполнения']
            )->setLabelClass(['required']);

            $item = $form->model()->findOrNew($id);

            $form->hidden('lock_alias', 'Алиас редактируемый?')->default($item ? $item->lock_alias : old('lock_alias',
                0));

            $form->translit(
                'alias',
                'log_name',
                'lock_alias',
                $item->lock_alias,
                'Алиас'
            )->setLabelClass(['required'])->rules(
                function ($form) {
                    // If it is not an edit state, add field unique verification
                    if (!$id = $form->model()->id) {
                        return 'required|unique:'.$form->model()->getTable().',alias|min:10';
                    }

                    return 'required|unique:'.$form->model()->getTable().',alias,'.$id.',id|min:10';
                },
                [
                    'required' => 'Поле обязательно для заполнения',
                    'min'      => 'Значение должно иметь минимум 10 символа',
                    'unique'   => 'Запись с таким значением уже существует',
                ]
            );
        })->tab('Картинки', function (Form $form) use ($id) {
            if ($id > 0) {
                $html = app('images.photo')->init($this->_resource, $id)->getUploader();
                $form->html($html);
            } else {
                $form->html("<span class='text-danger'>Нельзя загружать картинки в момент создания новой записи !!!</span>");
            }
        });

        $langs = get_active_langs();
        foreach ($langs as $one) {
            $form->tab($one['name'], function (Form $form) use ($one, $id) {


                $form->html('<div class="form-group"><div class="col-md-12"><h4 class="form-header">Переводы на '.$one['name'].' язык</h4></div></div>');

                $trans_item = $form->model()->findOrNew($id);

                $translation = $trans_item->getTranslation($one['alias'], true);
                $form->hidden('translate['.$one['alias'].'][locale]', 'Алиас языка')->default($one['alias']);

                $form->text(
                    'translate['.$one['alias'].'][name]',
                    'Заголовок'
                )->default($translation ? $translation->name : old('translate.ru.name'));
                $form->textarea(
                    'translate['.$one['alias'].'][introtext]',
                    'Короткое описание'
                )->rows(4)->default($translation ? $translation->introtext : old('translate.ru.introtext'));
                $form->ckeditor(
                    'translate['.$one['alias'].'][text]',
                    'Описание'
                )->default($translation ? $translation->text : old('translate.ru.text'));
                $form->divider();
                $form->text(
                    'translate['.$one['alias'].'][seo_h1]',
                    'SEO H1'
                )->default($translation ? $translation->seo_h1 : old('translate.ru.seo_h1'));
                $form->text(
                    'translate['.$one['alias'].'][seo_title]',
                    'Meta Title'
                )->default($translation ? $translation->seo_title : old('translate.ru.seo_title'));
                $form->textarea(
                    'translate['.$one['alias'].'][seo_keywords]',
                    'Meta Keywords'
                )->rows(4)->default($translation ? $translation->seo_keywords : old('translate.ru.seo_keywords'));
                $form->textarea(
                    'translate['.$one['alias'].'][seo_description]',
                    'Meta Description'
                )->rows(4)->default($translation ? $translation->seo_description : old('translate.ru.seo_description'));
            });
        }

        $form->rightPanel('Опубликовать', function (Form $form1) {
            $form1->display('id', 'ID');
            $form1->display('created_at');
            $form1->display('updated_at');

            $statuses1 = [
                'on'  => ['value' => 1, 'text' => 'Включено', 'color' => 'success'],
                'off' => ['value' => 0, 'text' => 'Отключено', 'color' => 'danger'],
            ];
            $form1->switch('state', 'Статус')->states($statuses1);

            $form1->switch('comments_enabled', 'показать комментарии')->states($statuses1);
            // $form1->select('state', 'Статус')->options([1 => 'Включено', 0 => 'Отключено'])->config( 'allowClear',false);
        }, true, 11+(7*count($langs)));

        // callback after save
        $form->saved(function (Form $form) {
            $id = $form->model()->id;

            try {
                $trans_item = $form->model()->find($id);
                $trans_item->fill($form->translate);
                $trans_item->save();
            } catch (\Exception $e) {
                logger($e->getMessage());
            }
        });

        return $form;
    }

    /**
     * @param Content $content
     *
     * @return Content
     */
    public function create(Content $content)
    {
        $this->setTitle($this->resources[$this->_resource]['name'].' - Создать');
        $this->breadcrumbs->addCrumb('Создать', '');

        return $content
            ->header($this->resources[$this->_resource]['name'])
            ->description('Создать')
            ->body($this->form());
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     *
     * @return Content
     */
    public function show($id, Content $content)
    {
        return $content
            ->header($this->resources[$this->_resource]['name'])
            ->description('Детали')
            ->body($this->detail($id));
    }

    public function detail($id)
    {
        $show = new Show(ModNews::findOrFail($id));

        $show->log_name('Название');
        $show->alias('Алиас');
        $show->comments_enabled('показать комментарии');

        $show->divider();

        $show->state('Включено?');
        $show->created_at('Создано');
        $show->updated_at('Обновлено');

        return $show;
    }
}
