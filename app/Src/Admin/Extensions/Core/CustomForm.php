<?php
/**
 * Created by PhpStorm.
 * User: vadim
 * Date: 05.10.2018
 * Time: 17:51.
 */

namespace App\Src\Admin\Extensions\Core;

use Closure;
use Encore\Admin\Form;

class CustomForm extends Form
{
    /**
     * @var null
     */
    protected $rightPanel = null;

    /**
     * CustomForm constructor.
     *
     * @param $model
     * @param Closure|null $callback
     */
    public function __construct($model, Closure $callback = null)
    {
        $this->model = $model;

        $this->builder = new CustomBuilder($this);

        if ($callback instanceof Closure) {
            $callback($this);
        }
    }

    /**
     * Get Tab instance.
     *
     * @return CustomTab
     */
    public function getTab()
    {
        if (is_null($this->tab)) {
            $this->tab = new CustomTab($this);
        }

        return $this->tab;
    }

    /**
     * right panel.
     *
     * @param $title
     * @param Closure $content
     * @param bool    $active
     *
     * @return $this
     */
    public function rightPanel($title, Closure $content, $active = false)
    {
        $this->getRightPanel()->append($title, $content, $active);

        return $this;
    }

    /**
     * @return FormRightPanel|Form\Tab
     */
    public function getRightPanel()
    {
        if (is_null($this->rightPanel)) {
            $this->rightPanel = new FormRightPanel($this);
        }

        return $this->rightPanel;
    }
}
