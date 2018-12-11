<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AddSrcReferenceColumnToTranslations extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('ltm_translations', function (Blueprint $table) {
            $table->string('source', 256)->nullable();
            $table->unique(['locale', 'group', 'key'], 'ixk_ltm_translations_locale_group_key');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('ltm_translations', function (Blueprint $table) {
            $table->dropColumn('source');
            $table->dropUnique('ixk_ltm_translations_locale_group_key');
        });
    }
}
