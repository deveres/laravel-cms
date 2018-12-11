<?php

use Faker\Generator as Faker;

$factory->define(\App\Src\Models\News::class, function (Faker $faker) {
    return [
        //
        'title' => $faker->text(100),
        'alias' => $faker->unique()->slug(1),
        'state' => 1,
        'lock_alias' => 1,
        'comments_enabled' => 1,
        'photo' => ''

    ];
});
