<?php

namespace App\Http\Controllers;

use App\Libs\Arrays;
use App\Libs\Registry;
use App\Src\Models\Langs\Label;
use App\Src\Services\SeoRepository;
use Carbon\Carbon;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class FrontendController extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    protected $loginPath = '/';
    protected $redirectAfterLogout = '/';
    private $metaH1 = '';
    private $metaTitle = '';
    private $metaKeywords = '';
    private $metaDescription = '';
    private $metaSeoText = '';

    public function __construct()
    {
        Carbon::setLocale(get_selected_lang_alias());

        $this->view = view();
        $this->_setLabels();
        $this->_setOptions();
        $this->_setMeta();
        $this->_publishMeta();
    }

    private function _setLabels()
    {
        $lang_segment_req = \App::getLocale();
        $default = get_default_lang();
        if ($default['alias'] != get_selected_lang_alias()) {
            // if (get_url_lang_alias() === false && $lang_segment_req && !is_ajax_mode()) direct_reload();
        }

        $labels_model = app(Label::class);
        $labels = $labels_model->getLabels(get_selected_lang_alias());
        Registry::set('labels', $labels);

        $this->view->share('selected_lang_alias', get_selected_lang_alias());
        $this->view->share('cur_lang_alias', get_selected_lang_alias());
        $this->view->share('cur_lang_id', get_selected_lang_id());
    }

    private function _setOptions()
    {
        /*  $model_options = new Option();
          $options = $model_options->loadOptions();
          $this->options = $options;
          $this->view->share( 'core_options', $options );
        */
    }

    private function _setMeta()
    {

        // $this->setMetaKeywords(get_label('site/defaultMetaTitle'));
        $this->setMetaDescription(get_label('site/defaultMetaDescription'));
        $this->setMetaTitle(get_label('site/defaultMetaTitle'));

        $root_url = \Request::root();
        $full_url = \Request::Url();

        $langs = Arrays::ValuesFromField(get_active_langs(), 'alias');

        $query = str_replace($root_url, '', $full_url);

        //разбиваем на массив по разделителю
        $segments = explode('/', $query);

        //Если URL (где нажали на переключение языка) содержал корректную метку языка
        if ($segments && isset($segments[1]) && in_array($segments[1], $langs)) {
            unset($segments[1]); //удаляем метку
        }

        //формируем полный URL
        $query = implode('/', $segments);
        if ($query) {
            $item = SeoRepository::getByUri($query);

            if ($item) {
                $item = $item->translate(\App::getLocale());

                $this->setMetaKeywords($item->seo_keywords);
                $this->setMetaDescription($item->seo_description);
                $this->setMetaTitle($item->seo_title ? $item->seo_title : $item->seo_h1);
                $this->setMetaH1($item->seo_h1);
                $this->setMetaSeoText($item->text);
            }
        }

        // dump(\Route::current());
    }

    public function setMetaDescription($text = '')
    {
        if ($text) {
            $this->metaDescription = $text;
        }
        $this->_publishMeta();
    }

    private function _publishMeta()
    {
        $this->view->share('siteSeoText', $this->metaSeoText);
        $this->view->share('siteMetaTitle', $this->metaTitle);
        $this->view->share('siteMetaH1', $this->metaH1);
        $this->view->share('siteMetaDescription', $this->metaDescription);
        $this->view->share('siteMetaKeywords', $this->metaKeywords);
    }

    public function setMetaTitle($text = '')
    {
        if ($text) {
            $this->metaTitle = $text;
        }
        $this->_publishMeta();
    }

    public function setMetaKeywords($text = '')
    {
        if ($text) {
            $this->metaKeywords = $text;
        }
        $this->_publishMeta();
    }

    public function setMetaH1($text = '')
    {
        if ($text) {
            $this->metaH1 = $text;
        }
        $this->_publishMeta();
    }

    public function setMetaSeoText($text = '')
    {
        if ($text) {
            $this->metaSeoText = $text;
        }
        $this->_publishMeta();
    }

    /**
     * @return array
     */
    public function getAttributeNames()
    {
        $attrs = isset($this->attributeNames) ? $this->attributeNames : [];

        return $attrs;
    }
}
