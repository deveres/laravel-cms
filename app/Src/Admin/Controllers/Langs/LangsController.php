<?php

namespace App\Src\Admin\Controllers\Langs;

use App\Http\Controllers\Controller;
use App\Src\Admin\Extensions\Core\CustomForm;
use App\Src\Admin\Extensions\Tools\SynchroLabels;
use App\Src\Models\Langs\LabelLang;
use App\Src\Services\I18nService;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;

class LangsController extends Controller
{
    use HasResourceActions;

    public $_resource = 'langs';

    public function synchroLabels()
    {
        I18nService::syncLabelsTable();
        I18nService::export();
    }

    /**+
     * @param Content $content
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

        $grid = new Grid(new LabelLang());

        $grid->id('ID')->sortable();
        $grid->name('Название')->sortable();
        $grid->alias('Алиас')->sortable();
        $grid->state('Статус')->sortable()->switch();
        $grid->default('По умолчанию')->display(function ($default) {
            return 1 === $default ? "<i class='fa fa-check' style='color:green'></i>" : "<i class='fa fa-close' style='color:red'></i>";
        })->sortable();
        $grid->ord()->orderable();
        $grid->ord1('Порядок')->display(function ($ord) {
            return $this->ord;
        })->sortable();

        $grid->tools(function ($tools) use ($can_edit) {
            if ($can_edit) {
                $tools->append(new SynchroLabels());
            }
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
        $form = new CustomForm(new LabelLang());
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
                return 'required|min:2|unique:label_langs,alias,' . (($form->model()->id) ? $form->model()->id : 0);
            });

            $form->switch('default', 'По умолчанию')->states($states);
        });

        $form->rightPanel('Опубликовать', function (Form $form1) {
            $form1->display('id', 'ID');

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
}