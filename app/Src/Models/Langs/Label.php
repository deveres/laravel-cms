<?php

namespace App\Src\Models\Langs;

use App\Libs\Registry;
use App\Src\Services\I18nService;
use Illuminate\Database\Eloquent\Model;

class Label extends Model
{
    public $incrementing = 'id';
    public $timestamps = false;

    // protected $guard = 'admin';

    protected $primaryKey = 'id';

    protected $table = 'labels';

    protected $guarded = ['id'];

    protected static function boot()
    {
        parent::boot();

        static::saved(function (Label $label) {
            I18nService::export();

            return true;
        });
    }

    public function setLang($lang_alias)
    {
        Registry::set('labels', $this->getLabels($lang_alias));
    }


    /**
     * @param bool $lang_alias
     * @return bool|mixed
     *
     */
    public function getLabels($lang_alias = false)
    {
        if (!$lang_alias) {
            $model_langs = new LabelLang();
            $lang_alias = $model_langs->getDefault();
        }

        $base = storage_path('app');

        $path = $base . '/cache/labels/' . $lang_alias . '.json';
        if (!file_exists($path) || !is_readable($path)) return false;

        return json_decode(file_get_contents($path), true);
    }
}
