<?php

namespace App\Src\Admin\Extensions\Grid\RowActions;

use App\Src\Admin\Services\AdminMenuService;
use App\Src\Models\Modules\Module;
use Encore\Admin\Actions\RowAction;

class ModuleInstallGridRowAction extends RowAction
{
    public function handle(Module $module)
    {
        if ($module) {
            if (AdminMenuService::installModuleMenu($module)) {
                $module->state = 1;
                $module->save();
            }
        }

        // return a new html to the front end after saving
        if ($module->state == 1) {
            $html = "<span class='label label-success'>Установлен</span>";
        } else {
            $html = "<span class='label label-error'>Не установлен</span>";
        }

        return $this->response()->html($html);
    }

    // This method displays different icons in this column based on the value of the `star` field.
    public function display($star)
    {
        return "<i class='fa fa-rocket'></i>";
    }
}
