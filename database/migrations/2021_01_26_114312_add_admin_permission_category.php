<?php

use App\Src\Models\Menu\Menu;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class AddAdminPermissionCategory extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //
        Schema::create(config('admin.database.permissions_category_table'), function (Blueprint $table) {
            $table->increments('id');
            $table->string('name', 255)->nullable();
        });

        DB::table(config('admin.database.permissions_category_table'))->insert(['name' => 'General']);
        $permission = DB::table(config('admin.database.menu_table'))->where('title', 'Permission')->first();
        if ($permission) {
            $menu = new Menu(
                [
                    'title'      => 'Permission Categories',
                    'icon'       => 'fa-clone',
                    'icon_color' => '#FFFFFF',
                    'uri'        => '/auth/permissions-cat',
                    'parent_id'  => $permission->id,

                ]
            );
            $menu->save();
        }

        Schema::table(config('admin.database.permissions_table'), function (Blueprint $table) {
            $table->unsignedInteger('cat_id')->default(1);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
        Schema::dropIfExists(config('admin.database.permissions_category_table'));
        Schema::table(config('admin.database.permissions_table'), function (Blueprint $table) {
            $table->dropColumn('cat_id');
        });
    }
}
