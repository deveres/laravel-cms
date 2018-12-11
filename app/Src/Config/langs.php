<?php

return [
    'name' => 'Мультиязычность',  // первый сегмент в крумбсах
    'path' => 'langs',   // урл и алиас в конфигах модуля;
    'icon' => 'fa-amazon',
    'icon_color' => '#ffb600',
    'description' => 'Мультиязычность системы, языки метки.',




    // используется в контролерах для вывода титула и дескрипшна
    'resources' => array(
        'langs' => array('name' => 'Языки', 'description'=>'список', 'icon'=>'fa-amazon'),
        'langs_labels' => array('name' => 'Метки', 'description'=>'список', 'icon'=>'fa-bookmark'),
        'langs_cats' => array('name' => 'Категории меток', 'description'=>'список', 'icon'=>'fa-copy'),


    ),


    'admin_menu' => array(
        array(
            'title' => 'Языки',
            'link' => admin_base_path() . 'langs',
            'resource' => 'langs'
        ),
        array(
            'title' => 'Категории',
            'link' => admin_base_path() . 'langs_cats',
            'resource' => 'langs_cats'
        ),
        array(
            'title' => 'Метки',
            'link' => admin_base_path() . 'langs_labels',
            'resource' => 'langs_labels'
        ),

    )
];
