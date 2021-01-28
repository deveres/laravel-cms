<?php
/**
 * Created by PhpStorm.
 * User: veres
 * Date: 10/5/2018
 * Time: 8:50 PM.
 */

namespace App\Src\Admin\Extensions\Core;

use Encore\Admin\Form\Builder;

class CustomBuilder extends Builder
{
    public function render(): string
    {
        $formRightObj = $this->form->getRightPanel();
        $this->removeReservedFields();

        $tabObj = $this->form->setTab();

        if (!$tabObj->isEmpty()) {
            $this->addTabformScript();
        }

        $this->addCascadeScript();

        $data = [
            'form'         => $this,
            'tabObj'       => $tabObj,
            'width'        => $this->width,
            'layout'       => $this->form->getLayout(),
            'formRightObj' => $formRightObj,
        ];

        return view($this->view, $data)->render();
    }
}
