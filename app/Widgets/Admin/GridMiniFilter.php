<?php

namespace App\Widgets\Admin;

use Arrilot\Widgets\AbstractWidget;

class GridMiniFilter extends AbstractWidget
{
    /**
     * The configuration array.
     *
     * @var array
     */
    protected $config = [];

    /**
     * Treat this method as a controller action.
     * Return view() or other content to display.
     */
    public function run()
    {
        //

        $totals = [];
        foreach ($this->config['param_values'] as $key => $one) {
            $totals[(string) $key] = $this->config['model_name']::query()->where($this->config['field_name'],
                $key)->count();
        }

        return view('admin::widgets.grid.grid_mini_filter', [
            'config'     => $this->config,
            'totals'     => $totals,
            'selected'   => request()->get($this->config['param_name'], 0),
            'totals_all' => $this->config['model_name']::query()->count(),
        ]);
    }
}
