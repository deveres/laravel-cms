<?php

return [
    'name' => 'Модули',  // первый сегмент в крумбсах
    'path' => 'modules',   // урл и алиас в конфигах модуля;
    'icon' => 'fa-cubes',
    'description' => 'Модули',


    'resources' => array(
        'modules' => array('name' => 'Модули', 'description' => 'список'),
    ),


    'admin_menu' => array(
        array(
            'title' => 'Модули',
            'link' => admin_base_path() . 'modules',
            'resource' => 'modules'
        ),


    )
];
