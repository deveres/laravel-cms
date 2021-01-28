@extends('layouts.app')
@section('content')
    <section class="internal_header">
        <div class="wrapper"><a href="{{route('frontend.news')}}" class="back">{{_t('custom/labels/back_to_list')}}</a>
            <p class="heading">{{$news->name}}</p>

        </div>
    </section>

    <div class="item-up2" style="background: url({{ app('images.photo')->photo(['module'=>'news','size'=>1280, 'item_id'=>$news->id, 'img'=>$news->filename?$news->filename:0])  }}) no-repeat; background-size: cover;">
        <div class="center-flex">
            <div>
                <h1>{{$news->name}}</h1>
                <p>{{$news->updated_at}}</p>
            </div>
        </div>
        <a href="#news_content" id="news_content"><img src="{{asset('img/pics/for-down.png')}}"></a>
    </div>

    <div class="wrapper2">
        <div class="text2">
            {!! $news->text !!}
        </div>
        <h6>{{_t('custom/labels/share_this_article')}}</h6>
        <ul class="social-link">
            <li>
                <a href="#" class="social-img1 social_share" data-type="fb"></a>
            </li>
            <li>
                <a href="#" class="social-img2 social_share" data-type="tw"></a>
            </li>
            <li>
                <a href="#" class="social-img3 social_share" data-type="tw"></a>
            </li>
            <li>
                <a href="#" class="social-img4 social_share" data-type="go"></a>
            </li>
        </ul>

    </div>



    @if($news->comments_enabled==1)
        <div class="wrapper2">
            {{-- Widget::ModuleItemComments(["comment_module"=>'news', 'comment_module_item_id'=>$news->id]) --}}
        </div>
    @endif

@endsection
