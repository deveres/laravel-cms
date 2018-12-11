<?php

namespace App\Src\Admin\Controllers\Permissions;

use App\Src\Models\Permissions\PermissionCategory;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;
use Encore\Admin\Show;
use Illuminate\Support\Str;

class PermissionController extends \Encore\Admin\Controllers\PermissionController
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
            ->header(trans('admin.permissions'))
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
        $permissionModel = config('admin.database.permissions_model');

        $grid = new Grid(new $permissionModel());

        $grid->option('grid_mini_filter', [
            'Admin\GridMiniFilter' => [
                'model_name'   => $permissionModel,
                'url'          => '/'.request()->route()->uri(),
                'field_name'   => 'cat_id',
                'param_name'   => 'cat_id',
                'param_values' => PermissionCategory::query()->pluck('name',
                    'id')->toArray(),
            ],
        ]);

        $grid->id('ID')->sortable();
        $grid->cat_id('Категория')->display(function ($userId) {
            return '<strong style="color:maroon">'.PermissionCategory::find($userId)->name.'</strong>';
        });
        $grid->slug(trans('admin.slug'));

        $grid->name(trans('admin.name'));

        $grid->http_path(trans('admin.route'))->display(function ($path) {
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

                $path = '/'.trim(config('admin.route.prefix'), '/').$path;

                return "<div style='margin-bottom: 5px;'>$method<code>$path</code></div>";
            })->implode('');
        });

        $grid->created_at(trans('admin.created_at'));
        $grid->updated_at(trans('admin.updated_at'));

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
            }, 'Категория', 'cat_id')->select(['0' => 'Все'] + PermissionCategory::query()->pluck('name',
                    'id')->toArray());
        });

        //$grid->expandFilter();

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
            ->header(trans('admin.permissions'))
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
        $permissionModel = config('admin.database.permissions_model');

        $show = new Show($permissionModel::findOrFail($id));

        $show->id('ID');
        $show->cat_id('Категория');
        $show->slug(trans('admin.slug'));
        $show->name(trans('admin.name'));

        $show->http_path(trans('admin.route'))->as(function ($path) {
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

                $path = '/'.trim(config('admin.route.prefix'), '/').$path;

                return "<div style='margin-bottom: 5px;'>$method<code>$path</code></div>";
            })->implode('');
        });

        $show->created_at(trans('admin.created_at'));
        $show->updated_at(trans('admin.updated_at'));

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
            ->header(trans('admin.permissions'))
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
        $permissionModel = config('admin.database.permissions_model');

        $form = new Form(new $permissionModel());

        $form->display('id', 'ID');
        $form->select('cat_id', 'Категория')->options(PermissionCategory::query()->pluck('name',
            'id'))->rules('required', ['required' => 'Поле обязательно для заполнения']);
        $form->text('slug', trans('admin.slug'))->rules('required');
        $form->text('name', trans('admin.name'))->rules('required');

        $form->multipleSelect('http_method', trans('admin.http.method'))
            ->options($this->getHttpMethodsOptions())
            ->help(trans('admin.all_methods_if_empty'));
        $form->textarea('http_path', trans('admin.http.path'));

        $form->display('created_at', trans('admin.created_at'));
        $form->display('updated_at', trans('admin.updated_at'));

        return $form;
    }

    /**
     * Get options of HTTP methods select field.
     *
     * @return array
     */
    protected function getHttpMethodsOptions()
    {
        $permissionModel = config('admin.database.permissions_model');

        return array_combine($permissionModel::$httpMethods, $permissionModel::$httpMethods);
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
            ->header(trans('admin.permissions'))
            ->description(trans('admin.create'))
            ->body($this->form());
    }
}
