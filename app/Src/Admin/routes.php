<?php

use Illuminate\Routing\Router;

Admin::routes();

$attributes = [
    'prefix'     => config('admin.route.prefix'),
    'middleware' => config('admin.route.middleware'),
];

app('router')->group($attributes, function ($router) {
    $router->namespace('App\Src\Admin\Controllers\Permissions')->group(function ($router) {
        $router->resource('auth/permissions', 'PermissionController')->names('admin.auth.permissions');
        $router->resource('auth/permissions-cat', 'PermissionCategoriesController')->names('admin.auth.permissions-cat');
    });

    $router->namespace('App\Src\Admin\Controllers\Menu')->group(function ($router) {
        $router->resource('auth/menu', 'MenuController', ['except' => ['create']])->names('admin.auth.menu');
    });
});

Route::group([
    'prefix'        => config('admin.route.prefix'),
    'namespace'     => config('admin.route.namespace'),
    'middleware'    => config('admin.route.middleware'),
    'as'            => config('admin.route.prefix').'.',
], function (Router $router) {
    $router->get('/', 'HomeBackendController@index')->name('home');

    Route::group([], function (Router $router) {
        Route::group(['namespace' => 'Langs'], function (Router $router) {
            $router->resource('langs', LangsBackendController::class);
            $router->resource('langs_cats', LangsCatsBackendController::class);
            $router->resource('langs_labels', LangsLabelsBackendController::class);

            $router->post('/langs/synchro-labels', 'LangsBackendController@synchroLabels')->name('synchro-labels');
            $router->post('/langs/row-orderable', 'LangsCatsBackendController@rowOrderable')->name('row-orderable');
        });

        Route::group(['namespace' => 'Modules'], function (Router $router) {
            $router->resource('modules', ModulesBackendController::class);
            $router->post('/modules/row-orderable', 'ModulesBackendController@rowOrderable')->name('modules.row-orderable');
        });

        Route::group(['namespace' => 'Seo'], function (Router $router) {
            $router->resource('seo', SeoBackendController::class);
        });

        /*
                Route::group(['prefix' => 'translations'], function () {
                    Vsch\TranslationManager\Translator::routes();
                });
        */

        Route::group(['namespace' => 'News'], function (Router $router) {
            $router->resource('news', NewsBackendController::class);
        });

        Route::group(['namespace' => 'Images'], function (Router $router) {
            $router->resource('images', ImagesBackendController::class);

            $router->post('/images/upload', 'ImagesBackendController@uploadImage')->name('images.upload');

            $router->get(
                '/images/{module}/{item_id}/{size?}/{filename}',
                function ($module, $item_id, $size, $filename) {
                    return app('images.photo')->downloadPhoto($module, $item_id, $size, $filename);
                }
            )->name('download.image');

            $router->post('/images/delete', 'ImagesBackendController@deleteImage')->name('images.delete');
            $router->post('/images/delete-all', 'ImagesBackendController@deleteAllImages')->name('images.delete.all');
            $router->post('/images/setmain', 'ImagesBackendController@mainImage')->name('images.main');
        });
    });
});
