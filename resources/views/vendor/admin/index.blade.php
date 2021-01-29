<!DOCTYPE html>
<html lang="{{ config('app.locale') }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ Admin::title() }} @if($header) | {{ $header }}@endif</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    @if(!is_null($favicon = Admin::favicon()))
    <link rel="shortcut icon" href="{{$favicon}}">
    @endif

    <link rel="stylesheet" href="{{ admin_asset('/backend/js/jquery-ui/themes/smoothness/jquery-ui.min.css')}}" type="text/css"/>
    <link rel="stylesheet" href="{{ admin_asset('/backend/js/jquery-ui/themes/smoothness/theme.css')}}" type="text/css"/>

    <link rel="stylesheet" href="{{ admin_asset('/backend/js/plupload-2.3.6/js/jquery.ui.plupload/css/jquery.ui.plupload.css')}}"
          type="text/css"/>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="{{ admin_asset("/vendor/laravel-admin/font-awesome/css/font-awesome.min.css") }}">

    {!! Admin::css() !!}

    <link rel="stylesheet" href="{{ admin_asset("/backend/js/vakata/jstree/themes/admin/style.css") }}">
    <link rel="stylesheet" href="{{ admin_asset("/backend/css/admin-custom.css") }}">


    <script src="{{ Admin::jQuery() }}"></script>

    <script src="{{ admin_asset('/backend/js/jquery-migrate-1.4.1.js')}}"></script>

    {!! Admin::headerJs() !!}
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body class="hold-transition {{config('admin.skin')}} {{join(' ', config('admin.layout'))}}">

@if($alert = config('admin.top_alert'))
    <div style="text-align: center;padding: 5px;font-size: 12px;background-color: #ffffd5;color: #ff0000;">
        {!! $alert !!}
    </div>
@endif

<div class="wrapper">

    @include('admin::partials.header')

    @include('admin::partials.sidebar')

    <div class="content-wrapper" id="pjax-container">
        {!! Admin::style() !!}
        <div id="app">
        @yield('content')
        </div>
        {!! Admin::script() !!}
        {!! Admin::html() !!}
    </div>

    @include('admin::partials.footer')

</div>

<button id="totop" title="Go to top" style="display: none;"><i class="fa fa-chevron-up"></i></button>

<script>
    function LA() {}
    LA.token = "{{ csrf_token() }}";
    LA.user = @json($_user_);
</script>

<!-- REQUIRED JS SCRIPTS -->
{!! Admin::js() !!}

<script type="text/javascript" src="{{ asset('backend/js/jquery-ui/jquery-ui.min.js')}}"></script>
<script src="{{ admin_asset('/backend/js/vakata/jstree/jstree.min.js')}}"></script>

<script type="text/javascript" src="{{ admin_asset('/backend/js/plupload-2.3.6/js/plupload.full.min.js')}}"></script>
<script type="text/javascript"
        src="{{ admin_asset('/backend/js/jquery.ui.plupload.js')}}"></script>
<script type="text/javascript" src="{{ admin_asset('/backend/js/plupload-2.3.6/js/i18n/'.config('app.locale').'.js')}}"></script>
<script src="{{ admin_asset('/backend/js/uploadQueue.js')}}"></script>

</body>
</html>
