<div class="box box-solid">
    <div class="box-body">

        @if ($attributes['show_search_input'])
            <input type="text" id="plugins4_q" value="" class="input"
                   style="margin:0em auto 1em auto; display:block; padding:4px; border-radius:4px; border:1px solid silver;"/>
        @endif
        <div id="tree_{{$attributes['token']}}" class="tree-div">
            <ul style="padding:0px; " class="tree tree-default">
                <li id="node-0" class="open"><!--close-->
                    <a title="{{$attributes['root_name']}}"
                       @if (!$attributes['root_path'])href="#" onclick="return false;" data-token="{{$attributes['token']}}" data-tokenval="0"
                       @elseif ($attributes['root_path'] == 'none')href="javascript:void(0);"
                       @else href="{{$attributes['root_path']}}"
                       @endif style="background-image:url({{asset('/backend/images/folder.gif')}}" class="tree_link">
                        {{$attributes['root_name']}}
                    </a>
                    @include($attributes['tree_recursive_path'], ['tree'=>$tree_data,'token'=>$attributes['token'],  'ul_class'=>'', 'ul_id'=>'tree', 'tree_primary'=>$attributes['primary_key'], 'tree_name'=>$attributes['display_field'], 'tree_link_path'=>$attributes['link_path'], 'grid_tree_recursive_path'=>$attributes['tree_recursive_path']])
                </li>
            </ul>
        </div>
    </div>
</div>

