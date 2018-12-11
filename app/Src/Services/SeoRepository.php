<?php

namespace App\Src\Services;


use App\Src\Models\Seo\ModSeo;

class SeoRepository
{


    public static function getByUri($uri = null)
    {
        if (!$uri) {
            return [];
        }

        $item = ModSeo::query()
            ->where('state', 1)
            ->where('link', $uri)
            ->first();

        return $item;
    }
}
