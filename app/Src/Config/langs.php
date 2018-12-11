<?php

return [
    'name'        => 'Мультиязычность',  // первый сегмент в крумбсах
    'path'        => 'langs',   // урл и алиас в конфигах модуля;
    'icon'        => 'fa-amazon',
    'icon_color'  => '#ffb600',
    'description' => 'Мультиязычность системы, языки метки.',

    // используется в контролерах для вывода титула и дескрипшна
    'resources' => [
        'langs'        => ['name' => 'Языки', 'description'=>'список', 'icon'=>'fa-amazon'],
        'langs_labels' => ['name' => 'Метки', 'description'=>'список', 'icon'=>'fa-bookmark'],
        'langs_cats'   => ['name' => 'Категории меток', 'description'=>'список', 'icon'=>'fa-copy'],

    ],

    'admin_menu' => [
        [
            'title'    => 'Языки',
            'link'     => admin_base_path().'langs',
            'resource' => 'langs',
        ],
        [
            'title'    => 'Категории',
            'link'     => admin_base_path().'langs_cats',
            'resource' => 'langs_cats',
        ],
        [
            'title'    => 'Метки',
            'link'     => admin_base_path().'langs_labels',
            'resource' => 'langs_labels',
        ],

    ],
];
