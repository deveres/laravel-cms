<?php
/**
 * Created by PhpStorm.
 * User: vadim
 * Date: 05.10.2018
 * Time: 12:41.
 */

namespace App\Src\Admin\Extensions\Form;

use Encore\Admin\Form\Field;

class Translit extends Field
{
    use Field\PlainInput;

    protected static $js = [
        'backend/js/translit.js',
    ];

    protected $from_field = 'edit[name]';
    protected $lock_state = 0;
    protected $lock_alias = 'lock_alias';

    public function __construct($column, $arguments)
    {
        if (isset($arguments[0])) {
            $item = trim(array_shift($arguments));
            $this->from_field = $item ?: $this->from_field;
        }
        if (isset($arguments[0])) {
            $item = trim(array_shift($arguments));
            $this->lock_alias = $item ?: $this->lock_alias;
        }
        if (isset($arguments[0])) {
            $item = trim(array_shift($arguments));
            $this->lock_state = $item ?: $this->lock_state;
        }

        $this->column = $column;
        $this->label = $this->formatLabel($arguments);
        $this->id = $this->formatId($column);
    }

    public function render()
    {
        $from_field = $this->from_field;
        $lock_alias = $this->lock_alias;
        $lock_state = $this->lock_state;

        unset($this->attributes['from'], $this->attributes['lock_alias'], $this->attributes['state']);

        $this->initPlainInput();

        $this->prepend('<i class="fa fa-pencil fa-fw"></i>')
            ->defaultAttribute('type', 'text')
            ->defaultAttribute('id', $this->id)
            ->defaultAttribute('name', $this->elementName ?: $this->formatName($this->column))
            ->defaultAttribute('value', old($this->column, $this->value()))
            ->defaultAttribute('class', 'form-control '.$this->getElementClassString())
            ->defaultAttribute('placeholder', $this->getPlaceholder());

        if ($lock_alias) {
            if ($lock_state) {
                $this->defaultAttribute('readonly', 'readonly');
            }
            $img = $lock_state ? asset('backend/images/lock_on22.png') : asset('backend/images/lock_off22.png');
            $this->append("
                        <img src='".$img."' title='Заблокировать алиас для редактирования'
                         style='margin-bottom:-5px; cursor:pointer;'   class='".$lock_alias."_field_img' />
                   ");
        }

        $this->addVariables([
            'prepend' => $this->prepend,
            'append'  => $this->append,
        ]);

        $translite_from = $from_field;
        $translite_to = $this->column();
        $theme = asset('backend/');

        $this->script = <<<EOT

var theme='{$theme}';
var translite_from = '{$translite_from}';
var translite_to = '{$translite_to}';


	Translit.set('input[name="'+translite_from+'"]', 'input[name="'+translite_to+'"]');
	
	 $(document).off("click", ".{$lock_alias}_field_img");
	 $(document).on("click",".{$lock_alias}_field_img",function(e) {
                obj = $(this);
            var label_field = $('input[name="'+translite_to+'"]');
            if (obj.attr('src').toString().indexOf('lock_off') != -1){
                obj.attr('src', theme+"/images/lock_on22.png") ;
                label_field.css({'background-color' : '#f6f6f5'}).attr('readonly', true);
                $('input[name="{$lock_alias}"]').val(1);
            } else {
                obj.attr('src', theme+"/images/lock_off22.png") ;
                label_field.css({'background-color' : 'transparent'}).attr('readonly', false);
                $('input[name="{$lock_alias}"]').val(0);
            }
                        
        });
    




EOT;

        return parent::render();
    }
}
