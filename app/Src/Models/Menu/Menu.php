<?php

namespace App\Src\Models\Menu;
use Encore\Admin\Auth\Database\Menu as AdminMenu;


/**
 * Class Menu.
 *
 * @property int $id
 *
 * @method where($parent_id, $id)
 */
class Menu extends AdminMenu
{


    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['parent_id', 'order', 'title', 'icon', 'icon_color', 'uri', 'permission'];


}
