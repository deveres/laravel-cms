<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateModulesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('system_modules', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('parent_id')->default(0);
            $table->string('key', 100);
            $table->string('path', 100);
            $table->string('name', 250);
            $table->string('icon', 50)->nullable();
            $table->string('icon_color', 10)->nullable()->default('#FFFFFF');
            $table->string('description')->nullable();

            $table->tinyInteger('state')->default(1);
            $table->integer('module_order')->default(0);


            $table->index('state');
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('system_modules');
    }
}
