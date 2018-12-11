<?php

namespace Tests\Feature\Admin;

use App\Src\Models\Langs\LabelLang;
use Illuminate\Support\Facades\Schema;
use Tests\AdminTrait;
use Tests\TestCase;
use Illuminate\Foundation\Testing\RefreshDatabase;

class LangsTest extends TestCase
{
    public $config_alias = 'langs';

    use AdminTrait;

    /**
     * test files existence
     */
    public function testInstalledDirectories()
    {
        $this->assertFileExists(admin_path());

        $this->assertFileExists(admin_path('Controllers/Langs/LangsController.php'));

        $this->assertFileExists(app_path('Src/Models/Langs/LabelLang.php'));

        $configPath = app_path('Src/Config/') . $this->config_alias . '.php';
        $this->assertFileExists($configPath);
        //$this->assertFileExists(admin_path('Config/' . $this->config_alias . '.php'));

        $adminConfig = require $configPath;

        $this->app['config']->set($this->config_alias, $adminConfig);


    }

    /**
     * test db table existence
     */
    public function testLangsTableExists()
    {
        $this->assertTrue(Schema::hasTable(app(\App\Src\Models\Langs\LabelLang::class)->make()->getTable()));
    }

    /**
     * test admin page exist
     */
    public function testLangsPageExists()
    {
        $response = $this->get('/' . config('admin.route.prefix') . '/langs');
        // $this->assertEquals(200, $response->status());
        $response->assertResponseStatus(200);
    }

    /**
     * test if view add button
     */
    public function testCanViewCreateButton()
    {
        $this->visit('admin/langs')
            ->seePageIs('admin/langs')
            ->see('Добавить');
    }

    /**
     * test if can add
     */
    public function testCanAddLanguages()
    {

        $item = ['name' => 'Test', 'alias' => 'ts'];

        $this->visit('admin/langs/create')
            ->seePageIs('admin/langs/create')
            ->see('Языки')
            ->see('Создать')
            ->submitForm('Сохранить', $item)
            ->seePageIs('admin/langs')
            ->seeInDatabase(app(LabelLang::class)->getTable(), $item)
            ->assertEquals(3, LabelLang::count());

        // $this->expectException(\Laravel\BrowserKitTesting\HttpException::class);

        $this->visit('admin/langs')
            ->see('Test');

    }

    /**
     * test if can edit
     */
    public function testCanEditLanguages()
    {
        $this->assertTrue(true);
    }


    /**
     * test if can be deleted
     */
    public function testCanDeleteLanguages()
    {
        $this->assertTrue(true);
    }
}
