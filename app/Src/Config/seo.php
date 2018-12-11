<?php

return [
    'name' => 'SEO',  // первый сегмент в крумбсах
    'path' => 'seo',   // урл и алиас в конфигах модуля;
    'icon' => 'fa-compass',
    'icon_color' => '#ffb600',
    'description' => 'Модуль SEO настроек для страниц.',


    // используется в контролерах для вывода титула и дескрипшна
    'resources' => array(
        'seo' => array('name' => 'SEO', 'description' => 'список', 'icon' => 'fa-compass'),
    ),


    'admin_menu' => array(
        array(
            'title' => 'SEO',
            'link' => admin_base_path() . 'seo',
            'resource' => 'seo'
        ),


    ),

    'images' => [
        'items' => array(
            'name' => 'SEO',
            'link' => "/files/seo/list/",
            'path' => "/files/seo/list/",
            'rule' => 'image|mimes:jpg,jpeg,png,gif|max:2097152',
            'file_types_title' => 'Изображения',
            'file_types' => 'jpg,jpeg,png,gif',
            'file_size' => '2mb',

            'autoresize' => true,


            'size' => array(
                '100' => array('100', '100'),  // for preview
                '191' => array('191', '161'),
                '469' => array('469', '449')
            )
        )
    ]


];
