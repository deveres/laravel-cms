<?php

namespace App\Providers;

use Encore\Admin\Config\Config;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     */
    public function boot()
    {
        Config::load();

        \Config::set('app.locale', get_default_lang_alias());
        \Config::set('translatable.fallback_locale', get_default_lang_alias());
        \Config::set('languages.mainLanguage', get_default_lang_alias());
        \Config::set('languages.languages', array_pluck(get_active_langs(), 'alias'));

        if (\Request::secure()) {
            \Config::set('admin.secure', true);
        }

        /* @params  $attribute - имя поля,  @params $value - значение поля,  @params $parameters - параметры дял валидации */
        Validator::extend('unique_by_parent', function ($attribute, $value, $parameters, $validator) {
            if (!isset($parameters[0])) {
                //@todo throw exception here
                // throw new \Illuminate\Validation\ValidationException($validator);
                return false;
            }
            $table = $parameters[0];
            $field = $parameters[1] ?? $attribute;
            $except_value = $parameters[2] ?? null;
            $except_field = $parameters[3] ?? null;
            $parent_field = $parameters[4] ?? null;
            $parent_field_value = $parameters[5] ?? null;

            $query = DB::table($table)->where($field, $value);
            if ($except_field && $except_value) {
                $query->where($except_field, '<>', $except_value);
            }
            if ($parent_field && $parent_field_value) {
                $query->where($parent_field, $parent_field_value);
            }
            $founded = $query->count();

            if ($founded > 0) {
                return false;
            } else {
                return true;
            }
        });
    }

    /**
     * Register any application services.
     */
    public function register()
    {
        $this->app->singleton('backend.breadcrumbs', function () {
            $breadcrumbs = new \Creitive\Breadcrumbs\Breadcrumbs();
            $breadcrumbs->addCrumb("<i class='fa fa-dashboard'></i>".' Главная', config('admin.route.prefix'));
            $breadcrumbs->addCssClasses('breadcrumb '); //breadcrumb-arrow
            $breadcrumbs->setDivider(null);

            return $breadcrumbs;
        });

        $this->app->bind('images.photo', function ($app, $params) {
            $reflection = new \ReflectionClass('\App\Libs\LibImages');
            $filter = $reflection->newInstanceArgs($params);

            return $filter;
        });

        $this->registerConfig();
        $this->_loadHelpers();
    }

    public function registerConfig()
    {
        $files = glob(app_path('Src/Config/').'*.php');
        if ($files) {
            foreach ($files as $one) {
                $tmp = explode('.', basename($one));
                $label = strtolower(array_shift($tmp));
                if ($label) {
                    $configs = require_once $one;

                    if (isset($configs['path']) && $configs['path']) {
                        $this->mergeConfigFrom($one, 'modules.'.$configs['path']);
                    }
                }
            }
        }
    }

    private function _loadHelpers()
    {
        require_once __DIR__.'/../Helpers/debug_helper.php';
        require_once __DIR__.'/../Helpers/modules_helper.php';
        require_once __DIR__.'/../Helpers/langs_helper.php';
        require_once __DIR__.'/../Helpers/labels_helper.php';
    }
}
