<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSeoTables extends Migration
{
    public function up()
    {
        Schema::create(env('DB_TABLE_PREFIX', 'mod_').'seo', function (Blueprint $table) {
            $table->increments('id');
            $table->string('log_name', 255);
            $table->string('alias', 255);
            $table->string('link', 1000);
            $table->tinyInteger('state')->default(0)->unsigned();
            $table->tinyInteger('lock_alias')->default(0)->unsigned();
            $table->timestamps();
        });

        Schema::create(env('DB_TABLE_PREFIX', 'mod_').'seo_i18n', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('row_id')->unsigned();
            $table->string('locale')->index();

            $table->string('introtext', 550)->nullable();
            $table->text('text')->nullable();
            $table->string('seo_h1', 255)->nullable();
            $table->text('seo_title')->nullable();
            $table->text('seo_keywords')->nullable();
            $table->text('seo_description')->nullable();

            $table->unique(['row_id', 'locale']);
            $table->foreign('row_id')->references('id')->on(env(
                'DB_TABLE_PREFIX',
                'mod_'
            ).'seo')->onDelete('cascade');
            $table->foreign('locale')->references('alias')->on('label_langs')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //Schema::dropIfExists('seo_i18n');
        Schema::dropIfExists(env('DB_TABLE_PREFIX', 'mod_').'seo_i18n');
        Schema::dropIfExists(env('DB_TABLE_PREFIX', 'mod_').'seo');
    }
}
