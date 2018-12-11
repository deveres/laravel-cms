<?php

/**
 * Функция-шорткат для получения языка по-умолчанию.
 *
 * @return array Массив данных о языке
 */
if (!function_exists('get_default_lang')) {
    function get_default_lang()
    {
        $langs_model = new \App\Src\Models\Langs\LabelLang();

        return $langs_model->getDefault();
    }
}

/*
 * Функция-шорткат для получения алиаса языка по-умолчанию
 * @return string
 */
if (!function_exists('get_default_lang_alias')) {
    function get_default_lang_alias()
    {
        $langs_model = new \App\Src\Models\Langs\LabelLang();
        if ($default = $langs_model->getDefault()) {
            return $default['alias'];
        } else {
            return config('app.locale');
        }
    }
}

/*
 * Функция-шорткат для получения ID языка по-умолчанию
 * @return array Массив данных о языке
 */
if (!function_exists('get_default_lang_id')) {
    function get_default_lang_id()
    {
        $lang = get_default_lang();

        return $lang !== false ? $lang['id'] : false;
    }
}

/*
 * Функция-шорткат для получения выбранного пользователем языка
 * @return array Массив данных о языке
 */
if (!function_exists('get_selected_lang')) {
    function get_selected_lang()
    {
        $langs_model = new \App\Src\Models\Langs\LabelLang();

        return $langs_model->getSelected();
    }
}

/*
 * Функция-шорткат для получения ID выбранного пользователем языка
 * @return string
 */
if (!function_exists('get_selected_lang_id')) {
    function get_selected_lang_id()
    {
        $lang = get_selected_lang();

        return $lang ? $lang['id'] : false;
    }
}

/*
 * Функция-шорткат для получения алиаса выбранного пользователем языка
 * @return string
 */
if (!function_exists('get_selected_lang_alias')) {
    function get_selected_lang_alias()
    {
        $lang = get_selected_lang();

        return $lang ? $lang['alias'] : false;
    }
}

/*
 * Функция-шорткат для получения алиаса языка из строки URL
 * @return string
 */
if (!function_exists('get_url_lang_alias')) {
    function get_url_lang_alias()
    {
        return \App\Libs\Registry::get('url_lang');
    }
}

/*
 * Функция-шорткат для получения всех языков
 * @return array Массив закешированных активных языков
 */
if (!function_exists('get_active_langs')) {
    function get_active_langs()
    {
        return \App\Src\Models\Langs\LabelLang::getCached();
    }
}

/*
 * Функция-шорткат для получения языка по его алиасу
 * @return array | false - Данные о языке, либо false в случае отсутствия
 */
if (!function_exists('get_lang_by_alias')) {
    function get_lang_by_alias($lang_alias)
    {
        $data = \App\Libs\Arrays::FilterValues(get_active_langs(), 'alias', '=', $lang_alias);

        return count($data) > 0 ? \App\Libs\Arrays::first($data) : false;
    }
}

/*
 * Функция-шорткат для получения языка по его ID
 * @return array | false - Данные о языке, либо false в случае отсутствия
 */
if (!function_exists('get_lang_by_id')) {
    function get_lang_by_id($lang_id)
    {
        $data = \App\Libs\Arrays::FilterValue(get_active_langs(), 'id', '=', $lang_id);

        return count($data) > 0 ? \App\Libs\Arrays::first($data) : false;
    }
}
