<?php

use Illuminate\Routing\Router;

Admin::registerAuthRoutes();

$attributes = [
    'prefix'     => config('admin.route.prefix'),
    'middleware' => config('admin.route.middleware'),
];

app('router')->group($attributes, function ($router) {
    /* @var \Illuminate\Routing\Router $router */
    $router->namespace('App\Src\Admin\Controllers\Permissions')->group(function ($router) {
        $router->resource('auth/permissions', 'PermissionController');
        $router->resource('auth/permissions-cat', 'PermissionCategoriesController');
    });

    $router->namespace('App\Src\Admin\Controllers\Menu')->group(function ($router) {
        $router->resource('auth/menu', 'MenuController', ['except' => ['create']]);
    });
});

Route::group([
    'prefix'     => config('admin.route.prefix'),
    'namespace'  => config('admin.route.namespace'),
    'middleware' => config('admin.route.middleware'),
], function (Router $router) {
    $router->get('/', 'HomeController@index')->name('admin.main');

    Route::group([], function (Router $router) {
        Route::group(['namespace' => 'Langs'], function (Router $router) {
            $router->resource('langs', LangsController::class);
            $router->resource('langs_cats', LangsCatsController::class);
            $router->resource('langs_labels', LangsLabelsController::class);

            $router->post('/langs/synchro-labels', 'LangsController@synchroLabels')->name('synchro-labels');
            $router->post('/langs/row-orderable', 'LangsCatsController@rowOrderable')->name('row-orderable');
        });

        Route::group(['namespace' => 'Modules'], function (Router $router) {
            $router->resource('modules', ModulesController::class);
            $router->post('/modules/row-orderable', 'ModulesController@rowOrderable')->name('modules.row-orderable');
            $router->post('/modules/install', 'ModulesController@install')->name('modules.module-install');
        });

        Route::group(['prefix' => 'translations'], function () {
            Vsch\TranslationManager\Translator::routes();
        });

        Route::group(['namespace' => 'News'], function (Router $router) {
            $router->resource('news', NewsController::class);
        });

        Route::group(['namespace' => 'Seo'], function (Router $router) {
            $router->resource('seo', SeoController::class);
        });

        Route::group(['namespace' => 'Images'], function (Router $router) {
            $router->resource('images', ImagesController::class);

            $router->post('/images/upload', 'ImagesController@uploadImage')->name('images.upload');

            $router->get('/images/{module}/{item_id}/{size?}/{filename}',
                function ($module, $item_id, $size, $filename) {
                    return app('images.photo')->downloadPhoto($module, $item_id, $size, $filename);
                })->name('download.image');

            $router->post('/images/delete', 'ImagesController@deleteImage')->name('images.delete');
            $router->post('/images/delete-all', 'ImagesController@deleteAllImages')->name('images.delete.all');
            $router->post('/images/setmain', 'ImagesController@mainImage')->name('images.main');
        });
    });
});
