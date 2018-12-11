<?php
/**
 * @name DQ_Arrays Class of DoubleQuality Engine
 *
 * @author Beresnev Sergey
 *
 * @version 1.0
 */

namespace App\Libs;

class Arrays
{
    public static function check($arr)
    {
        if (!is_array($arr)) {
            throw new Exception('Переданный объект не является массивом');
        }
    }

    public static function Id2Keys($arr = [], $id_field = 'id')
    {
        if (!is_array($arr)) {
            return [];
        }
        $res = [];
        foreach ($arr as $value) {
            $res[$value[$id_field]] = $value;
        }

        return $res;
    }

    public static function Value2Key($arr = [])
    {
        if (!is_array($arr)) {
            return [];
        }

        $res = [];
        foreach ($arr as $value) {
            $res[$value] = $value;
        }

        return $res;
    }

    public static function Value2Ids($arr = [], $id_field = 'id', $value_field = false)
    {
        if (!is_array($arr)) {
            return false;
        }
        $res = [];
        foreach ($arr as $value) {
            $res[$value[$id_field]] = ($value_field ? $value[$value_field] : $value);
        }

        return $res;
    }

    public static function Values2Ids($arr = [], $id_field = 'id', $value_field = false)
    {
        if (!is_array($arr)) {
            return false;
        }
        $res = [];
        foreach ($arr as $value) {
            $res[$value[$id_field]][] = ($value_field ? setif($value, $value_field, false) : $value);
        }

        return $res;
    }

    public static function Id2Id($arr = [], $id_field = 'id', $keys = true)
    {
        if (!is_array($arr)) {
            return [];
        }

        $res = [];
        foreach ($arr as $value) {
            if (!isset($value[$id_field])) {
                continue;
            }
            if ($keys) {
                $res[$value[$id_field]] = $value[$id_field];
            } else {
                $res[] = setif($value, $id_field, '');
            }
        }

        return $res;
    }

    public static function getIds($arr = [], $id_field = 'id', $unique = false)
    {
        $data = self::Id2Id($arr, $id_field, false);
        if ($unique) {
            $data = array_unique($data);
        }

        return $data;
    }

    public static function MinValue($arr = [])
    {
        if (!is_array($arr)) {
            return false;
        }
        sort($arr, SORT_NUMERIC);

        return array_shift($arr);
    }

    public static function MaxValue($arr = [])
    {
        if (!is_array($arr)) {
            return false;
        }
        rsort($arr, SORT_NUMERIC);

        return array_shift($arr);
    }

    public static function SortValue2Ids(&$arr = [], $id_field = 'id', $value_field = 'value', $order = 'max')
    {
        if (!is_array($arr)) {
            return false;
        }
        $res = self::Values2Ids($arr, $id_field, $value_field);
        foreach ($res as &$value) {
            $value = ($order == 'max' ? self::MaxValue($value) : self::MinValue($value));
        }
        $arr = $res;

        return $res;
    }

    public static function Unique(&$arr)
    {
        foreach ($arr as &$value) {
            $value = array_unique($value);
        }

        return $arr;
    }

    public static function elements($arr, $offset = 0, $limit = 0)
    {
        if (!$limit) {
            $limit = count($arr) - $offset;
        }

        $counter = 0;
        $res = [];
        foreach ($arr as $value) {
            if ($counter >= $offset && $counter < $offset + $limit) {
                $res[] = $value;
            }
            $counter++;
        }

        return $res;
    }

    public static function DeleteEmpty($arr)
    {
        foreach ($arr as $key => $value) {
            if (is_array($value)) {
                if (count($value) == 0) {
                    unset($arr[$key]);
                }
            } else {
                if (!$value) {
                    unset($arr[$key]);
                }
            }
        }

        return $arr;
    }

    public static function FilterValues(&$arr, $value_field = 'value', $eq_type = '=', $eq_value = 0)
    {
        require_once 'LString.php';

        if (!is_array($arr) || (is_object($arr) && !$arr instanceof ArrayAccess)) {
            return [];
        }

        $res = [];
        foreach ($arr as $value) {
            if (!isset($value[$value_field])) {
                continue;
            }
            switch ($eq_type) {
                default:
                case 1:
                case '=':
                case 'ravno':
                case 'equal':
                    if ($value[$value_field] == $eq_value) {
                        $res[] = $value;
                    }
                    break;
                case 2:
                case '<':
                case 'menishe':
                case 'less':
                    if ($value[$value_field] < $eq_value) {
                        $res[] = $value;
                    }
                    break;
                case 3:
                case '>':
                case 'bolishe':
                case 'more':
                    if ($value[$value_field] > $eq_value) {
                        $res[] = $value;
                    }
                    break;
                case 4:
                case '<=':
                    if ($value[$value_field] <= $eq_value) {
                        $res[] = $value;
                    }
                    break;
                case 5:
                case '>=':
                    if ($value[$value_field] >= $eq_value) {
                        $res[] = $value;
                    }
                    break;
                case 'includes':
                    if (LString::utf8_strpos(LString::utf8_lowercase($value[$value_field]), LString::utf8_lowercase($eq_value)) !== false) {
                        $res[] = $value;
                    }
                    break;
            }
        }

        return $res;
    }

    public static function trim(&$arr, $delete_symbols = ' ')
    {
        foreach ($arr as &$value) {
            if (is_array($value)) {
                self::trim($value, $delete_symbols);
            } else {
                $value = trim($value, $delete_symbols);
            }
        }

        return $arr;
    }

    public static function prepareStandart($arr, $id_field = 'id', $value_field = 'value')
    {
        $res = [];
        foreach ($arr as $value) {
            $res[] = [0 => $value[$id_field], 1 => $value[$value_field],
                'id'    => $value[$id_field], 'value' => $value[$value_field], ];
        }

        return $res;
    }

    public static function sum($arr, $field)
    {
        $res = 0;
        foreach ($arr as $value) {
            $res += $value[$field];
        }

        return $res;
    }

    public static function val($arr, $field)
    {
        return isset($arr[$field]) ? $arr[$field] : false;
    }

    public static function first($arr)
    {
        if (!is_array($arr) || count($arr) == 0) {
            return [];
        }
        foreach ($arr as $value) {
            break;
        }

        return $value;
    }

    public static function last($arr)
    {
        return array_pop($arr);
    }

    public static function next($arr, $need_value = null, $return_first_onerror = true)
    {
        if (!isset($need_value)) {
            return next($arr);
        }

        $next_flag = false;
        foreach ($arr as $value) {
            if ($next_flag) {
                return $value;
            }

            if ($need_value == $value) {
                $next_flag = true;
            }
        }

        if ($return_first_onerror) {
            return array_shift($arr);
        } else {
            return false;
        }
    }

    public static function fpush($arr, $value, $key = false)
    {
        if (!is_array($arr) || count($arr) == 0) {
            return [];
        }

        $res = $key !== false ? [$key => $value] : [$value];
        foreach ($arr as $elem_key => $elem_value) {
            $res[$elem_key] = $elem_value;
        }

        return $res;
    }

    public static function after($arr, $add_arr, $after_key = 0)
    {
        if (!is_array($arr) || !is_array($add_arr)) {
            return [];
        }

        $res = [];
        foreach ($arr as $key => $value) {
            $res[$key] = $value;
            if ($key == $after_key) {
                foreach ($add_arr as $add_key => $add_value) {
                    $res[$add_key] = $add_value;
                }
            }
        }

        return $res;
    }

    public static function ValuesFromField($arr, $field, $key = false)
    {
        if (!is_array($arr)) {
            return [];
        }
        $res = [];
        foreach ($arr as $value) {
            if ($key) {
                $res[$value[$key]] = $value[$field];
            } else {
                $res[] = $value[$field];
            }
        }

        return $res;
    }

    public static function setBitMask($arr = [], $keys = false)
    {
        if (!is_array($arr) || count($arr) == 0) {
            return 0;
        }

        $result = 0;
        foreach ($arr as $elem_key => $elem_value) {
            if ($keys) {
                $result = $result | ($elem_value ? 1 : 0) << $elem_key;
            } else {
                $result = $result | 1 << $elem_value;
            }
        }

        return $result;
    }

    public static function unsetBitMask($mask = 0, $grade = 0, $show_values = false)
    {
        $grade = 20;

        $mask = intval($mask);
        $result = [];

        $counter = 0;
        while ($counter < $grade) {
            if ($mask >> $counter & 1 == 1) {
                $result[$counter] = ($show_values) ? 1 : $counter;
            } elseif ($show_values) {
                $result[$counter] = 0;
            }
            $counter++;
        }

        return $result;
    }

    /*
     * функция сортировки массисва по полю
     * masort($yourArray, 'name');  сортировка по полю name
     * masort($yourArray, 'surname, name'); отсортировать массив по полю "surname", а те у кого одинаковый "surname", по полю "name"
     * masort($yourArray, 'priority DESC, surname, name');
     */
    /*
        static function masort(&$data, $sortby)
        {
            if (!sizeof($data)) return array();

            $sortby = str_replace('ASC', '', $sortby);
            static $funcs = array();

            if (empty($funcs[$sortby])) {
                $code = "\$c=0;";
                foreach (explode(',', $sortby) as $key) {
                    $key = trim($key);
                    if (strlen($key) > 5 && substr($key, -5) == ' DESC') {
                        $asc = false;
                        $key = substr($key, 0, strlen($key) - 5);
                    } else {
                        $asc = true;
                    }

                    $array = array_pop($data);
                    array_push($data, $array);

                    if (isset($array[$key])) {
                        if (is_numeric($array[$key])) {
                            $code .= "if ( \$c = ((\$a['$key'] == \$b['$key']) ? 0:((\$a['$key'] " . (($asc) ? '<' : '>') . " \$b['$key']) ? -1 : 1 )) ) return \$c;";
                        } else {
                            $code .= "if ( (\$c = strcasecmp(\$a['$key'],\$b['$key'])) != 0 ) return " . (($asc) ? '' : '-') . "\$c;\n";
                        }
                    }
                }
                $code .= 'return $c;';
                $func = $funcs[$sortby] = create_function('$a, $b', $code);
            } else {
                $func = $funcs[$sortby];
            }
            $func = $funcs[$sortby];

            return uasort($data, $func);
        }
    */

    public static function masort(&$data, $sortby)
    {
        if (!count($data)) {
            return [];
        }

        $sortby = str_replace('ASC', '', $sortby);

        return uasort($data, function ($a, $b) use ($sortby) {
            $c = 0;

            foreach (explode(',', $sortby) as $key) {
                $key = trim($key);
                if (strlen($key) > 5 && substr($key, -5) == ' DESC') {
                    $asc = false;
                    $key = substr($key, 0, strlen($key) - 5);
                } else {
                    $asc = true;
                }

                if (!isset($a[$key])) {
                    return $c;
                }

                if (isset($a[$key])) {
                    if (is_numeric($a[$key])) {
                        if ($asc) {
                            if ($c = (($a[$key] == $b[$key]) ? 0 : (($a[$key] < $b[$key]) ? -1 : 1))) {
                                return $c;
                            }
                        } else {
                            if ($c = (($a[$key] == $b[$key]) ? 0 : (($a[$key] > $b[$key]) ? -1 : 1))) {
                                return $c;
                            }
                        }
                    } else {
                        if ($asc) {
                            if (($c = strcasecmp($a[$key], $b[$key])) != 0) {
                                return $c;
                            }
                        } else {
                            if (($c = strcasecmp($a[$key], $b[$key])) != 0) {
                                return -1 * $c;
                            }
                        }
                    }
                }
            }

            return $c;
        });
    }

    /**
     * Получить значение битовой маски.
     *
     * @param        array        data
     *
     * @return int
     */
    public static function getBitmaskFromArray(array $data)
    {
        $mask = 0;

        foreach (array_keys($data) as $i) {
            $mask = $mask | (1 << $i);
        }

        return $mask;
    }

    /**
     * Получить массив по битовой маски.
     *
     * @param        int                mask
     * @param        int                bitCount
     *
     * @return array
     */
    public static function getArrayFromBitmask($mask, $bitCount = 8)
    {
        $data = [];

        for ($i = 0; $i < $bitCount; $i++) {
            if ($mask >> $i & 1) {
                $data[$i] = true;
            }
        }

        return $data;
    }

    /**
     * Метод преобразования строки с разделителями в массив.
     *
     * @descr Помимо обычного преобразования, удаляются пустые элементы и обрезаются конечные пробелы элементов
     *
     * @param string $delimiter
     * @param string $string
     *
     * @return array
     */
    public static function explode($delimiter, $string)
    {
        return self::deleteEmpty(self::trim(explode($delimiter, $string)));
    }
}
