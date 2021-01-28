<?php

namespace App\Src\Admin\Controllers\Permissions;

use App\Src\Models\Permissions\PermissionCategory;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;
use Illuminate\Support\Str;

class PermissionController extends \Encore\Admin\Controllers\PermissionController
{
    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $permissionModel = config('admin.database.permissions_model');

        $grid = new Grid(new $permissionModel());

        $grid->option('grid_mini_filter', [
            'Admin\GridMiniFilter' => [
                'model_name'   => $permissionModel,
                'url'          => '/'.request()->route()->uri(),
                'field_name'   => 'cat_id',
                'param_name'   => 'cat_id',
                'param_values' => PermissionCategory::query()->pluck(
                    'name',
                    'id'
                )->toArray(),
            ],
        ]);

        $grid->column('id', 'ID')->sortable();
        $grid->cat_id('Категория')->display(function ($userId) {
            return '<strong style="color:maroon">'.PermissionCategory::find($userId)->name.'</strong>';
        });
        $grid->column('slug', trans('admin.slug'));
        $grid->column('name', trans('admin.name'));

        $grid->column('http_path', trans('admin.route'))->display(function ($path) {
            return collect(explode("\n", $path))->map(function ($path) {
                $method = $this->http_method ?: ['ANY'];

                if (Str::contains($path, ':')) {
                    list($method, $path) = explode(':', $path);
                    $method = explode(',', $method);
                }

                $method = collect($method)->map(function ($name) {
                    return strtoupper($name);
                })->map(function ($name) {
                    return "<span class='label label-primary'>{$name}</span>";
                })->implode('&nbsp;');

                if (!empty(config('admin.route.prefix'))) {
                    $path = '/'.trim(config('admin.route.prefix'), '/').$path;
                }

                return "<div style='margin-bottom: 5px;'>$method<code>$path</code></div>";
            })->implode('');
        });

        $grid->column('created_at', trans('admin.created_at'));
        $grid->column('updated_at', trans('admin.updated_at'));

        $grid->tools(function (Grid\Tools $tools) {
            $tools->batch(function (Grid\Tools\BatchActions $actions) {
                $actions->disableDelete();
            });
        });

        $grid->filter(function ($filter) {
            $filter->where(function ($query) {
                if ($this->input > 0) {
                    $query->where('cat_id', $this->input);
                }
            }, 'Категория', 'cat_id')->select(['0' => 'Все'] + PermissionCategory::query()->pluck(
                'name',
                'id'
            )->toArray());
        });

        $grid->actions(function ($actions) {
            $actions->column->setAttributes(['class' => 'row_actions']);
        });

        return $grid;
    }

    protected function detail($id)
    {
        $permissionModel = config('admin.database.permissions_model');

        $show = new Show($permissionModel::findOrFail($id));

        $show->field('id', 'ID');
        $show->cat_id('Категория');
        $show->field('slug', trans('admin.slug'));
        $show->field('name', trans('admin.name'));

        $show->field('http_path', trans('admin.route'))->unescape()->as(function ($path) {
            return collect(explode("\r\n", $path))->map(function ($path) {
                $method = $this->http_method ?: ['ANY'];

                if (Str::contains($path, ':')) {
                    list($method, $path) = explode(':', $path);
                    $method = explode(',', $method);
                }

                $method = collect($method)->map(function ($name) {
                    return strtoupper($name);
                })->map(function ($name) {
                    return "<span class='label label-primary'>{$name}</span>";
                })->implode('&nbsp;');

                if (!empty(config('admin.route.prefix'))) {
                    $path = '/'.trim(config('admin.route.prefix'), '/').$path;
                }

                return "<div style='margin-bottom: 5px;'>$method<code>$path</code></div>";
            })->implode('');
        });

        $show->field('created_at', trans('admin.created_at'));
        $show->field('updated_at', trans('admin.updated_at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    public function form()
    {
        $permissionModel = config('admin.database.permissions_model');

        $form = new Form(new $permissionModel());

        $form->tab('Общее', function (Form $form) {
            $form->display('id', 'ID');

            $form->text('slug', trans('admin.slug'))->rules('required');
            $form->select('cat_id', 'Категория')->options(PermissionCategory::query()->pluck(
                'name',
                'id'
            ))->rules('required', ['required' => 'Поле обязательно для заполнения']);
            $form->text('name', trans('admin.name'))->rules('required');

            $form->multipleSelect('http_method', trans('admin.http.method'))
                ->options($this->getHttpMethodsOptions())
                ->help(trans('admin.all_methods_if_empty'));
            $form->textarea('http_path', trans('admin.http.path'));

            $form->display('created_at', trans('admin.created_at'));
            $form->display('updated_at', trans('admin.updated_at'));
        });

        return $form;
    }
}
