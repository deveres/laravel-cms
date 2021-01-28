<?php

use Illuminate\Support\Facades\Route;

Route::group(['prefix' => App\Http\Middleware\LocaleMiddleware::getLocale(), 'namespace'=>'Controllers'], function () {
    //Route::model('mod-news', \App\Src\Models\News\ModNews::class);

    Route::get('/', 'IndexController@index');
    Route::get('/news', 'News\NewsController@index')->name('frontend.news');
    Route::get('/news/{modNews}', 'News\NewsController@view')->name('frontend.news.view');
});
