<?php

namespace App\Src\Admin\Controllers\Langs;

use App\Http\Controllers\BackendController;
use App\Src\Admin\Extensions\Core\CustomForm;
use App\Src\Admin\Extensions\Grid\Tools\CreateLabelsGridTool;
use App\Src\Admin\Extensions\Grid\Widgets\FilterTree;
use App\Src\Models\Langs\Label;
use App\Src\Models\Langs\LabelCat;
use App\Src\Models\Langs\LabelLang;
use App\Src\Services\I18nService;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;
use Encore\Admin\Layout\Row;
use Input;

class LangsLabelsBackendController extends BackendController
{
    use HasResourceActions;

    public $_resource = 'langs_labels';

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
            $content->body(function (Row $row) {
                $row->column(2, $this->tree());
                $row->column(10, $this->grid());
            });
        }

        return $content;
    }

    /**
     * @return FilterTree
     */
    public function tree()
    {
        return new FilterTree(LabelCat::class, function (FilterTree $tree) {
            $tree->token('labels_tree');
            $tree->selected(Input::get('labels_tree') ?? 0);
            $tree->displayField('name');
            $tree->urlPrefix(admin_url('langs_labels'));
        });
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

        $grid = new Grid(new Label());

        $grid->parent_id('Путь')->display(function () {
            return I18nService::getLabelPath($this->parent_id).'/'.$this->label;
        })->sortable();

        if ($can_edit) {
            $grid->label('Метка')->sortable()->editable();
        } else {
            $grid->label('Метка')->sortable();
        }

        foreach (LabelLang::getActive() as $oneLang) {
            $field = 'value_'.$oneLang['id'];
            if ($can_edit) {
                $grid->{$field}($oneLang['name'])->sortable()->editable('textarea');
            } else {
                $grid->{$field}($oneLang['name'])->sortable();
            }
        }

        $grid->disableCreateButton();

        $grid->actions(function ($actions) use ($can_delete, $can_edit) {
            $actions->column->setAttributes(['class' => 'row_actions']);
            $actions->disableEdit();
            $actions->disableView();

            if (!$can_delete) {
                $actions->disableDelete();
            }
        });

        if (!$can_delete) {
            $grid->disableRowSelector();
        }

        if ($can_create) {
            $grid->tools(function ($tools) {
                $tools->append(new CreateLabelsGridTool(request('labels_tree', 0)));
            });
        }

        $grid->filter(function ($filter) {
            // Remove the default id filter
            $filter->disableIdFilter();

            // Add a column filter
            $filter->where(function ($query) {
                $langs = get_active_langs();
                $input = $this->input;

                $query->where('label', 'LIKE', $input.'%');
                foreach ($langs as $lang) {
                    $query->orWhere('value_'.$lang['id'], 'LIKE', $input.'%');
                }
            }, 'Метка', 'label_val');
        });

        $label_tree = Input::get('labels_tree');
        if ($label_tree > 0) {
            $grid->model()->where('parent_id', $label_tree);
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
     * @param int $id
     *
     * @return CustomForm
     */
    protected function form($id = 0)
    {
        $form = new CustomForm(new Label());
        $form->disableViewCheck();
        $form->disableEditingCheck();

        $form->tools(function (Form\Tools $tools) {
            // Disable `Veiw` btn.
            $tools->disableView();
        });

        $form->display('id', 'ID');
        $form->hidden('parent_id');
        $langs = get_active_langs();
        foreach ($langs as $one) {
            $form->hidden('value_'.$one['id']);
        }

        $form->text('label')->rules(
            function ($form) {
                return 'required|regex:/^[a-zA-Z0-9\-\_]+$/ui|min:3|max:150|unique_by_parent:labels,label,'.(($form->model()->id) ? $form->model()->id : 0).',id,parent_id,'.$form->model()->parent_id;
            },
            [
                'required'         => 'Алиас метки не может быть пустым',
                'regex'            => 'Алиас метки может содержать буквы английского алфавита(a-zA-Z), цифры(0-9), тире(-) и знак подчёркивания(_)',
                'min'              => 'Алиас должен иметь минимум 3 символа',
                'max'              => 'Алиас должен иметь не  более 150 символов',
                'unique_by_parent' => 'Метка с таким алиасом в этой директории уже существует',
            ]
        );

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

        $content->header($this->resources[$this->_resource]['name'])
            ->description('Создать');

        if ($this->lCheckPermission('create')) {
            $content->body($this->form());
        }

        return $content;
    }
}
