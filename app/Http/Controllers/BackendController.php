<?php

namespace App\Http\Controllers;

use Encore\Admin\Facades\Admin;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class BackendController extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public $view = null;
    public $current_module = null;
    public $resources = '';
    public $_resource = '';

    /**
     * Create a new controller instance.
     *  all admin controllers must extends this controller.
     *
     * @return void
     */
    public function __construct()
    {
        $this->view = view();

        $this->breadcrumbs = app('backend.breadcrumbs');

        $this->fetchModule();

        $this->_setBreadCrumbs();
        $this->_setCurrentResources();

        $this->setTitle('', '');
    }

    public function fetchModule()
    {
        $module = '';
        if (request()->route()) {
            $segments = request()->segments();
            if ($segments) {
                $segments = array_diff($segments, [config('admin.route.prefix')]);
                $first = array_shift($segments);
                $first = explode('_', $first);
                $first_element = array_shift($first);

                if (config('modules.'.$first_element)) {
                    $module = config('modules.'.$first_element)['path'];
                }
            }
        }
        if ($module == '') {
            $module = 'admincore';
        }

        $this->current_module = $module;
    }

    private function _setBreadCrumbs()
    {
        if ($this->current_module) {
            $admin_menu = config('modules.'.$this->current_module.'.admin_menu');
            $module_config = config('modules.'.$this->current_module);

            if ($module_config['path']) {
                $this->breadcrumbs->addCrumb($module_config['name'], route(config('admin.route.prefix').'.'.$module_config['path'].'.index'));
            }
        }
        /*
                $selected_item = Arrays::first(Arrays::FilterValues($admin_menu, 'resource', '=', $this->_resource));
                if (sizeof($selected_item) && $this->_resource != $module_config['view_label']) {
                    $this->breadcrumbs->addCrumb($selected_item['title'], $selected_item['link']);


                }*/
    }

    public function _setCurrentResources()
    {
        $this->resources = (config('modules.'.$this->current_module.'.resources'));
    }

    public function setTitle($title = '', $subtitle = '')
    {
        $this->view->share('htmlheader_title', ($title) ? (' - '.$title) : '');
        $this->view->share('site_subtitle', $subtitle);
    }

    /**
     * @param string $permission
     *
     * @return bool
     */
    public function lCheckPermission($permission = 'read')
    {
        if ($permission) {
            return Admin::user()->can($this->makePermission($permission));
        }

        return false;
    }

    /**
     * @param array $segments
     *
     * @return array|string
     */
    public function makePermission($permission = '', $segments = [])
    {
        if (is_array($segments) && count($segments) == 0) {
            if ($this->current_module) {
                $segments[] = $this->current_module;
            }
            if ($this->_resource) {
                $segments[] = $this->_resource;
            }
        }

        $ret = implode('.', array_merge($segments, [$permission]));

        return $ret;
    }
}
