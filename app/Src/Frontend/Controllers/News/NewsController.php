<?php

namespace App\Src\Frontend\Controllers\News;

use App\Http\Controllers\FrontendController;
use App\Src\Models\News\ModNews;
use Illuminate\Http\Request;

class NewsController extends FrontendController
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //$this->middleware('auth');
        parent::__construct();
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $filter = $request->all();

        $news = ModNews::query()->where('state', 1)->paginate();
        $news->appends($filter);

        return view('frontend.news.index', compact('news'));
    }

    public function view(Request $request, ModNews $modNews)
    {
        $this->setMetaH1($modNews->seo_h1);
        $this->setMetaTitle($modNews->seo_title);
        $this->setMetaDescription($modNews->seo_description);
        $this->setMetaKeywords($modNews->seo_keywords);

        return view('frontend.news.view', ['news' => $modNews]);
    }
}
