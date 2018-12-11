<?php

namespace App\Src\Models\Langs;

use App\Libs\Arrays;
use App\Libs\Registry;
use App\Src\Services\I18nService;
use Illuminate\Database\Eloquent\Model;
use Spatie\EloquentSortable\Sortable;
use Spatie\EloquentSortable\SortableTrait;

class LabelLang extends Model implements Sortable
{
    use SortableTrait;

    public $sortable = [
        'order_column_name'  => 'ord',
        'sort_when_creating' => true,
    ];
    public $incrementing = 'id';
    public $timestamps = false;

    // protected $guard = 'admin';

    protected $primaryKey = 'id';

    protected $table = 'label_langs';

    protected $fillable = ['name', 'alias', 'ord', 'state', 'default'];

    public static function getActive()
    {
        return self::query()->where('state', 1)->orderBy('id', 'ASC')->get()->toArray();
    }

    protected static function boot()
    {
        parent::boot();

        static::saved(function (LabelLang $lang) {
            I18nService::syncLabelLang($lang);
            I18nService::export();

            return true;
        });

        static::deleted(function (LabelLang $lang) {
            I18nService::deleteLangsTableField($lang->id);
            I18nService::syncLabelLang($lang);
            I18nService::export();

            return true;
        });
    }

    public function getSelected()
    {
        if (!Registry::issetItem('selected_lang')) {
            $this->findAndSetSelected();
        }

        return Registry::get('selected_lang');
    }

    /**
     * Метод получения и установки выбранного языка из
     * строки URL или из установок по-умолчанию.
     * Выбранный язык регистрируется через класс Registry с индексом selected_lang.
     *
     * @return array Массив данных о языке
     */
    public function findAndSetSelected()
    {
        $router_alias = get_url_lang_alias();
        if ($router_alias !== false) {
            $langs = $this->getCached();
            $router_lang = Arrays::first(Arrays::FilterValues($langs, 'alias', '=', $router_alias));
            Registry::set('selected_lang', $router_lang);

            return $router_lang;
        }

        $default_lang = $this->getDefault();
        if ($default_lang !== false) {
            Registry::set('selected_lang', $default_lang);

            return $default_lang;
        }
    }

    public static function getCached()
    {
        static $langs = null;
        if (isset($langs)) {
            return $langs;
        }

        $cache_path = storage_path('app').'/cache/labels/langs.json';

        if (!file_exists($cache_path)) {
            $langs = self::query()->where('state', 1)->orderBy('default', 'DESC')->get()->toArray();
        } else {
            $langs = json_decode(file_get_contents($cache_path), true);
        }

        return $langs;
    }

    public static function getDefault()
    {
        return self::query()->orderBy('default', 'DESC')->first()->toArray();
    }
}
