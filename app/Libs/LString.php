<?php
/**
 * @name String Class of DoubleQuality Engine
 *
 * @uses DKLAB UTF-8 lib
 *
 * @version 0.1
 *
 * @todo Перенести в класс все функции библиотеки UTF-8
 * @todo Все текущие функции в классе переадресовать на self::
 */

namespace App\Libs;

class LString
{
    /**
     * Функция конвертирования регистра строки.
     *
     * @param string $string
     * @param bool   $way    0 - в нижний регистр, 1 - в верхний
     *
     * @return string
     */
    public static function convertCase($string, $way = false)
    {
        $conf = config('encoding', 'utf-8');
        switch ($conf->encoding) {
            default:
                return $way ? strtoupper($string) : strtolower($string);
            case 'utf-8':
                //return $way ? String::
        }
    }

    /**
     * @desc Функция получения строки из произвольного набора чисел и букв (пароли, токены и т.д.)
     *
     * @param int $length Длина строки
     * @param $dictionary Разрешённые символы
     *
     * @return string Возвращает сгенерированную строку
     */
    public static function getRandomString($length, $dictionary = false)
    {
        $string = '';
        if ($dictionary === false) {
            if ($length <= 20) {
                $string = self::randomizeCapsLock(self::utf8_substr(md5(uniqid(intval(rand()))), 0, $length));
            } else {
                $number = ceil($length / 20);
                $string = '';
                for ($x = 0; $x <= $number; $x++) {
                    $string .= md5(uniqid(intval(rand())));
                }
                $string = self::randomizeCapsLock(self::utf8_substr($string, 0, $length));
            }
        } else {
            $dict_length = self::utf8_strlen($dictionary);
            for ($x = 0; $x < $length; $x++) {
                $string[$x] = self::randomizeCapsLock($dictionary[rand(0, $dict_length - 1)]);
            }
            $string = implode($string);
        }

        return $string;
    }

    /**
     * @desc Функция, генерирующая случайный формат каждой буквы строки
     *
     * @param string $string Исходная строка
     *
     * @return string Возвращает преобразованную строку
     */
    public static function randomizeCapsLock($string)
    {
        $length = utf8_strlen($string);
        for ($x = 0; $x < $length; $x++) {
            $string[$x] = (rand(0, 100) < 51 ? utf8_convert_case($string[$x], CASE_LOWER) : utf8_convert_case($string[$x], CASE_UPPER));
        }

        return $string;
    }

    public static function strlen()
    {
    }

    /**
     * @desc Функция получения уникального имени файла
     *
     * @param string Текущее имя файла
     *
     * @return string Уникальное имя файла
     */
    public static function getUniqueName()
    {
        if (func_num_args() == 1) {
            $fname = func_get_arg(0);
            preg_match("/.*\.{1}(.{1,4})$/i", $fname, $match);
        }

        return time().substr(microtime(), 2, 6).'.'.$match[1];
    }

    /**
     * @desc Функция для url-транслитирования элементов
     *
     * @author Береснев Сергей <rassols[at]gmail.com>
     *
     * @param string $text Текст для преобразования
     *
     * @return string Экранированный и очищенный от запрещённых символов.
     */
    public static function convertTextToUrl($text)
    {
        $text = preg_replace('/[\.\s+]/', '-', self::getTranslite($text));

        return preg_replace('/[^a-z0-9\-]/', '', $text);
    }

    /**
     * @desc Функция для траслитирования текста по заданному массиву правил
     *
     * @author Береснев Сергей <rassols[at]gmail.com>
     *
     * @param string $text Текст для преобразования
     *
     * @return string Транслитированный текст
     */
    public static function getTranslite($text)
    {
        $rules = ['а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd', 'е' => 'e', 'ё' => 'jo', 'ж' => 'zh', 'з' => 'z', 'и' => 'i', 'й' => 'j', 'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o', 'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u', 'ф' => 'f', 'х' => 'h', 'ц' => 'c', 'ч' => 'ch', 'ш' => 'sh', 'щ' => 'w', 'ъ' => '#', 'ы' => 'y', 'ь' => '', 'э' => 'je', 'ю' => 'ju', 'я' => 'ja'];
        foreach ($rules as $cyr => $lat) {
            $text = preg_replace('/'.$cyr.'/', $lat, self::utf8_lowercase($text));
        }

        return $text;
    }

    /**
     * @desc Функция получения русскоязычного варианта окончания для переданного числа
     *
     * @param float $value Число, для которого надо подобрать окончание
     * @param array $names Массив имён вида [0]имя одного; [1]имя от 2 до 4; [2]имя 0 и от 5 до 20
     *
     * @return string Возвращает соответствующее числу слово
     */
    public static function getNumberWord($value, $names)
    {
        $temp = strval($value);
        $temp = $temp[self::utf8_strlen($temp) - 1];

        return ($temp > 1 && $temp < 5 && (intval($value % 100) > 19 || intval($value % 100) < 10)) ? $names[1] : ($temp == 1 ? $names[0] : $names[2]);
    }

    public static function camelStyle($string, $up_first = false)
    {
        if (strlen($string) == 0) {
            return '';
        }

        $flag = 0;
        for ($i = 0; $i <= strlen($string) - 1; $i++) {
            if ($flag == 1) {
                $string[$i] = strtoupper($string[$i]);
                $flag = 0;
            }

            if ($string[$i] == '_') {
                $flag = 1;
            }
        }
        if ($up_first) {
            $string = ucfirst($string);
        }

        return str_replace('_', '', $string);
    }

    //UTF-8 Функции от DKLAB

    /**
     * Implementation strlen() function for utf-8 encoding string.
     * There is a nice hack via the utf8_decode function.
     *
     * @param string $str
     *
     * @return int
     *
     * @license  http://creativecommons.org/licenses/by-nc-sa/3.0/
     * @author   <chernyshevsky at hotmail dot com>
     * @author   Nasibullin Rinat <n a s i b u l l i n  at starlink ru>
     * @charset  ANSI
     *
     * @version  1.0.2
     */
    public static function utf8_strlen($str)
    {
        if (function_exists('mb_strlen')) {
            return mb_strlen($str, 'utf-8');
        }
        if (function_exists('iconv_strlen')) {
            return iconv_strlen($str, 'utf-8');
        }
        //utf8_decode() converts characters that are not in ISO-8859-1 to '?', which, for the purpose of counting, is quite alright.
        return strlen(utf8_decode($str));
    }

    /**
     * Конвертирует регистр букв в строке в кодировке UTF-8.
     *
     * @param string $s    строка
     * @param int    $mode {CASE_LOWER|CASE_UPPER}
     *
     * @return string
     *
     * @link     http://www.unicode.org/charts/PDF/U0400.pdf
     * @link     http://ru.wikipedia.org/wiki/ISO_639-1
     *
     * @license  http://creativecommons.org/licenses/by-nc-sa/3.0/
     * @author   Nasibullin Rinat <n a s i b u l l i n  at starlink ru>
     * @charset  ANSI
     *
     * @version  1.2.5
     */
    public static function utf8_convert_case($s, $mode)
    {
        //таблица конвертации регистра
        static $trans = [
            //en (английский латиница)
            //CASE_UPPER => case_lower
            "\x41" => "\x61", //A a
            "\x42" => "\x62", //B b
            "\x43" => "\x63", //C c
            "\x44" => "\x64", //D d
            "\x45" => "\x65", //E e
            "\x46" => "\x66", //F f
            "\x47" => "\x67", //G g
            "\x48" => "\x68", //H h
            "\x49" => "\x69", //I i
            "\x4a" => "\x6a", //J j
            "\x4b" => "\x6b", //K k
            "\x4c" => "\x6c", //L l
            "\x4d" => "\x6d", //M m
            "\x4e" => "\x6e", //N n
            "\x4f" => "\x6f", //O o
            "\x50" => "\x70", //P p
            "\x51" => "\x71", //Q q
            "\x52" => "\x72", //R r
            "\x53" => "\x73", //S s
            "\x54" => "\x74", //T t
            "\x55" => "\x75", //U u
            "\x56" => "\x76", //V v
            "\x57" => "\x77", //W w
            "\x58" => "\x78", //X x
            "\x59" => "\x79", //Y y
            "\x5a" => "\x7a", //Z z

            //ru (русский кириллица)
            //CASE_UPPER => case_lower
            "\xd0\x81" => "\xd1\x91", //Ё ё
            "\xd0\x90" => "\xd0\xb0", //А а
            "\xd0\x91" => "\xd0\xb1", //Б б
            "\xd0\x92" => "\xd0\xb2", //В в
            "\xd0\x93" => "\xd0\xb3", //Г г
            "\xd0\x94" => "\xd0\xb4", //Д д
            "\xd0\x95" => "\xd0\xb5", //Е е
            "\xd0\x96" => "\xd0\xb6", //Ж ж
            "\xd0\x97" => "\xd0\xb7", //З з
            "\xd0\x98" => "\xd0\xb8", //И и
            "\xd0\x99" => "\xd0\xb9", //Й й
            "\xd0\x9a" => "\xd0\xba", //К к
            "\xd0\x9b" => "\xd0\xbb", //Л л
            "\xd0\x9c" => "\xd0\xbc", //М м
            "\xd0\x9d" => "\xd0\xbd", //Н н
            "\xd0\x9e" => "\xd0\xbe", //О о
            "\xd0\x9f" => "\xd0\xbf", //П п

            //CASE_UPPER => case_lower
            "\xd0\xa0" => "\xd1\x80", //Р р
            "\xd0\xa1" => "\xd1\x81", //С с
            "\xd0\xa2" => "\xd1\x82", //Т т
            "\xd0\xa3" => "\xd1\x83", //У у
            "\xd0\xa4" => "\xd1\x84", //Ф ф
            "\xd0\xa5" => "\xd1\x85", //Х х
            "\xd0\xa6" => "\xd1\x86", //Ц ц
            "\xd0\xa7" => "\xd1\x87", //Ч ч
            "\xd0\xa8" => "\xd1\x88", //Ш ш
            "\xd0\xa9" => "\xd1\x89", //Щ щ
            "\xd0\xaa" => "\xd1\x8a", //Ъ ъ
            "\xd0\xab" => "\xd1\x8b", //Ы ы
            "\xd0\xac" => "\xd1\x8c", //Ь ь
            "\xd0\xad" => "\xd1\x8d", //Э э
            "\xd0\xae" => "\xd1\x8e", //Ю ю
            "\xd0\xaf" => "\xd1\x8f", //Я я

            //tt (татарский, башкирский кириллица)
            //CASE_UPPER => case_lower
            "\xd2\x96" => "\xd2\x97", //Ж ж с хвостиком    &#1174; => &#1175;
            "\xd2\xa2" => "\xd2\xa3", //Н н с хвостиком    &#1186; => &#1187;
            "\xd2\xae" => "\xd2\xaf", //Y y                &#1198; => &#1199;
            "\xd2\xba" => "\xd2\xbb", //h h мягкое         &#1210; => &#1211;
            "\xd3\x98" => "\xd3\x99", //Э э                &#1240; => &#1241;
            "\xd3\xa8" => "\xd3\xa9", //О o перечеркнутое  &#1256; => &#1257;

            //uk (украинский кириллица)
            //CASE_UPPER => case_lower
            "\xd2\x90" => "\xd2\x91",  //г с хвостиком
            "\xd0\x84" => "\xd1\x94",  //э зеркальное отражение
            "\xd0\x86" => "\xd1\x96",  //и с одной точкой
            "\xd0\x87" => "\xd1\x97",  //и с двумя точками

            //be (белорусский кириллица)
            //CASE_UPPER => case_lower
            "\xd0\x8e" => "\xd1\x9e",  //у с подковой над буквой

            //tr,de,es (турецкий, немецкий, испанский, французский латиница)
            //CASE_UPPER => case_lower
            "\xc3\x84" => "\xc3\xa4", //a умляут          &#196; => &#228;  (турецкий)
            "\xc3\x87" => "\xc3\xa7", //c с хвостиком     &#199; => &#231;  (турецкий, французский)
            "\xc3\x91" => "\xc3\xb1", //n с тильдой       &#209; => &#241;  (турецкий, испанский)
            "\xc3\x96" => "\xc3\xb6", //o умляут          &#214; => &#246;  (турецкий)
            "\xc3\x9c" => "\xc3\xbc", //u умляут          &#220; => &#252;  (турецкий, французский)
            "\xc4\x9e" => "\xc4\x9f", //g умляут          &#286; => &#287;  (турецкий)
            "\xc4\xb0" => "\xc4\xb1", //i c точкой и без  &#304; => &#305;  (турецкий)
            "\xc5\x9e" => "\xc5\x9f", //s с хвостиком     &#350; => &#351;  (турецкий)

            //hr (хорватский латиница)
            //CASE_UPPER => case_lower
            "\xc4\x8c" => "\xc4\x8d",  //c с подковой над буквой
            "\xc4\x86" => "\xc4\x87",  //c с ударением
            "\xc4\x90" => "\xc4\x91",  //d перечеркнутое
            "\xc5\xa0" => "\xc5\xa1",  //s с подковой над буквой
            "\xc5\xbd" => "\xc5\xbe",  //z с подковой над буквой

            //fr (французский латиница)
            //CASE_UPPER => case_lower
            "\xc3\x80" => "\xc3\xa0",  //a с ударением в др. сторону
            "\xc3\x82" => "\xc3\xa2",  //a с крышкой
            "\xc3\x86" => "\xc3\xa6",  //ae совмещенное
            "\xc3\x88" => "\xc3\xa8",  //e с ударением в др. сторону
            "\xc3\x89" => "\xc3\xa9",  //e с ударением
            "\xc3\x8a" => "\xc3\xaa",  //e с крышкой
            "\xc3\x8b" => "\xc3\xab",  //ё
            "\xc3\x8e" => "\xc3\xae",  //i с крышкой
            "\xc3\x8f" => "\xc3\xaf",  //i умляут
            "\xc3\x94" => "\xc3\xb4",  //o с крышкой
            "\xc5\x92" => "\xc5\x93",  //ce совмещенное
            "\xc3\x99" => "\xc3\xb9",  //u с ударением в др. сторону
            "\xc3\x9b" => "\xc3\xbb",  //u с крышкой
            "\xc5\xb8" => "\xc3\xbf",  //y умляут

            //xx (другой язык)
            //CASE_UPPER => case_lower
            //"" => "",  #

        ];
        //d($trans);

        //вариант с str_replace() должен работать быстрее, чем с strtr()
        if ($mode == CASE_UPPER) {
            if (function_exists('mb_strtoupper')) {
                return mb_strtoupper($s, 'utf-8');
            }
            if (preg_match('/^[\x00-\x7e]*$/', $s)) {
                return strtoupper($s);
            } //может, так быстрее?

            return strtr($s, array_flip($trans));
        } elseif ($mode == CASE_LOWER) {
            if (function_exists('mb_strtolower')) {
                return mb_strtolower($s, 'utf-8');
            }
            if (preg_match('/^[\x00-\x7e]*$/', $s)) {
                return strtolower($s);
            } //может, так быстрее?

            return strtr($s, $trans);
        } else {
            throw new Exception('Parameter 2 should be a constant of CASE_LOWER or CASE_UPPER!');

            return $s;
        }

        return $s;
    }

    /**
     * Ярлык для запуска String::utf8_convert_case c параметром CASE_LOWER.
     *
     * @param string $s
     *
     * @return string Результат работы utf8_convert_case
     */
    public static function utf8_lowercase($s)
    {
        return self::utf8_convert_case($s, CASE_LOWER);
    }

    /**
     * Ярлык для запуска String::utf8_convert_case c параметром CASE_UPPER.
     *
     * @param string $s
     *
     * @return string Результат работы utf8_convert_case
     */
    public static function utf8_uppercase($s)
    {
        return self::utf8_convert_case($s, CASE_UPPER);
    }

    /**
     * Implementation strpos() function for utf-8 encoding string.
     *
     * @param string $haystack The entire string
     * @param string $needle   The searched substring
     * @param int    $offset   The optional offset parameter specifies the position from which the search should be performed
     *
     * @return mixed(int/false) Returns the numeric position of the first occurrence of needle in haystack.
     *                          If needle is not found, utf8_strpos() will return FALSE.
     *
     * @license  http://creativecommons.org/licenses/by-nc-sa/3.0/
     * @author   Nasibullin Rinat <n a s i b u l l i n  at starlink ru>
     * @charset  ANSI
     *
     * @version  1.0.0
     */
    public static function utf8_strpos($haystack, $needle, $offset = null)
    {
        if ($offset === null or $offset < 0) {
            $offset = 0;
        }
        if (function_exists('mb_strpos')) {
            return mb_strpos($haystack, $needle, $offset, 'utf-8');
        }
        if (function_exists('iconv_strpos')) {
            return iconv_strpos($haystack, $needle, $offset, 'utf-8');
        }
        $byte_pos = $offset;
        do {
            if (($byte_pos = strpos($haystack, $needle, $byte_pos)) === false) {
                return false;
            }
        } while (($char_pos = self::utf8_strlen(substr($haystack, 0, $byte_pos++))) < $offset);

        return $char_pos;
    }

    /**
     * Assumes mbstring internal encoding is set to UTF-8
     * Wrapper around mb_strrpos
     * Find position of last occurrence of a char in a string.
     *
     * @param string haystack
     * @param string needle (you should validate this with utf8_is_valid)
     * @param int (optional) offset (from left)
     *
     * @return mixed integer position or FALSE on failure
     */
    public static function utf8_strrpos($haystack, $needle, $offset = null)
    {
        if ($offset === null or $offset < 0) {
            $offset = 0;
        }
        if (function_exists('mb_strpos')) {
            return mb_strrpos($haystack, $needle, $offset, 'utf-8');
        }
        if (function_exists('iconv_strrpos')) {
            return iconv_strrpos($haystack, $needle, $offset, 'utf-8');
        }

        return false;

        $byte_pos = $offset;
        do {
            if (($byte_pos = strrpos($haystack, $needle, $byte_pos)) === false) {
                return false;
            }
        } while (($char_pos = self::utf8_strlen(substr($haystack, 0, $byte_pos++))) < $offset);

        return $char_pos;
    }

    /**
     * from joomla.
     */
    /*
    function utf8_strrpos($str, $search, $offset = FALSE){
        if ( $offset === FALSE ) {
            if ( empty($str) ) {
                return FALSE;
            }
            return mb_strrpos($str, $search);
        } else {
            if ( !is_int($offset) ) {
                trigger_error('utf8_strrpos expects parameter 3 to be long',E_USER_WARNING);
                return FALSE;
            }
            $str = mb_substr($str, $offset);

            if ( FALSE !== ( $pos = mb_strrpos($str, $search) ) ) {
                return $pos + $offset;
            }
            return FALSE;
        }
    }
    */

    /**
     * Implementation substr() function for utf-8 encoding string.
     *
     * @param string $str
     * @param int    $offset
     * @param int    $length
     *
     * @return string
     *
     * @link     http://www.w3.org/International/questions/qa-forms-utf-8.html
     *
     * @license  http://creativecommons.org/licenses/by-nc-sa/3.0/
     * @author   Nasibullin Rinat <n a s i b u l l i n  at starlink ru>
     * @charset  ANSI
     *
     * @version  1.0.4
     */
    public static function utf8_substr($str, $offset, $length = null)
    {
        //в начале пробуем найти стандартные функции
        if (function_exists('mb_substr')) {
            return mb_substr($str, $offset, $length, 'utf-8');
        } //(PHP 4 >= 4.0.6, PHP 5)
        if (function_exists('iconv_substr')) {
            return iconv_substr($str, $offset, $length, 'utf-8');
        } //(PHP 5)
        //однократные паттерны повышают производительность!
        preg_match_all('/(?>[\x09\x0A\x0D\x20-\x7E]           # ASCII
                          | [\xC2-\xDF][\x80-\xBF]            # non-overlong 2-byte
                          |  \xE0[\xA0-\xBF][\x80-\xBF]       # excluding overlongs
                          | [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2} # straight 3-byte
                          |  \xED[\x80-\x9F][\x80-\xBF]       # excluding surrogates
                          |  \xF0[\x90-\xBF][\x80-\xBF]{2}    # planes 1-3
                          | [\xF1-\xF3][\x80-\xBF]{3}         # planes 4-15
                          |  \xF4[\x80-\x8F][\x80-\xBF]{2}    # plane 16
                         )
                        /xs', $str, $m);
        if ($length !== null) {
            $a = array_slice($m[0], $offset, $length);
        } else {
            $a = array_slice($m[0], $offset);
        }

        return implode('', $a);
    }

    /**
     * Специальная функция парсинга строки по заданным разделителям
     *
     * @param string              $string Целевая строка, которую мы будем распарсивать
     * @param string              $delim1 Первый разделитель
     * @param string defaut false $delim2 Второй разделитель
     *
     * @return mixed Возвращает либо итоговы массив либо исходную строку
     */
    public static function unparseString($string, $delim1, $delim2 = false)
    {
        return self::unparse($string, $delim1, $delim2);
    }

    public static function unparse($string, $delim1, $delim2 = false)
    {
        if (trim($string) == '') {
            return [];
        }

        $result = explode($delim1, $string);
        if (is_array($result) && sizeof($result) > 0) {
            $return = [];
            if ($delim2 === false) {
                return DQ_Arrays::trim($result);
            }

            foreach ($result as &$row) {
                $temp = explode($delim2, $row);
                if (is_array($temp) && sizeof($temp) > 1) {
                    $return[$temp[0]] = $temp[1];
                }
            }

            return DQ_Arrays::trim($return);
        } else {
            return $string;
        }
    }

    public static function compareVersions($what, $with)
    {
        if (is_array($what) && sizeof($what) == 2) {
            return ($what[0] <= $with && $with <= $what[1]) ? true : false;
        } elseif (is_array($what) === false) {
            return ($what == $with || $what == 'all') ? true : false;
        } else {
            throw new SystemException('');
        }
    }

    //обрезаем текст по последниму слову
    public static function lentext($str, $dl)
    {
        $konec = '';
        if (self::utf8_strlen($str) > $dl) {
            $konec = ' ...';
            $dl = self::utf8_strpos($str, ' ', $dl);

            return mb_substr($str, 0, $dl, 'utf8').$konec;
        }

        return $str;
    }

    //url кодирование рус+рум
    public static function urlTranslite($text)
    {
        $text = self::utf8_lowercase(preg_replace('/[~!@#$%^&*():;\'`,+"\/\[\]\\\|-]/', '', $text));
        $rules = ['а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd', 'е' => 'e', 'ё' => 'jo', 'ж' => 'zh', 'з' => 'z', 'и' => 'i', 'й' => 'j', 'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o', 'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u', 'ф' => 'f', 'х' => 'h', 'ц' => 'c', 'ч' => 'ch', 'ш' => 'sh', 'щ' => 'w', 'ъ' => '', 'ы' => 'y', 'ь' => '', 'э' => 'je', 'ю' => 'ju', 'я' => 'ja'];
        foreach ($rules as $cyr => $lat) {
            $text = preg_replace('/'.$cyr.'/', $lat, $text);
        }
        /*
        $rules_rum = array('ă'=> 'a', 'î'=> 'i', 'ş'=> 's', 'ț'=> 't', 'â'=> 'a', ' '=> '_', 'ș'=>'s');
        foreach($rules_rum as $cyr => $lat){
            $text = preg_replace('/'.$cyr.'/',$lat, $text);
        }
         *
         */
        return $text;
    }

    public static function truncate($string, $length = 327, $etc = '...')
    {
        if ($length == 0) {
            return '';
        }

        if (self::utf8_strlen($string) > $length) {
            $length -= min($length, self::utf8_strlen($etc));
            $string = preg_replace('/\s+?(\S+)?$/', '', self::utf8_substr($string, 0, $length + 1));

            return self::utf8_substr($string, 0, $length).$etc;
        } else {
            return $string;
        }
    }
}
