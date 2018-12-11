<?php

namespace App\Src\Admin\Extensions;

use Encore\Admin\Admin;
use Encore\Admin\Grid\Displayers\AbstractDisplayer;


class ModuleInstall extends AbstractDisplayer
{


    public function display($outGrid = 'left')
    {

        Admin::script($this->_getScript(route('modules.module-install')));

        return "<a class='grid-check-row' data-id='{$this->row->id}' title='Установить/Переустановить модуль'><i class='fa fa-rocket'></i></a>";
    }

    protected function _getScript($route = null)
    {
        $url = $route;

        return <<<EOT
        (function(){
            var installModules=0;
            $('.grid-check-row').on('click', function () {
            
                    var id = $(this).attr('data-id');
                    
                     if (installModules==1){
                         toastr.warning('Установка уже запущена, дождитесь окончания.');
                         return false;
                     }
                     installModules=1;
            
                     $.ajax({
                        method: 'post',
                        url: '{$url}',
                        data: {
                            _token:LA.token,
                            id : id                    
                        },
                        success: function () {
                            installModules=0;
                            $.pjax.reload('#pjax-container');
                            toastr.success('Установка прошла успешно');
                        },
                        error:function(){
                            installModules=0;
                        }
                      });
        
            });
        }());
EOT;
    }
}