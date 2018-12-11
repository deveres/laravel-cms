<?php

namespace App\Src\Models\News;


use App\Src\Models\Images\ModImage;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;


class ModNews extends Model
{

    use \Dimsav\Translatable\Translatable;

    public $translationModel = 'App\Src\Models\News\ModNewsI18n';

    public $translationForeignKey = 'row_id';

    public $incrementing = 'id';
    public $timestamps = true;

    public $dates = ['created_at', 'updated_at'];


    // protected $guard = 'admin';
    public $translatedAttributes = [
        'name',
        'introtext',
        'text',
        'seo_h1',
        'seo_title',
        'seo_keywords',
        'seo_description'
    ];
    protected $primaryKey = 'id';
    protected $fillable = ['log_name', 'alias', 'link', 'state', 'lock_alias', 'comments_enabled'];

    /**
     * ModSeo constructor.
     * @param array $attributes
     */
    public function __construct(array $attributes = [])
    {
        $this->table = env('DB_TABLE_PREFIX', 'mod_') . 'news';

        parent::__construct($attributes);
    }

    protected static function boot()
    {
        parent::boot();

        static::deleted(function (ModNews $item) {

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
