<?php

namespace App\Http\Middleware;

use Closure;
use Encore\Admin\Config\Config;

class DebugModeMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param \Illuminate\Http\Request $request
     * @param \Closure                 $next
     *
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if ((config('debugbar.enabled', null) === true || config('debugbar.enabled', null) === null) && config('enable_debug', 0)) {
            \Debugbar::enable();
        } else {
            \Debugbar::disable();
        }

        if (config('enable_log', 1)) {
            config(['admin.operation_log.enable' => true]);
        } else {
            config(['admin.operation_log.enable' => false]);
        }

        return $next($request);
    }
}
