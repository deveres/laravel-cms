<?php

namespace App\Src\Admin\Widgets;

use Closure;
use Encore\Admin\Facades\Admin;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Database\Eloquent\Model as EloquentModel;
use InvalidArgumentException;

class FilterTree implements Renderable
{
    /**
     * Parameters.
     *
     * @var array
     */
    protected $attributes = [];

    /**
     * Data for tree.
     *
     * @var array
     */
    protected $data = [];

    /**
     * Eloquent model of the form.
     *
     * @var EloquentModel
     */
    protected $model;

    /**
     * Tree constructor.
     *
     * @param $model
     * @param Closure $callback
     */
    public function __construct($model, Closure $callback)
    {
        $this->model = $this->getModel($model);

        $this->initAttributes();
        $this->initData();

        $callback($this);
    }

    /**
     * @return string|void
     */
    public function __toString()
    {
        return $this->render();
    }

    /**
     * @param $model
     *
     * @return mixed
     */
    public function getModel($model)
    {
        if ($model instanceof EloquentModel) {
            return $model;
        }

        if (is_string($model) && class_exists($model)) {
            return $this->getModel(new $model());
        }

        throw new InvalidArgumentException("${model} is not a valid model");
    }

    /**
     * Set root name.
     *
     * @param string $name
     *
     * @return FilterTree
     */
    public function rootName($name = 'Root')
    {
        return $this->attribute('root_name', $name);
    }

    /**
     * Enable/disable link of root element.
     *
     * @param bool $state
     *
     * @return FilterTree
     */
    public function rootActiveLink($state = false)
    {
        return $this->attribute('root_path', $state);
    }

    /**
     * Set theme.
     *
     * @param string $theme
     *
     * @return FilterTree
     */
    public function theme($theme = 'default')
    {
        return $this->attribute('theme', $theme);
    }

    /**
     * Set url prefix.
     *
     * @param string $prefix
     *
     * @return FilterTree
     */
    public function urlPrefix($prefix = null)
    {
        return $this->attribute('link_path', $prefix);
    }

    /**
     * Set selected item Id.
     *
     * @param int $id
     *
     * @return FilterTree
     */
    public function selected($id = 0)
    {
        return $this->attribute('selected', $id);
    }

    /**
     * Set tree plugins.
     *
     * @param array $plugins - Ex. $plugins=['types', ''wholerow', 'checkbox']
     *
     * @return FilterTree
     */
    public function plugins($plugins = ['types'])
    {
        return $this->attribute('plugins', $plugins);
    }

    /**
     * Show hide search field.
     *
     * @param bool $state
     *
     * @return FilterTree
     */
    public function search($state = false)
    {
        return $this->attribute('show_search_input', $state);
    }

    /**
     * Set edit url.
     *
     * @param string $url
     *
     * @return FilterTree
     */
    public function editUrl($url = null)
    {
        return $this->attribute('edit_url', $url);
    }

    /**
     * Set unique id of tree.
     *
     * @param int $id
     *
     * @return FilterTree
     */
    public function token($id)
    {
        return $this->attribute('token', $id);
    }

    /**
     * Format form attributes form array to html.
     *
     * @param array $attributes
     *
     * @return array
     */
    public function formatAttribute($attributes = [])
    {
        $this->attributes['plugins'] = implode("','", $this->attributes['plugins']);
        $this->attributes['token'] = $this->attributes['token'] ? $this->attributes['token'] : md5(time());
        $this->attributes['selected'] = $this->getSelected();
        $this->attributes['add_url'] = $this->getAddUrl();
        // $this->attributes['edit_url'] = $this->getAddUrl();

        $attributes = $attributes ?: $this->attributes;

        return $attributes;
    }

    /**
     * Add form attributes.
     *
     * @param array|string $attr
     * @param string $value
     *
     * @return $this
     */
    public function attribute($attr, $value = '')
    {
        if (is_array($attr)) {
            foreach ($attr as $key => $value) {
                $this->attribute($key, $value);
            }
        } else {
            $this->attributes[$attr] = $value;
        }

        return $this;
    }

    /**
     * return content.
     *
     * @return string|void
     */
    public function render()
    {
        $params = $this->getVariables();
        //Admin::js('/vendor/vakata/jstree/jstree.min.js');
       // Admin::css('/vendor/vakata/jstree/themes/' . $this->getTheme() . '/style.css');
        Admin::script( view('admin::widgets.tree.scripts', $params)->render());


        return view('admin::widgets.tree.main', $params)->render();
    }

    /**
     * set display field.
     *
     * @param string $field
     *
     * @return FilterTree
     */
    public function displayField($field)
    {
        return $this->attribute('display_field', $field);
    }

    /**
     * Get theme.
     *
     * @return mixed|string
     */
    protected function getTheme()
    {
        return $this->attributes['theme'] ?? 'admin';
    }

    /**
     * Initialize default attributes.
     */
    protected function initAttributes()
    {
        $this->attributes = [
            'display_field' => 'name',
            'primary_key' => $this->model->getKeyName(),
            'root_name' => 'Root',              //Name of root element
            'root_path' => false,               //enable/disable link of root element
            'theme' => 'admin',                 //Theme name
            'link_path' => null,                //Url prefix
            'selected' => 0,                    //Selected element
            'plugins' => ['types'],             // Tree plugins ['types','search','contextmenu']
            'show_search_input' => false,       //show hide search input box
            'add_url' => [],                  //additional  url
            'edit_url' => '',                 //edit url prefix
            'token' => md5(time()),              // unique name for request parameter
            'tree_recursive_path' => 'admin::widgets.tree.level',
        ];
    }

    /**
     * Метод построения строки дополнительных параметров в URL.
     *
     * @return string
     */
    protected function getAddUrl()
    {
        $str = '';
        $params = array_merge(request()->all(), $this->attributes['add_url']);
        foreach ($params as $key => $value) {
            if ('filter' === $key || is_array($value) || $key === $this->attributes['token']) {
                continue;
            }
            $str .= '&' . $key . '=' . $value;
        }

        return $str;
    }

    /**
     * Get variables for render form.
     *
     * @return array
     */
    protected function getVariables()
    {
        return [
            'tree_data' => $this->data,
            'attributes' => $this->formatAttribute(),
        ];
    }

    /**
     * Get id of selected record.
     *
     * @return mixed
     */
    protected function getSelected()
    {
        if (!isset($this->attributes['selected'])) {
            $first = array_pluck(array_first($this->data), $this->model->getKeyName());

            $this->selected(array_first($first));
        }

        return $this->attributes['selected'];
    }

    /**
     * Det data.
     */
    protected function initData()
    {
        $this->data = $this->model->toTree();
    }
}
