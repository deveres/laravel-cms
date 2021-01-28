<?php

namespace App\Src\Models\Menu;


use Encore\Admin\Auth\Database\Menu as EncoreMenu;

/**
 * Class Menu.
 *
 * @property int $id
 *
 * @method where($parent_id, $id)
 */
class Menu extends EncoreMenu
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['parent_id', 'order', 'title', 'icon', 'uri', 'permission', 'icon_color'];


}
