<style>

    .icon-main {
        position: absolute;
        top: 15px;
        left: 28px;
        z-index: 100;
        display: none;
        font-size: 17px;
    }

</style>


<h4 class="form-header">{{$title_upload}}</h4>
{!! \Jenky\LaravelPlupload\Facades\Plupload::make($pluploader_id, $pluploader_save_action)->render() !!}

<hr>
<h4 class="form-header">{{$title_list}}
    <a href="#" data-item_id="{{$item_id}}" data-module="{{$image_alias}}"
       class="btn btn-danger btn-xs mod-img-remove-all pull-right">Удалить все картинки</a></h4>
<div class="file-preview ">

    <div class="row" id="uploaded_files_lists_result{{$pluploader_id}}">
        @if (count($images)>0)
            @foreach($images as $one_image)
                <div id="mod-img-{{$one_image->id}}" class="col-sm-3 col-md-3 mod-img-item" style="max-width: 200px;">

                    <i class="fa fa-star  text-success icon-main"
                       style="@if ($one_image->main==1)display:block; @else display:none; @endif" title="Главная"></i>

                    <div class="thumbnail krajee-default file-preview-frame">
                        <img src="{{app('images.photo')->photo(['module'=>$one_image->module,'size'=>100, 'item_id'=>$one_image->item_id, 'img'=>$one_image->filename?$one_image->filename:0])}}"
                             alt="{{$one_image->alt}}">
                        <div class="caption">
                            <span class="text-muted">{{$one_image->filename}}</span>
                            <p>
                                <a href="#" data-id="{{$one_image->id}}" data-item_id="{{$one_image->item_id}}"
                                   data-module="{{$one_image->module}}" class="btn btn-success btn-xs mod-img-main"
                                   role="button">Главная</a>
                                <a href="#" data-id="{{$one_image->id}}" class="btn btn-danger btn-xs mod-img-delete"
                                   role="button">Удалить</a></p>
                        </div>
                    </div>
                </div>
            @endforeach
        @endif
    </div>

</div>


<script>

    $(function () {

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
        });

        createUploader('{{$pluploader_id}}', {!! json_encode( [
            'url'=> $pluploader_save_action,
            'runtimes' => 'html5,flash,silverlight,html4',
            'chunk_size'=> '1mb',
            'views'=>[
                'list'=> true,
                'thumbs'=> true,
                'active'=> 'thumbs'
            ],
            'dragdrop'=>true,
            'multipart'=> true,
            'file_data_name'=>'file',
            'multipart_params' => [
                'alias'=> $image_alias,
                'item_id' => $item_id,
                '_token'=> csrf_token()
            ],

            'filters'=>[
                   'max_file_size' => ($file_size?$file_size:'10mb'),
                   'mime_types'=> [
                                    ['title'=> ($file_types_title?$file_types_title:'Image files'), 'extensions' => ($file_types?$file_types:'jpg,gif,png')]
                                  ]

                ],
        'flash_swf_url' => asset('vendor/plupload-2.3.6/js/Moxie.swf'),


        'silverlight_xap_url'=> asset('vendor/plupload-2.3.6/js/Moxie.xap')
        ]) !!});

        initDeleteAction('{{route(config('admin.route.prefix').'.images.delete')}}');
        initDeleteAllAction('{{route(config('admin.route.prefix').'.images.delete.all')}}', '{{$pluploader_id}}');
        initMainImageAction('{{route(config('admin.route.prefix').'.images.main')}}', '{{$pluploader_id}}');


    });
</script>
