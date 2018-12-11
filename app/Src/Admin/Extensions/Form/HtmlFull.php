<?php

namespace App\Src\Admin\Extensions\Form;

use Encore\Admin\Form\Field;

class HtmlFull extends Field
{
    /**
     * Htmlable.
     *
     * @var string|\Closure
     */
    protected $html = '';

    /**
     * @var string
     */
    protected $label = '';

    /**
     * @var bool
     */
    protected $plain = false;

    /**
     * Create a new Html instance.
     *
     * @param mixed $html
     * @param array $arguments
     */
    public function __construct($html, $arguments)
    {
        $this->html = $html;

        $this->label = array_get($arguments, 0);
    }

    /**
     * @return $this
     */
    public function plain()
    {
        $this->plain = true;

        return $this;
    }

    /**
     * Render html field.
     *
     * @return string
     */
    public function render()
    {
        if ($this->html instanceof \Closure) {
            $this->html = $this->html->call($this->form->model(), $this->form);
        }

        if ($this->plain) {
            return $this->html;
        }

        $viewClass = $this->getViewElementClasses();

        return <<<EOT
<div class="form-group">
    <div class="col-md-12">
        {$this->html}
    </div>
</div>
EOT;
    }
}
