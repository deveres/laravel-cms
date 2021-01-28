<?php

namespace App\Src\Admin\Services;

use App\Src\Models\Modules\Module;
use App\Src\Models\Permissions\PermissionCategory;
use Encore\Admin\Auth\Database\Menu;

class AdminMenuService
{
    const CRUD = ['create', 'read', 'update', 'delete'];

    /**
     * @param Module $module
     *
     * @return bool
     */
    public static function installModuleMenu(Module $module)
    {
        $lastOrder = Menu::max('order');

        $rootMenu = [
            'parent_id'  => 0,
            'order'      => $lastOrder++,
            'title'      => $module->name,
            'icon'       => !empty($module->icon) ? $module->icon : 'fa-info',
            'icon_color' => !empty($module->icon_color) ? $module->icon_color : '#ffb600',
            'uri'        => '',
        ];

        $root = self::getMenu($module->name, 0);

        if (!$root) {
            $root = Menu::create($rootMenu);
        }

        self::addPermission($module->name, $module->key.'.index', $module->path, $module->name);

        $config = config('modules.'.$module->key.'.resources');

        foreach ($config as $key => $one_resource) {
            $menu = [
                'title'      => $one_resource['name'],
                'icon'       => !empty($one_resource['icon']) ? $one_resource['icon'] : $rootMenu['icon'],
                'icon_color' => !empty($one_resource['icon_color']) ? $one_resource['icon_color'] : $rootMenu['icon_color'],
                'uri'        => '/'.$key,
                'parent_id'  => $root->id,
                'order'      => $lastOrder++,
            ];

            $exist = self::getMenu($menu['title'], $menu['parent_id']);
            if (!$exist) {
                Menu::create($menu);
            }
            foreach (self::CRUD as $crud) {
                $permission = $module->key.'.'.$key.'.'.$crud;
                $pTitle = $rootMenu['title'].'-'.$menu['title'].'-'.$crud;
                self::addPermission($pTitle, $permission, $key, $module->name);
            }
        }

        return true;
    }

    /**
     * @param string $title
     * @param string $parent_id
     *
     * @return null|\Illuminate\Database\Eloquent\Model|static
     */
    public static function getMenu($title = '', $parent_id = '')
    {
        $q = Menu::query()->where('title', $title);
        if ($parent_id >= 0) {
            $q->where('parent_id', $parent_id);
        }

        return $q->first();
    }

    /**
     * @param string $name
     * @param string $key
     * @param string $path
     * @param string $category_name
     *
     * @return null
     */
    public static function addPermission($name = '', $key = '', $path = '', $category_name = 'General')
    {
        if (empty($name) || empty($key) || empty($path)) {
            return;
        }

        $permissionModel = config('admin.database.permissions_model');

        $permissionCategory = PermissionCategory::firstOrNew([
            'name' => $category_name,
        ]);
        $permissionCategory->save();

        $permission = $permissionModel::firstOrNew([
            'name'      => $name,
            'slug'      => $key,
            'http_path' => '/'.trim($path.'*', '/'),
        ]);
        $permission->cat_id = $permissionCategory->id;
        $permission->save();
    }
}
