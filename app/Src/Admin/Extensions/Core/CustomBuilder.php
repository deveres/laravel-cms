<?php
/**
 * Created by PhpStorm.
 * User: veres
 * Date: 10/5/2018
 * Time: 8:50 PM
 */

namespace App\Src\Admin\Extensions\Core;


use Encore\Admin\Form\Builder;
use Encore\Admin\Admin;

class CustomBuilder extends Builder
{


    public function render()
    {
        $this->removeReservedFields();

        $formRightObj = $this->form->getRightPanel();
        $tabObj = $this->form->getTab();

        if (!$tabObj->isEmpty()) {
            $script = <<<'SCRIPT'

var hash = document.location.hash;
if (hash) {
    $('.nav-tabs a[href="' + hash + '"]').tab('show');
}

// Change hash for page-reload
$('.nav-tabs a').on('shown.bs.tab', function (e) {
    history.pushState(null,null, e.target.hash);
});

if ($('.has-error').length) {
    $('.has-error').each(function () {
        var tabId = '#'+$(this).closest('.tab-pane').attr('id');
        $('li a[href="'+tabId+'"] i').removeClass('hide');
    });

    var first = $('.has-error:first').closest('.tab-pane').attr('id');
    $('li a[href="#'+first+'"]').tab('show');
}

SCRIPT;
            Admin::script($script);
        }

        $data = [
            'form' => $this,
            'tabObj' => $tabObj,
            'width' => $this->width,
            'formRightObj' => $formRightObj,
        ];

        return view($this->view, $data)->render();
    }


}