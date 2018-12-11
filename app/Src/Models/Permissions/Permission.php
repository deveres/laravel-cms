<?php

namespace App\Src\Models\Permissions;

use Encore\Admin\Auth\Database\Permission as EncorePermissions;

class Permission extends EncorePermissions
{
    /**
     * @var array
     */
    protected $fillable = ['name', 'cat_id', 'slug', 'http_method', 'http_path'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function category()
    {
        return $this->belongsTo('App\Src\Models\Permissions\PermissionCategory', 'cat_id');
    }
}
