<?php

namespace App\Http\Middleware;

use App;
use Closure;
use Request;

class LocaleMiddleware
{
    /*
     * Проверяет наличие корректной метки языка в текущем URL
     * Возвращает метку или значеие null, если нет метки
     */
    public function handle($request, Closure $next)
    {
        $raw_locale = self::getLocale();

        $langs = App\Libs\Arrays::ValuesFromField(get_active_langs(), 'alias');

        if (in_array($raw_locale, $langs)) {  // Проверяем, что у пользователя в сессии установлен доступный язык
            $locale = $raw_locale;                                // (а не какая-нибудь бяка)
        }                                                         // И присваиваем значение переменной $locale.
        else {
            $locale = get_default_lang_alias();
        }                 // В ином случае присваиваем ей язык по умолчанию

        App::setLocale($locale);                                  // Устанавливаем локаль приложения
        App\Libs\Registry::set('url_lang', $locale);

        return $next($request); //пропускаем дальше - передаем в следующий посредник
    }

    /*
    * Устанавливает язык приложения в зависимости от метки языка из URL
    */

    public static function getLocale()
    {
        $uri = Request::path(); //получаем URI

        $langs = App\Libs\Arrays::ValuesFromField(get_active_langs(), 'alias');

        $segmentsURI = explode('/', $uri); //делим на части по разделителю "/"

        //Проверяем метку языка  - есть ли она среди доступных языков
        if (!empty($segmentsURI[0]) && in_array($segmentsURI[0], $langs)) {
            if ($segmentsURI[0] != get_default_lang_alias()) {
                return $segmentsURI[0];
            }
        }
    }
}
