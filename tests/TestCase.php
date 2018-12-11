<?php

namespace Tests;

use Illuminate\Filesystem\Filesystem;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
//use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Laravel\BrowserKitTesting\TestCase as BaseTestCase;
use App;



class TestCase extends BaseTestCase
{

    use DatabaseTransactions;
    use CreatesApplication;
    //use DatabaseMigrations;

    public $env = null;
    protected $baseUrl = 'http://localhost:8000';

    public function setUp()
    {

        parent::setUp();

        $this->env = $this->app->environment();

/*
        echo 'Env set to: '.$this->env.PHP_EOL;
        echo 'DB_CONNECTION='.env('DB_CONNECTION' ).PHP_EOL;
        echo 'DB_HOST='.env('DB_HOST' ).PHP_EOL;
        echo 'DB_PORT='.env('DB_PORT' ).PHP_EOL;
        echo 'DB_DATABASE='.env('DB_DATABASE' ).PHP_EOL;
        echo '-----------------------------------------------'.PHP_EOL;
*/

        $adminConfig = require __DIR__ . '/../config/admin.php';


        $this->app['config']->set('debugbar.enabled', env('DEBUGBAR_ENABLED', false));
        $this->app['config']->set('database.default', 'pgsql');
        $this->app['config']->set('database.connections.pgsql.driver', 'pgsql');
        $this->app['config']->set('database.connections.pgsql.host', env('DB_HOST', '127.0.0.1'));
        $this->app['config']->set('database.connections.pgsql.port', '5432');


        $this->app['config']->set('app.key', 'AckfSECXIvnK5r28GVIWUAxmbBSjTsmF');
        $this->app['config']->set('filesystems', require __DIR__ . '/../config/filesystems.php');
        $this->app['config']->set('admin', $adminConfig);

        foreach (array_dot(array_get($adminConfig, 'auth'), 'auth.') as $key => $value) {
            $this->app['config']->set($key, $value);
        }

        $this->artisan('vendor:publish', ['--provider' => 'Encore\Admin\AdminServiceProvider']);

        Schema::defaultStringLength(191);

        $this->artisan('admin:install');

        $this->migrateTestTables($this->env);

        $this->registerConfig();

        if (file_exists($routes = admin_path('routes.php'))) {
            require $routes;
        }


    }

    /**
     * @param string $env
     */
    public function migrateTestTables($env = 'testing')
    {
        $this->artisan('migrate', ['--env' => $env]);
    }

    public function registerConfig()
    {
        $files = glob(app_path('Src/Config/') . '*.php');
        if ($files) {
            foreach ($files as $one) {
                $tmp = explode('.', basename($one));
                $label = strtolower(array_shift($tmp));
                if ($label) {
                    $configs = require_once $one;

                    if (isset($configs['path']) && $configs['path']) {
                        $this->mergeConfigFrom($one, 'modules.' . $configs['path']);
                    }
                }
            }
        }
    }

    public function tearDown()
    {

        $this->refresh($this->env);
        parent::tearDown();


    }

    public function refresh($env = 'testing')
    {
        //$this->artisan('migrate:reset', ['--env' => $env]);
        $this->artisan('migrate:refresh', ['--env' => $env]);
    }

    public function rollback($env = 'testing')
    {
        //$this->artisan('migrate:reset', ['--env' => $env]);
        $this->artisan('migrate:rollback', ['--env' => $env]);
    }

    public function reset($env = 'testing')
    {
        //$this->artisan('migrate:reset', ['--env' => $env]);
        $this->artisan('migrate:reset', ['--env' => $env]);
    }
}
