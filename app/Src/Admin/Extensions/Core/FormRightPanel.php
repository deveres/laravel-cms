<?php
/**
 * Created by PhpStorm.
 * User: veres
 * Date: 10/5/2018
 * Time: 9:15 PM.
 */

namespace App\Src\Admin\Extensions\Core;

use Encore\Admin\Form;
use Illuminate\Support\Collection;

class FormRightPanel
{
    /**
     * @var Form
     */
    protected $form;

    /**
     * @var Collection
     */
    protected $panels;

    /**
     * @var int
     */
    protected $offset = 0;

    /**
     * Panels constructor.
     *
     * @param Form $form
     */
    public function __construct(Form $form)
    {
        $this->form = $form;

        $this->panels = new Collection();
    }

    public function getOffset()
    {
        return $this->offset;
    }

    /**
     * append right panel.
     *
     * @param $title
     * @param \Closure $content
     * @param bool     $active
     * @param string   $theme
     * @param integer   $offset
     *
     * @return $this
     */
    public function append($title, \Closure $content, $active = false, $theme = 'danger', $offset = 0)
    {
        if ($offset>0){
            $this->offset = $offset;
        }


        $fields = $this->collectFields($content);

        $id = 'form-'.($this->panels->count() + 1);


        $this->panels->push(compact('id', 'title', 'fields', 'active', 'theme'));

        return $this;
    }

    /**
     * Collect fields under current panel.
     *
     * @param \Closure $content
     *
     * @return Collection
     */
    protected function collectFields(\Closure $content)
    {
        call_user_func($content, $this->form);

        $fields = clone $this->form->builder()->fields();

        $all = $fields->toArray();
        $tabPanels = clone $this->form->getTab();

        if (is_object($tabPanels) && $tabPanels instanceof CustomTab) {
            if ($this->offset == 0) {
                $this->offset = $tabPanels->getOffset();
            }
        }

        foreach ($this->form->rows as $row) {
            $rowFields = array_map(function ($field) {
                return $field['element'];
            }, $row->getFields());

            $match = false;

            foreach ($rowFields as $field) {
                if (($index = array_search($field, $all)) !== false) {
                    if (!$match) {
                        $fields->put($index, $row);
                    } else {
                        $fields->pull($index);
                    }

                    $match = true;
                }
            }
        }

        $fields = $fields->slice($this->offset);

        $this->offset += $fields->count();

        return $fields;
    }

    /**
     * Get all panels.
     *
     * @return Collection
     */
    public function getPanels()
    {
        // If there is no active tab, then active the first.
        if ($this->panels->filter(function ($panel) {
            return $panel['active'];
        })->isEmpty()) {
            $first = $this->panels->first();
            $first['active'] = true;

            $this->panels->offsetSet(0, $first);
        }

        return $this->panels;
    }

    /**
     * @return bool
     */
    public function isEmpty()
    {
        return $this->panels->isEmpty();
    }
}
