<?php

namespace App\Libs;

/**
 * @name Registry
 *
 * @version 1.0
 * @desc Класс для регистрации данных в глобальной области видимости
 */
class Registry
{
    private static $_data = [];

    public static function set($token, $value)
    {
        self::$_data[$token] = &$value;
    }

    public static function issetItem($token)
    {
        return isset(self::$_data[$token]);
    }

    public static function get($token, $default = false)
    {
        return isset(self::$_data[$token]) ? self::$_data[$token] : $default;
    }

    public static function unsetItem($token)
    {
        unset(self::$_data[$token]);
    }

    public static function getAll()
    {
        return self::$_data;
    }

    public function __destruct()
    {
        foreach (self::$_data as $key => $item) {
            unset(self::$_data[$key]);
        }
    }
}
