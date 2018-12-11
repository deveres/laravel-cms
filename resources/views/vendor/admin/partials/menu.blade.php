@if(Admin::user()->visible($item['roles']))
    @if(!isset($item['children']))

            @if ($item['icon']=='fa-anchor')
                <li class="header">{{$item['title']}}</li>
            @else
            <li>
                        @if(url()->isValidUrl($item['uri']))
                            <a href="{{ $item['uri'] }}" target="_blank">
                        @else
                             <a href="{{ admin_base_path($item['uri']) }}">
                        @endif
                            <i class="fa {{$item['icon']}}"  @if(!empty($item['icon_color'])) style="color:{{$item['icon_color']}}" @endif></i>
                            <span>{{$item['title']}}</span>
                        </a>
            </li>
                @endif

    @else
        <li class="treeview">
            <a href="#">
                <i class="fa {{$item['icon']}}"  @if(!empty($item['icon_color'])) style="color:{{$item['icon_color']}}" @endif></i>
                <span>{{$item['title']}}</span>
                <i class="fa fa-angle-left pull-right"></i>
            </a>
            <ul class="treeview-menu">
                @foreach($item['children'] as $item)
                    @include('admin::partials.menu', $item)
                @endforeach
            </ul>
        </li>
    @endif
@endif