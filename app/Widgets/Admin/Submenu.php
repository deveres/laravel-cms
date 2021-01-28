<?php

namespace App\Widgets\Admin;

use Arrilot\Widgets\AbstractWidget;
use Encore\Admin\Facades\Admin;
use Illuminate\Support\Facades\Request;

class Submenu extends AbstractWidget
{
    /**
     * The configuration array.
     *
     * @var array
     */
    protected $config = [];
    protected $current_module = 'admincore';

    /**
     * Treat this method as a controller action.
     * Return view() or other content to display.
     */
    public function run()
    {
        $this->fetchModule();
        //
        $backend_submenu = $this->setSubmenu();

        return view('admin::widgets.submenu.submenu', [
            'backend_submenu' => $backend_submenu,
        ]);
    }

    public function setSubmenu()
    {
        $submenu_source = config('modules.'.$this->current_module.'.admin_menu');
        if (!$submenu_source) {
            return '';
        }

        $submenu = [];
        foreach ($submenu_source as $one) {
            if (Admin::user()->isAdministrator() || Admin::user()->can($this->current_module.'.'.$one['resource'].'.read')) {
                $submenu[] = $one;
            }
        }

        $uri = trim(Request::path(), '/');
        $key_selected = '';

        foreach ($submenu as $key => $one) {
            if (strpos($uri, trim($one['link'], '/')) !== false) {
                $key_selected = $key;
            }
        }

        if ($key_selected >= 0) {
            $submenu[$key_selected]['selected_item'] = 'selected';
        }

        return  $submenu;
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
}
