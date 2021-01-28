<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddAdminMenuIconColor extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //
        Schema::table(config('admin.database.menu_table'), function (Blueprint $table) {
            $table->string('icon_color', 7)->default('#FFFFFF');
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
        Schema::table(config('admin.database.menu_table'), function (Blueprint $table) {
            $table->dropColumn('icon_color');
        });
    }
}
