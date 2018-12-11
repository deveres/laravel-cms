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
use App\Src\Admin\Extensions\ModuleInstall;
use App\Src\Admin\Extensions\RowOrderable;
use Encore\Admin\Form;
use Encore\Admin\Grid\Column;

Encore\Admin\Form::forget(['map', 'editor']);

Column::extend('rowOrderable', RowOrderable::class);
Column::extend('moduleInstall', ModuleInstall::class);
Column::extend('treeName', \App\Src\Admin\Extensions\TreeName::class);
Form::extend('translit', \App\Src\Admin\Extensions\Form\Translit::class);
Form::extend('htmlFull', \App\Src\Admin\Extensions\Form\HtmlFull::class);
