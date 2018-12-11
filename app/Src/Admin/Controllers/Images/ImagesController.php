<?php

namespace App\Src\Admin\Controllers\Images;

use App\Http\Controllers\Controller;
use Encore\Admin\Controllers\HasResourceActions;
use Encore\Admin\Layout\Content;
use Jenky\LaravelPlupload\Facades\Plupload;
use Symfony\Component\HttpFoundation\Request;

class ImagesController extends Controller
{
    use HasResourceActions;

    public $_resource = 'images';

    public function index(Content $content)
    {
    }

    public function show(Content $content)
    {
    }

    public function uploadImage(Request $request)
    {
        $ret = Plupload::file('file', function ($file) use ($request) {
            $input = $request->all();
            $id = setif($input, 'item_id');
            $alias = setif($input, 'alias');

            $images = app('images.photo')->init($alias, $id);
            $photo = $images->plUpload($request, $file, 'file');

            if ($photo['success'] != true) {
                return [
                    'success' => false,
                    'message' => $photo['item'],
                ];
            }

            // This will be included in JSON response result
            return [
                'success'  => true,
                'message'  => 'Upload successful.',
                'id'       => $photo['item']->id,
                'name'     => $photo['item']->filename,
                'data'     => $photo['item'],
                'urlImage' => app('images.photo')->photo([
                    'module'  => $alias,
                    'size'    => 100,
                    'item_id' => $photo['item']->item_id,
                    'img'     => $photo['item']->filename ? $photo['item']->filename : 0,
                ]),
                // 'url' => $photo->getImageUrl($filename, 'medium'),
                // 'deleteUrl' => route('photos.destroy', $photo)
                // ...
            ];
        });

        return $ret;
    }

    public function deleteImage(Request $request)
    {
        $id = $request->get('id', 0);

        $ret = app('images.photo')->deleteImage($id);

        return ['success' => $ret];
    }

    public function deleteAllImages(Request $request)
    {
        $item_id = $request->get('item_id', 0);
        $module = $request->get('module', '');

        $ret = app('images.photo')->deleteItemImages($module, $item_id);

        return ['success' => $ret];
    }

    public function mainImage(Request $request)
    {
        $id = $request->get('id', 0);
        $item_id = $request->get('item_id', 0);
        $module = $request->get('module', '');

        $ret = app('images.photo')->setMain($id, $module, $item_id);

        return ['success' => $ret];
    }
}
