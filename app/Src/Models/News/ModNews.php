<?php

namespace App\Src\Models\News;

use App\Src\Models\Images\ModImage;
use Astrotomic\Translatable\Contracts\Translatable as TranslatableContract;
use Astrotomic\Translatable\Translatable;
use Encore\Admin\Traits\DefaultDatetimeFormat;
use Illuminate\Database\Eloquent\Model;

class ModNews extends Model implements TranslatableContract
{
    use Translatable;
    use DefaultDatetimeFormat;

    /** @var string translation model */
    public $translationModel = 'App\Src\Models\News\ModNewsI18n';

    public $translationForeignKey = 'row_id';

    /** @var array translated fields */
    public $translatedAttributes = [
        'name',
        'introtext',
        'text',
        'seo_h1',
        'seo_title',
        'seo_keywords',
        'seo_description',
    ];

    public $incrementing = 'id';
    public $timestamps = true;

    // protected $guard = 'admin';

    protected $primaryKey = 'id';

    protected $guarded = ['id'];

    public $dates = ['created_at', 'updated_at'];

    /**
     * ModSeo constructor.
     *
     * @param array $attributes
     */
    public function __construct(array $attributes = [])
    {
        $this->table = env('DB_TABLE_PREFIX', 'mod_').'news';

        parent::__construct($attributes);
    }

    protected static function boot()
    {
        parent::boot();

        static::deleted(function (self $item) {
            if ($item->attributes['id']) {
                app('images.photo')->deleteItemImages('news', $item->attributes['id']);
            }

            return true;
        });
    }

    public function getAvatarAttribute()
    {
        if ($this->id) {
            $image = ModImage::query()
                ->where('item_id', $this->id)
                ->where('module', 'news')
                ->orderBy('main', 'Desc')->first();

            return $image;
        }
    }
}
