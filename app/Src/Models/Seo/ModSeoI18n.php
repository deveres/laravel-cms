<?php

namespace App\Src\Models\Seo;

use Illuminate\Database\Eloquent\Model;

class ModSeoI18n extends Model
{
    public $incrementing = 'id';
    public $timestamps = false;
    public $fillable = ['introtext', 'text', 'seo_h1', 'seo_title', 'seo_keywords', 'seo_description'];
    protected $primaryKey = 'id';

    /**
     * ModSeo constructor.
     *
     * @param array $attributes
     */
    public function __construct(array $attributes = [])
    {
        $this->table = env('DB_TABLE_PREFIX', 'mod_').'seo_i18n';

        parent::__construct($attributes);
    }
}
