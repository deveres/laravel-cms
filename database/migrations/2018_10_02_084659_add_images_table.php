<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddImagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create(env('DB_TABLE_PREFIX', 'mod_').'images', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('item_id')->nullable()->default(0);
            $table->string('module', 100)->nullable();
            $table->unsignedInteger('main')->nullable()->default(0);
            $table->string('path', 255)->nullable();
            $table->string('filename', 255)->nullable();
            $table->string('alt', 100)->nullable();
            $table->string('disk', 100)->nullable();

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists(env('DB_TABLE_PREFIX', 'mod_').'images');
    }
}
