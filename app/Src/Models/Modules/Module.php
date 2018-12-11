<?php

namespace App\Src\Models\Modules;


use Illuminate\Database\Eloquent\Model;
use Spatie\EloquentSortable\SortableTrait;

class Module extends Model
{
    use SortableTrait;

    public $sortable = [
        'order_column_name' => 'module_order',
        'sort_when_creating' => true,
    ];

    public $incrementing = 'id';
    public $timestamps = false;

    // protected $guard = 'admin';

    protected $primaryKey = 'id';

    protected $table = 'system_modules';

    protected $guarded = ['id'];

}
