<?php

namespace App\Src\Frontend\Controllers;

use App\Http\Controllers\FrontendController;

class IndexController extends FrontendController
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('frontend.index');
    }
}
