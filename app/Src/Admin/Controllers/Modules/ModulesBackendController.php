<?php

namespace App\Src\Admin\Controllers\Modules;

use App\Http\Controllers\BackendController;
use App\Src\Admin\Extensions\Grid\RowActions\ModuleInstallGridRowAction;
use App\Src\Models\Modules\Module;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Grid\Filter;
use Encore\Admin\Layout\Content;

class ModulesBackendController extends BackendController
{
    use HasResourceActions;

    public $_resource = 'modules';

    /**
     * сортировка.
     */
    public function rowOrderable()
    {
        $cats = request()->get('items', []);

        $counter = 1;
        foreach ($cats as $item) {
            $id = (int) substr($item, 3);
            if (!$id) {
                continue;
            }

            $cat = Module::query()->find($id);
            $cat->{$cat->sortable['order_column_name']} = $counter;
            $cat->save();
            $counter++;
        }
    }

    /**
     * @param Content $content
     *
     * @return Content
     */
    protected function index(Content $content)
    {
        $this->synchronizeModules();
        $this->setTitle($this->resources[$this->_resource]['name']);

        return $content->header($this->resources[$this->_resource]['name'])
            ->description($this->resources[$this->_resource]['description'])
            ->body($this->grid());
    }

    /**
     * Synchronize modules with DB.
     */
    public function synchronizeModules()
    {
        $config = config('modules');
        foreach ($config as $key => $one_conf) {
            $module = Module::query()->where('key', $key)->get()->toArray();

            if (!$module && !empty($one_conf['name']) && !empty($one_conf['path'])) {
                $module = new Module([

                    'key'         => $key,
                    'path'        => $one_conf['path'],
                    'name'        => $one_conf['name'],
                    'icon'        => !empty($one_conf['icon']) ? $one_conf['icon'] : '',
                    'icon_color'  => !empty($one_conf['icon_color']) ? $one_conf['icon_color'] : '',
                    'description' => !empty($one_conf['description']) ? $one_conf['description'] : '',
                    'state'       => 0,
                ]);
                $module->save();
            }
        }
    }

    /**
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new Module());

        $grid->model()->orderBy('id', 'DESC');

        $grid->paginate(20);

        $grid->id('ID')->sortable()->setAttributes(['style' => 'width:40px;']);
        $grid->key('Алиас')->sortable();
        $grid->name('Название')->sortable();

        //$grid->state('Статус(не используется)')->sortable()->switch();
        $grid->state('Статус')->display(function ($state) {
            if ($state == 1) {
                return "<span class='label label-success'>Установлен</span>";
            } else {
                return "<span class='label label-info'>Не установлен</span>";
            }
        });

        //$grid->ord1(' ')->rowOrderable($grid, route('row-orderable'))->setAttributes(['style'=>'width:20px;']);

        $grid->install('Установка')->action(ModuleInstallGridRowAction::class)->setAttributes(['style' => 'width:20px;']);

        $grid->tools(function ($tools) {
            // $tools->append(new SynchroLabels());
        });

        $grid->actions(function (Grid\Displayers\Actions $actions) {
            $actions->disableDelete();
            $actions->disableEdit();
        });

        $grid->disableExport();
        $grid->disableCreateButton();
        $grid->disableRowSelector();
        $grid->disableActions();
        //$grid->expandFilter();

        $grid->filter(function (Filter $filter) {
            $filter->disableIdFilter();
            $filter->like('name');
        });

        return $grid;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Admin::form(Module::class, function (Form $form) {
            $statuses1 = [
                'on'  => ['value' => 1, 'text' => 'Включено', 'color' => 'success'],
                'off' => ['value' => 0, 'text' => 'Отключено', 'color' => 'danger'],
            ];

            $form->display('id', 'ID');

            $form->switch('state', 'Статус')->states($statuses1);

            // $form->display('created_at', 'Created At');
            // $form->display('updated_at', 'Updated At');
        });
    }
}
