<?php

namespace App\Src\Admin\Extensions\Core;

use Encore\Admin\Form\Tab;
use Illuminate\Support\Collection;

class CustomTab extends Tab
{
    public function getOffset()
    {
        return $this->offset;
    }

    /**
     * Collect fields under current tab.
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
        $rightPanels = clone $this->form->getRightPanel();

        if (is_object($rightPanels) && $rightPanels instanceof FormRightPanel) {
            if ($this->offset == 0) {
                $this->offset = $rightPanels->getOffset();
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
}
