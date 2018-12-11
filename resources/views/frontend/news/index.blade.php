@extends('layouts.app')
@section('content')




<section class="main_news">
    <header>
        <div class="wrapper">
            <div class="news-up">
                <h1>{{($siteMetaH1)?$siteMetaH1:_t('news/title')}}</h1>

            </div>
        </div>
    </header>
    <div class="container">
        <div class="wrapper flex c">
            @foreach ($news as $one_news)

                <div class="item pop_up_animate">
                    <a href="{{route('frontend.news.view', ['modNews'=>$one_news])}}"><img src="{{ app('images.photo')->photo(['module'=>'news','size'=>401, 'item_id'=>$one_news->id, 'img'=>($one_news->avatar && $one_news->avatar->filename)?$one_news->avatar->filename:0])  }}" title="{{$one_news->filename}}" alt="{{$one_news->name}}">
                        <div class="content">
                            <h3>{{$one_news->name}}</h3>
                            <p class="date">{{$one_news->updated}}</p>
                            <p class="a">{{_t('news/read_more')}} »</p>
                        </div>
                    </a>
                    <div class="share">
                        <a href="#" class="tw social_share" data-type="tw"></a>
                        <a href="#" class="fb social_share" data-type="fb"></a>
                        <a href="#" class="vk social_share" data-type="vk"></a>
                    </div>
                </div>
            @endforeach

        </div>
        <div class="wrapper flex c">
            {{$news->render() }}
        </div>
    </div>

</section>
<hr>
@endsection