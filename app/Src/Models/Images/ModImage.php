<?php

namespace App\Src\Models\Images;

use Illuminate\Database\Eloquent\Model;


class ModImage extends Model
{
    // protected $guard = 'admin';

    public $incrementing = 'id';
    public $timestamps = false;
    public $parent_field = '';
    public $order = 'id';
    public $orderway = 'DESC';  // сортировка по умолчанию в гриде
        protected $primaryKey = 'id';  // сортировка по умолчанию в гриде
    protected $table = 'images';

    protected $fillable = ['item_id', 'mnodule', 'main', 'img', 'filename', 'alt', 'disk'];

    /**
     * ModSeo constructor.
     * @param array $attributes
     */
    public function __construct(array $attributes = [])
    {
        $this->table = env('DB_TABLE_PREFIX', 'mod_') . 'images';

        parent::__construct($attributes);
    }

}
