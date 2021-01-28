<?php

namespace App\Src\Admin\Controllers\Permissions;

use App\Http\Controllers\BackendController;
use App\Src\Models\Permissions\PermissionCategory;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;
use Encore\Admin\Show;

class PermissionCategoriesController extends BackendController
{
    use HasResourceActions;

    /**
     * Index interface.
     *
     * @param Content $content
     *
     * @return Content
     */
    public function index(Content $content)
    {
        return $content
            ->header(trans('admin.permissions_category'))
            ->description(trans('admin.list'))
            ->body($this->grid()->render());
    }

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new PermissionCategory());

        $grid->id('ID')->sortable();

        $grid->name(trans('admin.name'));

        $grid->tools(function (Grid\Tools $tools) {
            $tools->batch(function (Grid\Tools\BatchActions $actions) {
                $actions->disableDelete();
            });
        });

        $grid->actions(function ($actions) {
            $actions->disableView();

            $actions->column->setAttributes(['class' => 'row_actions']);
        });

        return $grid;
    }

    /**
     * Show interface.
     *
     * @param mixed   $id
     * @param Content $content
     *
     * @return Content
     */
    public function show($id, Content $content)
    {
        return $content
            ->header(trans('admin.permissions_category'))
            ->description(trans('admin.detail'))
            ->body($this->detail($id));
    }

    /**
     * Make a show builder.
     *
     * @param mixed $id
     *
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(PermissionCategory::findOrFail($id));

        $show->id('ID');

        $show->name(trans('admin.name'));

        return $show;
    }

    /**
     * Edit interface.
     *
     * @param $id
     * @param Content $content
     *
     * @return Content
     */
    public function edit($id, Content $content)
    {
        return $content
            ->header(trans('admin.permissions_category'))
            ->description(trans('admin.edit'))
            ->body($this->form()->edit($id));
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    public function form()
    {
        $form = new Form(new PermissionCategory());
        $form->tab('Общее', function (Form $form) {
            $form->display('id', 'ID');

            $form->text('name', trans('admin.name'))->rules('required');
        });

        return $form;
    }

    /**
     * Create interface.
     *
     * @param Content $content
     *
     * @return Content
     */
    public function create(Content $content)
    {
        return $content
            ->header(trans('admin.permissions_category'))
            ->description(trans('admin.create'))
            ->body($this->form());
    }
}
