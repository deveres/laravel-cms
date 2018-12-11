<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddCategoryNameToPermissionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('admin_permissions_categories', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name', 255);
            // $table->timestamps();
        });

        Schema::table('admin_permissions', function (Blueprint $table) {
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
        Schema::table('admin_permissions', function (Blueprint $table) {
            $table->dropColumn('cat_id');
        });

        Schema::dropIfExists('admin_permissions_categories');
    }
}
