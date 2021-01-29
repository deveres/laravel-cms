<?php

/**
 * Laravel-admin - admin builder based on Laravel.
 *
 * @author z-song <https://github.com/z-song>
 *
 * Bootstraper for Admin.
 *
 * Here you can remove builtin form field:
 * Encore\Admin\Form::forget(['map', 'editor']);
 *
 * Or extend custom form field:
 * Encore\Admin\Form::extend('php', PHPEditor::class);
 *
 * Or require js and css assets:
 * Admin::css('/packages/prettydocs/css/styles.css');
 * Admin::js('/packages/prettydocs/js/main.js');
 */

use App\Src\Admin\Extensions\Form\HtmlFull;
use App\Src\Admin\Extensions\Form\Translit;
use App\Src\Admin\Extensions\Grid\RowDisplayers\LabelGridDisplayer;
use App\Src\Admin\Extensions\Grid\RowDisplayers\RowOrderableGridDisplayer;
use App\Src\Admin\Extensions\Grid\RowDisplayers\TreeNameGridDisplayer;
use Encore\Admin\Form;
use Encore\Admin\Grid\Column;

Encore\Admin\Form::forget(['map', 'editor']);

Column::extend('rowOrderable', RowOrderableGridDisplayer::class); //перетаскивание строк - в гриде
Column::extend('treeName', TreeNameGridDisplayer::class);         // дерево в таблице  - в гриде
Column::extend('customLabel', LabelGridDisplayer::class);         // метки  - в гриде

Form::extend('translit', Translit::class);            // транслит - в формах

Form::extend('htmlFull', HtmlFull::class);
