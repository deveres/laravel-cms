<?php

namespace App\Src\Models\Seo;


use Encore\Admin\Traits\DefaultDatetimeFormat;
use Illuminate\Database\Eloquent\Model;
use Astrotomic\Translatable\Contracts\Translatable as TranslatableContract;
use Astrotomic\Translatable\Translatable;

class ModSeo extends Model implements TranslatableContract
{

    use Translatable;
    use DefaultDatetimeFormat;


    public $translationModel = 'App\Src\Models\Seo\ModSeoI18n';

    public $translationForeignKey = 'row_id';

    public $incrementing = 'id';
    public $timestamps = true;

    public $dates = ['created_at', 'updated_at'];


    // protected $guard = 'admin';
    public $translatedAttributes = ['introtext', 'text', 'seo_h1', 'seo_title', 'seo_keywords', 'seo_description'];
    protected $primaryKey = 'id';
    protected $fillable = ['log_name', 'alias', 'link', 'state', 'lock_alias'];

    /**
     * ModSeo constructor.
     * @param array $attributes
     */
    public function __construct(array $attributes = [])
    {
        $this->table = env('DB_TABLE_PREFIX', 'mod_') . 'seo';

        parent::__construct($attributes);
    }

    protected static function boot()
    {
        parent::boot();

        static::deleted(function (self $item) {
            if ($item->attributes['id']) {
                app('images.photo')->deleteItemImages('seo', $item->attributes['id']);
            }

            return true;
        });
    }


}
