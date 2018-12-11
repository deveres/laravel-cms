<?php

namespace App\Src\Admin\Controllers\Langs;

use App\Http\Controllers\Controller;
use App\Src\Admin\Extensions\Core\CustomForm;
use App\Src\Models\Langs\LabelCat;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;
use GuzzleHttp\Psr7\Request;

class LangsCatsController extends Controller
{
    use HasResourceActions;

    public $_resource = 'langs_cats';

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
        // return LabelCat::tree();

        $can_delete = $this->lCheckPermission('delete');
        $can_edit = $this->lCheckPermission('update');
        $can_create = $this->lCheckPermission('create');

        $grid = new Grid(new LabelCat());

        $grid->id('ID')->setAttributes(['style' => 'width:20px;']);
        $grid->name('Название')->treeName(
            $grid,
            'langs_labels.index',
            'labels_tree'
        )->setAttributes(['style' => 'width:auto;']);
        $grid->alias('Алиас')->setAttributes(['style' => 'width:auto;']);

        $grid->model()->collection(function (\Illuminate\Database\Eloquent\Collection $data) {
            return app(LabelCat::class)->fetchTree();
        });

        $grid->ord1(' ')->rowOrderable($grid, route('row-orderable'))->setAttributes(['style' => 'width:20px;']);
        $grid->state('Статус')->switch()->setAttributes(['style' => 'width:80px;']);

        $grid->model()->orderBy('ord', 'asc');
        $grid->disablePagination();

        $grid->actions(function ($actions) use ($can_delete, $can_edit) {
            $actions->disableView();

            if (!$can_delete) {
                $actions->disableDelete();
            }
            if (!$can_edit) {
                $actions->disableEdit();
            }

            $actions->column->setAttributes(['class' => 'row_actions', 'style' => 'width:180px;']);
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
     * @param int $id
     * @param Content $content
     * @return Content
     */
    public function edit($id, Content $content)
    {
        $this->setTitle($this->resources[$this->_resource]['name'] . ' - Редактирование');
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
        $form = new CustomForm(new LabelCat());
        $form->disableViewCheck();
        $form->disableEditingCheck();

        $form->tools(function (Form\Tools $tools) {
            // Disable `Veiw` btn.
            $tools->disableView();
        });

        $form->tab('Общее', function (Form $form) use ($id) {
            $form->htmlFull('<h4 class="form-header">Основная информация</h4>');

            $states = [
                'on' => ['value' => 1, 'text' => 'Да', 'color' => 'success'],
                'off' => ['value' => 0, 'text' => 'Нет', 'color' => 'danger'],
            ];

            $form->display('id', 'ID');
            $form->text('name', 'Название')->rules('required|min:3');
            $form->text('alias', 'Алиас')->rules(function ($form) {
                return 'required|min:2|unique:label_cats,alias,' . (($form->model()->id) ? $form->model()->id : 0);
            });

            $form->select('parent_id', 'Родительская категория')->default(0)->options(function ($id) use ($form) {
                $collect = LabelCat::query()->where('id', '<>', $form->model()->id)->pluck('name', 'id')->toArray();
                $collect[0] = 'Корневая';
                ksort($collect);

                return $collect;
            })->rules(function ($form) {
                return 'required';
            });
        });

        $form->rightPanel('Опубликовать', function (Form $form1) {
            $form1->display('id', 'ID');
            $form1->display('created_at');
            $form1->display('updated_at');

            $statuses1 = [
                'on' => ['value' => 1, 'text' => 'Включено', 'color' => 'success'],
                'off' => ['value' => 0, 'text' => 'Отключено', 'color' => 'danger'],
            ];
            $form1->switch('state', 'Статус')->states($statuses1);
        }, true);

        return $form;
    }

    /**
     * @param Content $content
     *
     * @return Content
     */
    public function create(Content $content)
    {
        $this->setTitle($this->resources[$this->_resource]['name'] . ' - Создать');
        $this->breadcrumbs->addCrumb('Создать', '');

        $content->header($this->resources[$this->_resource]['name'])
            ->description('Создать');

        if ($this->lCheckPermission('create')) {
            $content->body($this->form());
        }

        return $content;
    }

    /**
     * сортировка.
     */
    public function rowOrderable()
    {
        $cats = request()->get('items', []);

        $counter = 1;
        foreach ($cats as $item) {
            $id = (int)substr($item, 3);
            if (!$id) {
                continue;
            }

            $cat = LabelCat::query()->find($id);
            $cat->{$cat->getOrderColumn()} = $counter;
            $cat->save();
            ++$counter;
        }
    }
}