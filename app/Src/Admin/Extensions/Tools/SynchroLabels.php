<?php

namespace App\Src\Admin\Extensions\Tools;

use Encore\Admin\Admin;
use Encore\Admin\Grid\Tools\AbstractTool;
use Illuminate\Support\Facades\Request;

class SynchroLabels extends AbstractTool
{
    public function render()
    {
        Admin::script($this->script());

        return view('admin::tools.synchro_labels');
    }

    protected function script()
    {
        $url = Request::fullUrlWithQuery(['synchro-labels' => '_synchro-labels_']);

        //@todo set messages from
        $message = trans('admin.refresh_succeeded');

        $url = route('synchro-labels');

        return <<<EOT
         (function(){
            var synchroLabels=0;
            $('.synchro-labels').click(function () {
               if (synchroLabels==1){
                 toastr.warning('Синхронизация уже запущена, дождитесь окончания.');
                 return false;
               }
                 synchroLabels=1;
        
                 $.ajax({
                    method: 'post',
                    url: '{$url}',
                    data: {
                        _token:LA.token                    
                    },
                    success: function () {
                        synchroLabels=0;
                        toastr.success('Синхронизация прошла успешно');
                    },
                    error:function(){
                        synchroLabels=0;
                    }
                  });

             });
         }());
EOT;
    }
}
