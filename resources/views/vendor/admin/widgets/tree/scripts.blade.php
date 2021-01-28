{{--<script>--}}
    (function () {


$(document).on("click",'.tree_link',function(e) {

    var attr = $(this).attr('data-token');
    if (typeof attr !== typeof undefined && attr !== false) {
        e.preventDefault();
        $url = '{!! Request::fullUrlWithQuery([  $attributes['token']  => '_tree_']) !!}';
        var url = $url.replace('_tree_', $(this).attr('data-tokenval'));
        $.pjax({container:'#pjax-container', url: url });
    }
});
        $("#tree_{!!  $attributes['token'] !!}").jstree({
            'core': {

                'check_callback': function (o, n, p, i, m) {

                    if (m && m.dnd) {
                        return false;
                    }
                    if (o === "move_node" || o === "copy_node") {
                        return false;
                    }
                    return true;
                },
                'themes': {
                    'responsive': false,
                    'variant': 'small',
                    'stripes': true
                }

            }
            , opened: false
            , 'selected': ['node-{!!  $attributes['selected'] !!}']
            , 'types': {
                'default': {'icon': 'folder'},
                'file': {'valid_children': [], 'icon': 'file'}
            }
            , 'plugins': ['{!!  $attributes['plugins'] !!}']
            , 'contextmenu': {
                'items': function (node) {
                    var tmp = $.jstree.defaults.contextmenu.items();
                    delete tmp.create.action;
                    delete tmp.ccp;
                    delete tmp.remove;
                    delete tmp.rename;


                    tmp.create = {
                        "separator_before": false,
                        "separator_after": false,
                        "_disabled": false, //(this.check("create_node", data.reference, {}, "last")),
                        "label": "Редактировать",
                        "action": function (data) {


//window.location = data.reference.find('a').attr('href');
                            if (data.reference.parent().attr("id") != 'node-0') {
                                location.href = '{!!  $attributes['edit_url'] !!}' + data.reference.data('id');
                            }
                        }
                    };
                    return tmp;
                }
            }

        }).on("click.jstree", ".jstree-anchor", $.proxy(function (e) {
                /*e.preventDefault();*/
                /* if(e.currentTarget !== document.activeElement) { $(e.currentTarget).focus(); }
                this.activate_node(e.currentTarget, e);
                */
                if ($(e.currentTarget).attr("href") != undefined) {
                    location.href = $(e.currentTarget).attr("href");
                }
            }, this
            )
        ).on("ready.jstree", function (event, data) {

            initNode('node-{!! $attributes['selected'] !!}');
        });


        function initNode(nodeID) {
// expandNode(nodeID);
            selectNode(nodeID);
        }

        function selectNode(nodeID) {
            $('#tree_{!! $attributes['token'] !!}').jstree('select_node', nodeID);
            $('#tree_{!! $attributes['token'] !!}').jstree('open_node', nodeID);
        }

        function expandNode(nodeID) {
// Expand all nodes up to the root (the id of the root returns as '#')
            while (nodeID != '#') {
// Open this node
                $("#tree_{!! $attributes['token'] !!}").jstree("open_node", nodeID)
// Get the jstree object for this node
                var thisNode = $("#tree_{!! $attributes['token'] !!}").jstree("get_node", nodeID);
// Get the id of the parent of this node
                nodeID = $("#tree_{!! $attributes['token'] !!}").jstree("get_parent", thisNode);
            }
        }

                @if ( $attributes['show_search_input'])

        var to = false;
        $('#plugins4_q').keyup(function () {
            if (to) {
                clearTimeout(to);
            }
            to = setTimeout(function () {
                var v = $('#plugins4_q').val();
                $('#tree_{!! $attributes['token'] !!}').jstree(true).search(v);
            }, 250);
        });

        @endif
    }());



