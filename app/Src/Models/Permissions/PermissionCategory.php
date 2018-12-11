<?php

namespace App\Src\Models\Permissions;

use Illuminate\Database\Eloquent\Model;

class PermissionCategory extends Model
{
    public $timestamps = false;

    public $table = 'admin_permissions_categories';
    /**
     * @var array
     */
    protected $fillable = ['name'];
}
