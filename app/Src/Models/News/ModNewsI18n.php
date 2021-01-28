<?php

namespace App\Src\Models\News;

use App\Src\Services\I18nService;
use Dimsav\Translatable\Translatable;
use Illuminate\Database\Eloquent\Model;

class ModNewsI18n extends Model
{

    public $incrementing = 'id';
    public $timestamps = false;
    public $fillable = ['name', 'introtext', 'text', 'seo_h1', 'seo_title', 'seo_keywords', 'seo_description'];
    protected $primaryKey = 'id';

    /**
     * ModSeo constructor.
     *
     * @param array $attributes
     */
    public function __construct(array $attributes = [])
    {
        $this->table = env('DB_TABLE_PREFIX', 'mod_').'news_i18n';

        parent::__construct($attributes);
    }


}
