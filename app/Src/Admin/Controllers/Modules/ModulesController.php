<?php

namespace App\Src\Admin\Controllers\Modules;

use App\Http\Controllers\Controller;
use App\Src\Admin\Extensions\Core\CustomForm;
use App\Src\Admin\Services\AdminMenuService;
use App\Src\Models\Modules\Module;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Grid\Filter;
use Encore\Admin\Layout\Content;
use Illuminate\Http\Request;

class ModulesController extends Controller
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

    public function install(Request $request)
    {
        $id = $request->get('id', 0);
        $module = Module::query()->find($id);
        if (!$module) {
            return response()->json();
        }

        if (AdminMenuService::installModuleMenu($module)) {
            $module->state = 1;
            $module->save();
        }
    }

    /**
     * Index interface.
     *
     * @return Content
     */
    public function index(Content $content)
    {
        $this->synchronizeModules();
        $this->setTitle($this->resources[$this->_resource]['name']);

        $content->header($this->resources[$this->_resource]['name'])
            ->description($this->resources[$this->_resource]['description']);

        if ($this->lCheckPermission('read')) {
            $content->body($this->grid());
        }

        return $content;
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
            if (1 === $state) {
                return "<span class='label label-success'>Установлен</span>";
            }

            return "<span class='label label-info'>Не установлен</span>";
        });

        //$grid->ord1(' ')->rowOrderable($grid, route('row-orderable'))->setAttributes(['style'=>'width:20px;']);

        if ($this->lCheckPermission('update')) {
            $grid->install('Установка')->moduleInstall($grid)->setAttributes(['style' => 'width:20px;']);
        }

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
    protected function form($id = 0)
    {
        $form = new CustomForm(new Module());
        $form->disableViewCheck();
        $form->disableEditingCheck();

        $form->tools(function (Form\Tools $tools) {
            // Disable `Veiw` btn.
            $tools->disableView();
        });

        $statuses1 = [
            'on'  => ['value' => 1, 'text' => 'Включено', 'color' => 'success'],
            'off' => ['value' => 0, 'text' => 'Отключено', 'color' => 'danger'],
        ];

        $form->display('id', 'ID');

        $form->switch('state', 'Статус')->states($statuses1);

        return $form;
    }
}
