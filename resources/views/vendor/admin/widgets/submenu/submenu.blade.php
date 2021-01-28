
<div>
    @if (isset($backend_submenu) && $backend_submenu)
        @foreach ($backend_submenu as $one_submenu)
            @if (isset($one_submenu["link"]))
                <a class="grid_control @isset($one_submenu["selected_item"]) selected_control @endisset" href="{{$one_submenu["link"]}}" >{{$one_submenu["title"]}}</a>
            @endif
        @endforeach
    @endif
</div>
