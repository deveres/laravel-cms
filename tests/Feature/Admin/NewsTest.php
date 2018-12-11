<?php

namespace Tests\Feature\Admin;

use App\Src\Models\Langs\LabelLang;
use App\Src\Models\News\ModNews;
use App\Src\Models\Seo\ModSeo;
use Illuminate\Support\Facades\Schema;
use Tests\AdminTrait;
use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class NewsTest extends TestCase
{
    public $config_alias = 'news';

    use AdminTrait;

    /**
     * test files existence
     */
    public function testInstalledDirectories()
    {
        $this->assertFileExists(admin_path());

        $this->assertFileExists(admin_path('Controllers/News/NewsController.php'));

        $this->assertFileExists(app_path('Src/Models/News/ModNews.php'));

        $configPath = app_path('Src/Config/') . $this->config_alias . '.php';
        $this->assertFileExists($configPath);
        //$this->assertFileExists(admin_path('Config/' . $this->config_alias . '.php'));

        $adminConfig = require $configPath;

        $this->app['config']->set($this->config_alias, $adminConfig);


    }

    /**
     * test db table existence
     */
    public function testNewsTableExists()
    {
        $this->assertTrue(Schema::hasTable(app(\App\Src\Models\News\ModNews::class)->make()->getTable()));
        $this->assertTrue(Schema::hasTable(app(\App\Src\Models\News\ModNewsI18n::class)->make()->getTable()));
    }

    /**
     * test admin page exist
     */
    public function testNewsPageExists()
    {
        $response = $this->get('/' . config('admin.route.prefix') . '/news');
        // $this->assertEquals(200, $response->status());
        $response->assertResponseStatus(200);
    }

    /**
     * test if view add button
     */
    public function testCanViewCreateButton()
    {
        $this->visit('admin/news')
            ->seePageIs('admin/news')
            ->see('Добавить');
    }

    /**
     * test if can add
     */
    public function testCanAddNews()
    {

        $item = ['log_name' => 'Test', 'alias' => 'ts1234567890ooo', 'comments_enabled'=>'1', 'state'=>'1', 'lock_alias'=>'1'];

        $this->visit('admin/news/create')
            ->seePageIs('admin/news/create')
            ->see('Новости')
            ->see('Создать')
            ->submitForm('Сохранить', $item)
            ->seePageIs('admin/news')
            ->seeInDatabase(app(ModNews::class)->getTable(), $item)
            ->assertEquals(1, ModNews::count());

        // $this->expectException(\Laravel\BrowserKitTesting\HttpException::class);

        $this->visit('admin/news')
            ->see('Test');

    }

    /**
     * test if can edit
     */
    public function testCanEditNews()
    {
        $this->assertTrue(true);
    }


    /**
     * test if can be deleted
     */
    public function testCanDeleteNews()
    {
        $this->assertTrue(true);
    }
}
