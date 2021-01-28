<?php

namespace App\Src\Models\Permissions;

use Encore\Admin\Traits\DefaultDatetimeFormat;
use Illuminate\Database\Eloquent\Model;

class PermissionCategory extends Model
{
    use DefaultDatetimeFormat;

    public $timestamps = false;

    public $table = 'admin_permissions_categories';
    /**
     * @var array
     */
    protected $fillable = ['name'];
}
