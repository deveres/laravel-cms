<?php

/**
 * Шорткат для функции _t
 * @return string
 */
if (!function_exists('get_label')) {
    function get_label()
    {
        $params = func_get_args();
        return call_user_func_array('_t', $params);
    }
}

/**
 * Обязательный первый аргумент как get_label
 * Остальные параметры нужны для парсинга параметров в строке метки
 * Можно передавать либо numerical or assoc array
 * Первые три примера работают с numerical array и значение метки обрабатываются через sprintf
 * _t($path, $string) - пример значения метки "some text %s"
 * _t($path, $string1, $string2, $string3) - пример значения метки "some text %s will %s show %s"
 * _t($path, $array('a', 'b', 'c')) - пример значения метки как и во втором примере
 * Этот пример работает с assoc array
 * _t($path, $array('name' => 'my first name', 'email' => 'some email', 'message' => 'some big message'))
 * Значение метки в данном случае может быть примерно такое "my name {name}. my email is {email}. my some text {message}"
 */
if (!function_exists('_t')) {
    function _t()
    {
        static $labels = false;
        if ($labels === false) {
            $labels = \App\Libs\Registry::get('labels');
        }

        $numargs = func_num_args();
        $arg_list = func_get_args();
        if (!$numargs) return '';

        $namespace = labels_get_namespace();

        $path = func_get_arg(0);
        if ($namespace !== false) $path = $namespace . $path;
        $label = setif($labels, $path, $path);

        if ($numargs == 1) return $label;

        $data = func_get_arg(1);
        if (!is_array($data)) {
            unset($arg_list[0]);
            $data = $arg_list;
        }

        $is_numerical = array_key_exists(1, $data) ? true : false;

        $text = '';
        if ($is_numerical) {
            $text = sprintf_array($label, $data);
            if (!$text) {
                new \Exception('Не удалось распарсить метку ' . $label, 404, __FILE__, __LINE__);
                $text = '';
            }
        } else {
            $places = array();
            foreach ($data as $key => $value) {
                $places['{' . $key . '}'] = $value;
            }
            $text = strtr($label, $places);
        }

        return $text;
    }
}

if (!function_exists('labels_set_namespace')) {
    function labels_set_namespace($namespace)
    {
        \App\Libs\Registry::set('labels_namespace', rtrim($namespace, '/') . '/');
    }
}

if (!function_exists('labels_get_namespace')) {
    function labels_get_namespace()
    {
        return \App\Libs\Registry::get('labels_namespace');
    }
}

if (!function_exists('labels_unset_namespace')) {
    function labels_unset_namespace()
    {
        \App\Libs\Registry::set('labels_namespace', false);
    }
}

if (!function_exists('labels_clean_namespace')) {
    function labels_clean_namespace()
    {
        labels_unset_namespace();
    }
}

if (!function_exists('labels_set_lang')) {
    function labels_set_lang($lang_alias)
    {
        $model = new \App\Src\Models\Langs\Label();
        return $model->setLang($lang_alias);
    }
}

/**
 * sprintf use array
 *
 * @see http://jp.php.net/manual/ja/function.printf.php
 * @param string $format
 * @param array $arr
 * @access public
 * @return string
 */
if (!function_exists('sprintf_array')) {
    function sprintf_array($format, $arr)
    {
        return call_user_func_array('sprintf', array_merge((array)$format, $arr));
    }

}

if (!function_exists('date_get_month')) {
    function date_get_month($date, $with_day_flag = false)
    {
        $month = date('n', strtotime($date));
        return $with_day_flag ? get_label('month/fullof_' . $month) : get_label('month/full_' . $month);
    }
}