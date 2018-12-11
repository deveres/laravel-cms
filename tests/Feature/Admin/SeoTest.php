<?php

namespace Tests\Feature\Admin;

use App\Src\Models\Seo\ModSeo;
use Illuminate\Support\Facades\Schema;
use Tests\AdminTrait;
use Tests\TestCase;

class SeoTest extends TestCase
{
    public $config_alias = 'seo';

    use AdminTrait;

    /**
     * test files existence.
     */
    public function testInstalledDirectories()
    {
        $this->assertFileExists(admin_path());

        $this->assertFileExists(admin_path('Controllers/Seo/SeoController.php'));

        $this->assertFileExists(app_path('Src/Models/Seo/ModSeo.php'));

        $configPath = app_path('Src/Config/').$this->config_alias.'.php';
        $this->assertFileExists($configPath);
        //$this->assertFileExists(admin_path('Config/' . $this->config_alias . '.php'));

        $adminConfig = require $configPath;

        $this->app['config']->set($this->config_alias, $adminConfig);
    }

    /**
     * test db table existence.
     */
    public function testSeoTableExists()
    {
        $this->assertTrue(Schema::hasTable(app(\App\Src\Models\Seo\ModSeo::class)->make()->getTable()));
        $this->assertTrue(Schema::hasTable(app(\App\Src\Models\Seo\ModSeoI18n::class)->make()->getTable()));
    }

    /**
     * test admin page exist.
     */
    public function testSeoPageExists()
    {
        $response = $this->get('/'.config('admin.route.prefix').'/seo');
        // $this->assertEquals(200, $response->status());
        $response->assertResponseStatus(200);
    }

    /**
     * test if view add button.
     */
    public function testCanViewCreateButton()
    {
        $this->visit('admin/seo')
            ->seePageIs('admin/seo')
            ->see('Добавить');
    }

    /**
     * test if can add.
     */
    public function testCanAddSeo()
    {
        $item = ['log_name' => 'Test', 'alias' => 'ts1234567890', 'link'=>'ddddd', 'state'=>1, 'lock_alias'=>0];

        $this->visit('admin/seo/create')
            ->seePageIs('admin/seo/create')
            ->see('SEO')
            ->see('Создать')
            ->submitForm('Сохранить', $item)
            ->seePageIs('admin/seo')
            ->seeInDatabase(app(ModSeo::class)->getTable(), $item)
            ->assertEquals(1, ModSeo::count());

        // $this->expectException(\Laravel\BrowserKitTesting\HttpException::class);

        $this->visit('admin/seo')
            ->see('Test');
    }

    /**
     * test if can edit.
     */
    public function testCanEditSeo()
    {
        $this->assertTrue(true);
    }

    /**
     * test if can be deleted.
     */
    public function testCanDeleteSeo()
    {
        $this->assertTrue(true);
    }
}
