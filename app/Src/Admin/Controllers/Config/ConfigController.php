<?php

namespace App\Src\Admin\Controllers\Config;

use App\Src\Admin\Extensions\Core\CustomForm;
use Encore\Admin\Config\ConfigModel;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Layout\Content;
use Encore\Admin\Show;

class ConfigController
{
    use HasResourceActions;

    /**
     * Index interface.
     *
     * @return Content
     */
    public function index(Content $content)
    {
        return $content
            ->header('Config')
            ->description('list')
            ->body($this->grid());
    }

    public function grid()
    {
        $grid = new Grid(new ConfigModel());

        $grid->option('grid_mini_filter', [
            'Admin\GridMiniFilter' => [
                'model_name'   => ConfigModel::class,
                'url'          => '/'.request()->route()->uri(),
                'field_name'   => 'category',
                'param_name'   => 'category',
                'param_values' => config('admin.extensions.config.categories', []),
            ],
        ]);

        $grid->id('ID')->sortable();
        $grid->category('Категория')->display(function ($category) {
            $conf = config('admin.extensions.config.categories', []);

            return '<span style="color:darkorange">'.$conf[$category].'</span>';
        });
        $grid->name()->display(function ($name) {
            return "<a tabindex=\"0\" class=\"btn btn-xs btn-twitter\" role=\"button\" data-toggle=\"popover\" data-html=true title=\"Usage\" data-content=\"<code>config('$name');</code>\">$name</a>";
        });
        $grid->value();
        $grid->description();

        $grid->created_at();
        $grid->updated_at();

        $grid->actions(function ($actions) {
            $actions->disableView();

            $actions->column->setAttributes(['class' => 'row_actions']);
        });

        $grid->filter(function ($filter) {
            $filter->disableIdFilter();
            $filter->like('name');
            $filter->like('value');

            $filter->where(function ($query) {
                if ($this->input != '0') {
                    $query->where('category', $this->input);
                }
            }, 'Категория', 'category')->select(['0' => 'Все'] + config('admin.extensions.config.categories', []));
        });

        //$grid->expandFilter();

        return $grid;
    }

    /**
     * Edit interface.
     *
     * @param int     $id
     * @param Content $content
     *
     * @return Content
     */
    public function edit($id, Content $content)
    {
        return $content
            ->header('Config')
            ->description('edit')
            ->body($this->form($id)->edit($id));
    }

    public function form($id = 0)
    {
        $form = new CustomForm(new ConfigModel());
        $form->disableViewCheck();
        $form->disableEditingCheck();

        $form->tools(function (Form\Tools $tools) {
            // Disable `Veiw` btn.
            $tools->disableView();
        });

        $form->tab('Общее', function (Form $form) use ($id) {
            $form->htmlFull('<h4 class="form-header">Основная информация</h4>');

            $form->display('id', 'ID');
            $form->select('category', 'Категория')->options(config('admin.extensions.config.categories',
                []))->rules('required', ['required' => 'Поле обязательно для заполнения']);
            $form->text('name')->rules('required');
            $form->textarea('value')->rules('required');
            $form->textarea('description');
        });

        $form->rightPanel('Опубликовать', function (Form $form1) {
            $form1->display('id', 'ID');
            $form1->display('created_at');
            $form1->display('updated_at');
        }, true);

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
            ->header('Config')
            ->description('create')
            ->body($this->form());
    }

    public function show($id, Content $content)
    {
        return $content
            ->header('Config')
            ->description('detail')
            ->body(Admin::show(ConfigModel::findOrFail($id), function (Show $show) {
                $show->id();
                $show->category();
                $show->name();
                $show->value();
                $show->description();
                $show->created_at();
                $show->updated_at();
            }));
    }
}
