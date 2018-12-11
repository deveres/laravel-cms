<?php

namespace App\Src\Admin\Extensions\Tools;

use Encore\Admin\Admin;
use Encore\Admin\Grid\Tools\AbstractTool;
use Illuminate\Support\Facades\Request;

class CreateLabels extends AbstractTool
{
    public $parent_value=0;

    public function __construct($parent = 0)
    {
        $this->parent_value = $parent;
    }

    public function render()
    {
        Admin::script($this->script());

        return view('admin::tools.create_labels');
    }

    protected function script()
    {
        $url = Request::fullUrlWithQuery(['create-labels' => '_create-label_']);

        //@todo set messages from
        $message = trans('admin.refresh_succeeded');

        return "(function(){
        
        function randString(n)
        {
            if(!n)
            {
                n = 5;
            }
        
            var text = '';
            var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        
            for(var i=0; i < n; i++)
            {
                text += possible.charAt(Math.floor(Math.random() * possible.length));
            }
        
            return text;
        }

var createLabels=0;
$('.create-labels').click(function () {
       if (createLabels==1){
         toastr.warning('Зaпрос уже отправлен, дождитесь окончания.');
         return false;
       }
        createLabels=1;
        
        $.ajax({
                method: 'post',
                url: '{$this->grid->resource()}',
                data: {
                    _token:LA.token,
                           label: 'label__'+randString(10),
                           parent_id: '{$this->parent_value}'           
                },
                success: function () {
                    createLabels=0;
                    $.pjax.reload('#pjax-container');
                    toastr.success('Создано...');
                },
                error:function(){
                    createLabels=0;
                }
            });

});
 }());
";
    }
}
