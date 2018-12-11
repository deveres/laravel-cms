<?php

namespace App\Src\Admin\Extensions;

use Encore\Admin\Grid\Displayers\AbstractDisplayer;

class TreeName extends AbstractDisplayer
{
    public function display($outGrid = 'left', $route = '', $param = '')
    {
        $grid_data = $outGrid->model()->eloquent()->toArray();
        $row_data = $this->row->toArray();
        $value = $this->row->{$this->column->getName()};
        $id = $this->row->getKey();

        if ($route) {
            $result = '
            <div style="float: right;">
                <a href="' . route($route, [$param => $id]) . '">Перейти</a>
            </div>';
        }

        $result .= '<div style="float: left;">';
        if ($row_data['depth'] > 1) {
            if ($row_data['depth'] > 2) {
                $depth = $row_data['depth'] - 2;
                $counter = 1;
                while ($counter <= $depth) {
                    $parent = $this->_getParent($grid_data, $id, $counter);

                    if (!$parent['last']) {
                        $result .= '<img src="' . asset('backend/images/tree_line3.gif') . '" style="margin-bottom:-2px;" />';
                    } else {
                        $result .= '<img src="' . asset('backend/images/tree_line1.gif') . '" style="margin-bottom:-2px;" />';
                    }
                    ++$counter;
                }

                $result .= '<img src="' . asset('backend/images/tree_line2.gif') . '" style="margin-bottom:-2px;" />';
            } else {
                $result .= str_repeat('<img src="' . asset('backend/images/tree_line2.gif') . '" style="margin-bottom:-2px;" />', $row_data['depth'] - 1);
            }
        }

        if ($row_data['child_count'] > 0) {
            $result .= '<img src="' . asset('backend/images/folder.gif') . '" style="margin-bottom:-2px;"  /> ';
        } else {
            $result .= '<img src="' . asset('backend/images/folder.gif') . '" style="margin-bottom:-2px;"  /> ';
        }
        $result .= $value;
        $result .= '</div>';

        return $result;
    }

    protected function _getParent($grid_data, $id, $depth)
    {
        $row_data = $grid_data[$id];

        $parents = [];
        $parent_id = $row_data['parent_id'];
        while ($parent_id) {
            $parent_data = $grid_data[$parent_id];
            $parent_id = $parent_data['parent_id'];
            $parents[] = $parent_data;
        }

        $parents = array_reverse($parents);

        return $parents[$depth];
    }
}
