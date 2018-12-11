<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLangsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('label_langs', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('alias', 50)->nullable();
            $table->integer('ord')->default(0);
            $table->integer('state')->default(0);
            $table->integer('default')->default(0);

            $table->unique(['alias']);
            // $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('label_langs');
    }
}
