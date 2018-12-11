<?php

/**
 * Функция для получения значения элемента массива.
 *
 * @param array  $array
 * @param string $index
 * @param mixed  $default - значение, возвращаемое в случае, если элемент не найден
 *
 * @return mixed
 */
if (!function_exists('setif')) {
    function setif($array, $index, $default = false)
    {
        return (isset($array[$index])) ? $array[$index] : $default;
    }
}

if (!function_exists('setif_strict')) {
    function setif_strict($array, $index, $default = false)
    {
        return (isset($array[$index]) && $array[$index] != '') ? $array[$index] : $default;
    }
}

if (!function_exists('print_pre')) {
    function print_pre($var)
    {
        echo '<pre>';
        print_r($var);
        echo '</pre>';
    }
}
/*
 * @desc Вывод массива в виде дерева
 *
 * @param array $array
 * @param string $str - строка для вывода после массива, например для проверки
 * @return void
 */
if (!function_exists('pre')) {
    function pre($array = [], $str = '')
    {
        if (!headers_sent()) {
            header('Content-type:text/html; charset=utf-8');
        }
        echo '<pre>';
        print_r($array);
        echo '</pre>'.$str;
    }
}

/*
 * @desc Вывод массива в виде дерева и прекращение работы скрипта
 *
 * @param array $array
 * @param string $str - строка для вывода после массива, например для проверки
 * @return void
 */
if (!function_exists('pred')) {
    function pred($array = [], $str = '')
    {
        if (!headers_sent()) {
            header('Content-type:text/html; charset=utf-8');
        }
        echo '<pre>';
        print_r($array);
        die('</pre>'.$str);
    }
}

/*
 * @desc Вывод данных с помощью функции var_dump
 */
if (!function_exists('vre')) {
    function vre()
    {
        if (!headers_sent()) {
            header('Content-type:text/html; charset=utf-8');
        }
        echo '<pre>';
        var_dump(func_get_args());
        echo '</pre>';
    }
}

/*
 * @desc Вывод данных с помощью функции var_dump и прекращение раоты скрипта
 */
if (!function_exists('vred')) {
    function vred()
    {
        if (!headers_sent()) {
            header('Content-type:text/html; charset=utf-8');
        }
        echo '<pre>';
        var_dump(func_get_args());
        die('</pre>');
    }
}

/*
 * Функция получения реального IP адреса
 * @return string
 */
if (!function_exists('getRealIp')) {
    function getRealIp()
    {
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        }

        return $ip;
    }
}

if (!function_exists('hex2bin')) {
    function hex2bin($str)
    {
        if (!is_string($str)) {
            return;
        }
        $r = '';
        for ($a = 0; $a < strlen($str); $a += 2) {
            $r .= chr(hexdec($str[$a].$str[($a + 1)]));
        }

        return $r;
    }
}
