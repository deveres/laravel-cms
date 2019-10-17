<?php

return [
    'name'        => 'Новости',  // первый сегмент в крумбсах
    'path'        => 'news',   // урл и алиас в конфигах модуля;
    'icon'        => 'fa-newspaper-o',
    'icon_color'  => '#ffb600',
    'description' => 'Модуль новостей',

    // используется в контролерах для вывода титула и дескрипшна
    'resources' => [
        'news' => ['name' => 'Новости', 'description' => 'список', 'icon' => 'fa-navicon'],
    ],

    'admin_menu' => [
        [
            'title'    => 'Новости',
            'link'     => admin_base_path().'/news',
            'resource' => 'news',
        ],
    ],

    'images' => [
        'items' => [
            'name' => 'Новости',
            'link' => '/files/news/list/',
            'path' => '/files/news/list/',
            'rule' => 'image|mimes:jpg,jpeg,png,gif|max:1048576',

            'file_types_title' => 'Изображения',
            'file_types'       => 'jpg,jpeg,png,gif',
            'file_size'        => '2mb',

            'autoresize' => true,

            'size' => [
                '100' => ['100', '100'],  // for preview
                '401' => ['401', '279'],
            ],
        ],
    ],

];
