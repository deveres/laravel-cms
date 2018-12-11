
<ul @if ($ul_class)class="{{$ul_class}}"@endif @if ($ul_id)id="{{$ul_id}}"@endif >
	@foreach ($tree  as $node)
		<li id="node-{{$node[$tree_primary]}}" >
            <a data-id="{{$node['id']}}"  title="{{$node[$tree_name]}}" @if (!isset($node['no_link']) || !$node['no_link'])href="#" onclick="return false;" data-token="{{$token}}" data-tokenval="{{$node[$tree_primary]}}"
			   @else href="javascript:void(0);"@endif style="background-image:url({{asset('/backend/images/folder.gif')}})" class="tree_link" >{{$node[$tree_name]}}@if (isset($node['sum']) && $node['sum'])({{$node['sum']}})@endif
			</a>

            @if (isset($node['children']) && is_array($node['children']))

				@component($grid_tree_recursive_path, ['tree'=>$node['children'], 'token'=>$token, 'ul_class'=>'', 'ul_id'=>'', 'tree_primary'=>$tree_primary, 'tree_name'=>$tree_name, 'tree_link_path'=>$tree_link_path, 'grid_tree_recursive_path'=>$grid_tree_recursive_path])
				@endcomponent
            @endif
		</li>
	@endforeach
</ul>