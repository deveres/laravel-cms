<?php
/**
 * Created by PhpStorm.
 * User: vadim
 * Date: 02.10.2018
 * Time: 12:03.
 */

namespace App\Libs;

use App\Src\Models\Images\ModImage;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Intervention\Image\Facades\Image;

class LibImages
{
    protected $_config;
    protected $_uploader_config;

    private $disk = 'public';
    private $default_image = '/img/pics/icon_add_photo.png';

    private $_uploader_tpl = 'uploader.pluploader';

    private $_item_id = 0;

    public function __construct()
    {
        $this->_uploader_config = [
            'title_upload'           => 'Загрузить изображения',
            'title_list'             => 'Загруженные изображения',
            'pluploader_id'          => 'my_uploader_images',
            'pluploader_save_action' => route('images.upload'),
            'image_alias'            => 'general',
            'item_id'                => $this->_item_id,
            'file_types_title'       => 'Изображения',
            'file_types'             => 'jpg,png,gif',
            'file_size'              => '10mb',
            'images'                 => [],
        ];
    }

    /**
     * инициализирует обработчик картинок для модуля и элемента модуля.
     *
     * @param $label -- модуль для кого грузим картинки
     * @param int    $item_id -- ID элемента для кого грузим картинки
     * @param string $alias   --  ключ массива с настройками в конфиге модуля в подмасиве  'images'
     *
     * @return $this
     */
    public function init($label = '', $item_id = 0, $alias = 'items')
    {
        $config = config('modules.'.$label)['images'];

        $res_configs = isset($config[$alias]) ? $config[$alias] : Arrays::first($config);

        $this->_config = $res_configs;
        $this->_item_id = $item_id;

        // module
        $this->_uploader_config['image_alias'] = $label;

        // module item id
        $this->_uploader_config['item_id'] = $item_id;

        // list file title
        if ($this->_config['file_types_title']) {
            $this->_uploader_config['file_types_title'] = $this->_config['file_types_title'];
        }

        // allowed file types
        if ($this->_config['file_types']) {
            $this->_uploader_config['file_types'] = $this->_config['file_types'];
        }

        //allowed file size
        if ($this->_config['file_size']) {
            $this->_uploader_config['file_size'] = $this->_config['file_size'];
        }

        // images for output
        $this->_uploader_config['images'] = $this->getForItem($item_id, $label);

        return $this;
    }

    /**
     * получаем все картинки для обьекта по модулю.
     *
     * @param int    $item_id
     * @param string $module
     *
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function getForItem($item_id = 0, $module = '')
    {
        $items = ModImage::query()->where('item_id', $item_id)->where('module', $module)->get();

        return $items;
    }

    /**
     * @param Request      $request
     *                                      загружает файл
     * @param UploadedFile $file
     * @param string       $file_input_name -  название инпута
     * @param int          $item_id
     * @param int          $custom_module
     * @param array        $custom_config   - опции для перезаписи настроек модуля
     *
     * @throws \Illuminate\Contracts\Filesystem\FileNotFoundException
     *
     * @return array
     */
    public function plUpload(
        Request $request,
        UploadedFile $file,
        $file_input_name = 'file',
        $item_id = 0,
        $custom_module = 0,
        $custom_config = []
    ) {
        $item_id = $item_id ? $item_id : $this->_item_id;
        $config = $this->_config;
        if ($custom_config) {
            $config = array_merge($this->_config, $custom_config);
        }

        $module = $this->_uploader_config['image_alias'];
        if ($custom_module) {
            $module = $custom_module;
        }

        $path = $config['path'];

        if (!$request->files->get($file_input_name) || !$request->hasFile($file_input_name)) {
            return ['success' => false, 'item' => []];
        }

        //$file = UploadedFile::createFromBase($request[$file_input_name]);

        if ($config['rule']) {
            $rules = [$file_input_name => $config['rule']];

            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) {
                logger($validator->errors()->messages());

                return ['success' => false, 'item' => $validator->errors()->messages()];
            }
        }

        //$filename = str_random(2) . '-' . $file->getClientOriginalName() . '.' . $file->getClientOriginalExtension();
        $filename = str_random(2).'-'.$file->getClientOriginalName();

        $subDir = $path.$item_id.'/';

        // $path = storage_path('app/reports') . $subDir;
        // \File::makeDirectory($path, $mode = 0777, true, true);

        $file->storeAs($subDir, $filename, $this->getDisk());

        $image = new ModImage();
        $image->item_id = $item_id ? $item_id : 0;
        $image->module = $module;
        $image->main = 0;
        $image->path = $subDir;
        $image->filename = $filename;
        $image->alt = $filename;
        $image->disk = $this->getDisk();
        $image->save();

        // resize if config enabled
        if ($config['autoresize'] == true) {
            $this->resize($image->filename);
        }

        //logger($image->toArray());
        return ['success' => true, 'item' => $image];
    }

    public function getDisk()
    {
        return $this->disk;
    }

    /**
     * @param $file
     * @param string $subdir
     * @param array  $custom_config
     *
     * @throws \Illuminate\Contracts\Filesystem\FileNotFoundException
     */
    public function resize($file, $subdir = '', $custom_config = [])
    {
        $config = $this->_config;

        if ($custom_config) {
            $config = array_merge($this->_config, $config);
        }

        $subdir = $subdir ? $subdir : $this->_item_id.'/';

        if (!\Storage::disk($this->getDisk())->exists($config['path'].'/'.$subdir.$file)) {
            return;
        }

        $source = str_replace('//', '/', $config['path'].'/'.$subdir.$file);

        if ($config['size']) {
            foreach ($config['size'] as $size => $size_data) {
                $img = Image::make(Storage::disk($this->getDisk())->get($source));
                $img->resize($size_data['0'], $size_data['1']);
                //$img->insert('public/watermark.png');
                $directory = $config['path'].$subdir.$size.'/';

                Storage::disk($this->getDisk())->makeDirectory($directory);
                $root = config('filesystems.disks.'.$this->getDisk().'.root');

                $img->save($root.$directory.$file);
            }
        }
    }

    /**
     * дает ссылку на картинку.
     *
     * @param $params
     *
     * @return string
     */
    public function photo($params)
    {
        $img = setif($params, 'img');

        $size = setif($params, 'size', '200');
        $module = setif($params, 'module', '');
        $item_id = setif($params, 'item_id', '0');

        return route('download.image',
            ['module' => $module, 'item_id' => $item_id, 'size' => $size, 'filename' => $img]);
    }

    /**
     * получаем картинку по ссылке.
     *
     * @param $module
     * @param $item_id
     * @param string $size
     * @param $filename
     *
     * @return \Illuminate\Contracts\Routing\ResponseFactory|string|\Symfony\Component\HttpFoundation\Response
     */
    public function downloadPhoto($module, $item_id, $size, $filename)
    {
        try {
            $size = (!empty($size)) ? $size.'/' : '';
            if (empty($filename)) {
                $stored = \Illuminate\Support\Facades\File::get(public_path().$this->default_image);
                $mime = Storage::disk('web')->mimeType($this->default_image);
                $filename = '';

                return response($stored, 200, [
                        'Content-Type'        => $mime,
                        'Content-Disposition' => 'attachment; filename="'.$filename.'"',
                    ]
                );
            }

            $image = ModImage::query()->where('module', $module)->where('item_id', $item_id)->where('filename',
                $filename)->first();

            if ($image && Storage::disk($this->getDisk())->exists($image->path.$size.$filename)) {
                $stored = Storage::disk($this->getDisk())->get($image->path.$size.$filename);
                $mime = Storage::disk($this->getDisk())->mimeType($image->path.$size.$filename);
            } else {
                $stored = \Illuminate\Support\Facades\File::get(public_path().$this->default_image);
                $mime = Storage::disk('web')->mimeType($this->default_image);
                $filename = '';
            }

            return response($stored, 200, [
                    'Content-Type'        => $mime,
                    'Content-Disposition' => 'attachment; filename="'.$filename.'"',
                ]
            );
        } catch (\Illuminate\Contracts\Filesystem\FileNotFoundException $exception) {
            return $exception->getMessage();
        }
    }

    /**
     * удаляет картинку.
     *
     * @param $id
     *
     * @return bool
     */
    public function deleteImage($id, $alias = 'images')
    {
        if (!$id) {
            return false;
        }

        $images = ModImage::query()->where('id', $id)->get();
        if (!$images) {
            return true;
        }

        foreach ($images as $one) {
            $conf = config('modules.'.$one->module)[$alias]['items'];
            if ($conf['size']) {
                foreach ($conf['size'] as $size_key => $one_size) {
                    Storage::disk($this->getDisk())->delete($one->path.$size_key.'/'.$one->filename);
                }
            }
            Storage::disk($this->getDisk())->delete($one->path.$one->filename);
        }

        ModImage::query()->where('id', $id)->delete();

        return true;
    }

    /**
     * устанавливаем главную картинку для элемента.
     *
     * @param int    $id      - ID картинки
     * @param string $module  - модуль
     * @param int    $item_id - ID объекта
     *
     * @return bool
     */
    public function setMain($id, $module, $item_id)
    {
        if (!$id || !$module || !$item_id) {
            return false;
        }

        ModImage::query()->where('module', $module)->where('item_id', $item_id)->update(['main' => 0]);

        $image = ModImage::find($id);
        $image->main = 1;
        $image->save();

        return true;
    }

    /**
     * удаляет все картинки обьекта модуля.
     *
     * @param $module
     * @param $item_id
     *
     * @return bool
     */
    public function deleteItemImages($module, $item_id)
    {
        if (!$item_id || !$module) {
            return false;
        }

        $images = ModImage::query()->where('module', $module)->where('item_id', $item_id)->get();
        if ($images) {
            foreach ($images as $one) {
                try {
                    Storage::disk($this->getDisk())->deleteDirectory($one->path);
                } catch (\Exception $e) {
                }
            }
        }

        ModImage::query()->where('module', $module)->where('item_id', $item_id)->delete();

        return true;
    }

    /**
     * @param array $pluploader_params
     *
     * @throws \Throwable
     *
     * @return string
     */
    public function getUploader($pluploader_params = [])
    {
        if ($pluploader_params) {
            $this->_uploader_config = array_merge($this->_uploader_config, $pluploader_params);
        }

        return view($this->_uploader_tpl, $this->_uploader_config)->render();
    }
}
