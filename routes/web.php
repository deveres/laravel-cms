<?php
require_once __DIR__ . '/switch_locale.php';


Route::group(['prefix' => App\Http\Middleware\LocaleMiddleware::getLocale()], function () {

    Auth::routes();

    Route::get('/home', 'HomeController@index')->name('home');
});



