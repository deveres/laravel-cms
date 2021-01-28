<?php

return [
    'name'        => 'Модули',  // первый сегмент в крумбсах
    'path'        => 'modules',   // урл и алиас в конфигах модуля;
    'icon'        => 'fa-cubes',  //иконка в меню
    'description' => 'Модули',

    // используется для созданияч прав при инсталлировании модуля
    'resources' => [
        'modules' => ['name' => 'Модули', 'description' => 'список модулей'],
    ],

    // верхнее быстрое меню
    'admin_menu' => [
        [
            'title'    => 'Модули',
            'link'     => admin_base_path().'/modules',
            'resource' => 'modules',
        ],

    ],
];
