<?php

namespace App\Src\Admin\Extensions\Grid\RowDisplayers;

use Encore\Admin\Grid\Displayers\AbstractDisplayer;
use Illuminate\Contracts\Support\Arrayable;
use Illuminate\Support\Arr;

class LabelGridDisplayer extends AbstractDisplayer
{
    public function display($style = 'success')
    {
        if ($this->value instanceof Arrayable) {
            $this->value = $this->value->toArray();
        }

        return collect((array) $this->value)->map(function ($item) use ($style) {
            if (is_array($style)) {
                if (is_string($this->getColumn()->getOriginal()) || is_int($this->getColumn()->getOriginal())) {
                    $style = Arr::get($style, $this->getColumn()->getOriginal(), 'success');
                } else {
                    $style = Arr::get($style, $item, 'success');
                }
            }

            return "<span class='label label-{$style}'>$item</span>";
        })->implode(' ');
    }
}
