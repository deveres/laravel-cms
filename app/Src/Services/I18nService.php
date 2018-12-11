<?php

namespace App\Src\Services;

use App\Src\Models\Langs\Label;
use App\Src\Models\Langs\LabelCat;
use App\Src\Models\Langs\LabelLang;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class I18nService
{
    /**
     * кэширование меток.
     */
    public static function export()
    {
        $langs = LabelLang::getActive();
        $cats = app(LabelCat::class)->fetchTree();
        $labels = Label::query()->get()->toArray();

        foreach ($langs as $lang) {
            $lang_id = $lang['id'];

            $result = self::prepareLabels($cats, $labels, $lang_id);

            self::putCache($lang['alias'], $result);
        }

        self::cacheCategories();
        self::cacheLangs();
    }

    /**
     * кэширование.
     *
     * @param $name
     * @param $data
     *
     * @return bool
     */
    public static function putCache($name, $data)
    {
        $base = self::touchBase();
        if (!$base) {
            return false;
        }

        $fh = fopen($base.'/cache/labels/'.$name.'.json', 'wb');
        fwrite($fh, json_encode($data));
        fclose($fh);
    }

    /**
     * создает папки кэширования если ех нету.
     *
     * @return bool|string
     */
    public static function touchBase()
    {
        $base = storage_path('app');

        try {
            \File::makeDirectory($base.'/cache/labels', $mode = 0777, true, true);
        } catch (\Exception $e) {
        }

        if (!is_really_writable($base.'/cache/labels')) {
            return false;
        }

        return $base;
    }

    /**
     * cache categories.
     *
     * @return bool
     */
    public static function cacheCategories()
    {
        $cats = app(LabelCat::class)->fetchTree();

        self::putCache('cats', $cats);
    }

    /**
     * cache languages.
     *
     * @return bool
     */
    public static function cacheLangs()
    {
        $langs = LabelLang::getActive();

        self::putCache('langs', $langs);
    }

    /**
     * synchro lanbels table with available languages.
     */
    public static function syncLabelsTable()
    {
        $langs = LabelLang::query()->orderBy('id')->get();
        foreach ($langs as $one_lang) {
            self::syncLabelLang($one_lang);
        }
    }

    /**
     * @param LabelLang $lang
     */
    public static function syncLabelLang(LabelLang $lang)
    {
        try {
            if (!Schema::hasColumn(app(Label::class)->getTable(), 'value_'.$lang->id)) {
                Schema::table(app(Label::class)->getTable(), function (Blueprint $table) use ($lang) {
                    $table->text('value_'.$lang->id)->nullable();
                });
            }
        } catch (\Exception $e) {
            logger($e->getMessage());
        }
    }

    /**
     * @param $id
     */
    public static function deleteLangsTableField($id)
    {
        try {
            if (Schema::hasColumn(app(Label::class)->getTable(), 'value_'.$id)) {
                Schema::table(app(Label::class)->getTable(), function (Blueprint $table) use ($id) {
                    $table->dropColumn('value_'.$id);
                });
            }
        } catch (\Exception $e) {
            logger($e->getMessage());
        }
    }

    /**
     * @param int $parent_id
     *
     * @return string
     */
    public static function getLabelPath($parent_id)
    {
        static $catsData = null;

        if (null === $catsData) {
            $catsData = app(LabelCat::class)->getStructure();
        }

        $result = [];

        while ($parent_id) {
            if (!isset($catsData[$parent_id])) {
                break;
            }
            $value = $catsData[$parent_id];
            $result[] = $value['alias'];
            $parent_id = $value['parent_id'];
        }

        return implode('/', array_reverse($result));
    }

    /**
     * prepare labels for output.
     *
     * @param $cats
     * @param $labels
     * @param $lang_id
     *
     * @return array
     */
    private static function prepareLabels($cats, $labels, $lang_id)
    {
        $result = [];

        foreach ($labels as $label) {
            $path = $label['label'];
            if (setif($cats, $label['parent_id'], false)) {
                $path = $cats[$label['parent_id']]['link'].$label['label'];
            }

            $key = 'value_'.$lang_id;
            $result[$path] = $label[$key] ?? '';
        }

        return $result;
    }
}
