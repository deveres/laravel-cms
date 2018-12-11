<div class="col-sm-6" style="padding: 10px;">


    <a href="{{$config['url']}}"
       class="grid_control @if($selected===0 || $selected==='') selected_control @endif">Все({{$totals_all}})</a>
    @foreach($config['param_values'] as $key=>$one_value)
        <a href="{{$config['url']}}?{{$config['param_name']}}={{$key}}"
           class="grid_control @if((string)$selected===(string)$key) selected_control @endif">{{$one_value}}
            ({{$totals[$key]}})</a>
    @endforeach
</div>