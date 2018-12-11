<!DOCTYPE html>
<html lang="{{ config('app.locale') }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>{{ Admin::title() }}@if (isset($htmlheader_title) && $htmlheader_title){{$htmlheader_title}}@endif</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">


    {{--
    <link href="{{ asset('/backend/js/jquery-ui-1.12.1.custom/jquery-ui.css')}}" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="{{ asset('backend/js/jquery-ui-1.12.1.custom/jquery-ui-themes-1.12.1/themes/smoothness/jquery-ui.min.css')}}" media="screen" />
    --}}
    <link rel="stylesheet"
          href="{{ asset('backend/js/jquery-ui-1.10.4.custom/css/smoothness/jquery-ui-1.10.4.custom.min.css')}}"
          type="text/css"/>
    <link rel="stylesheet" href="{{ asset('vendor/plupload-2.3.6/js/jquery.ui.plupload/css/jquery.ui.plupload.css')}}"
          type="text/css"/>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="{{ admin_asset("/vendor/laravel-admin/font-awesome/css/font-awesome.min.css") }}">


    {!! Admin::css() !!}

    <link rel="stylesheet" href="{{ admin_asset("/vendor/vakata/jstree/themes/admin/style.css") }}">
    <link rel="stylesheet" href="{{ asset("backend/css/admin-custom.css") }}">

    <!-- REQUIRED JS SCRIPTS -->
    <script src="{{ Admin::jQuery() }}"></script>


    <script src="{{ asset('/js/jquery-migrate-1.4.1.js')}}"></script>

    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body class="hold-transition {{config('admin.skin')}} {{join(' ', config('admin.layout'))}}">
<div class="wrapper">

    @include('admin::partials.header')

    @include('admin::partials.sidebar')

    <div class="content-wrapper" id="pjax-container">
        @yield('content')
        {!! Admin::script() !!}
    </div>

    @include('admin::partials.footer')

</div>

<!-- ./wrapper -->

<script>
    function LA() {
    }

    LA.token = "{{ csrf_token() }}";
</script>

<!-- REQUIRED JS SCRIPTS 1 -->
{!! Admin::js() !!}

{{--
<script src="{{ asset('/backend/js/jquery-ui-1.12.1.custom/jquery-ui.js')}}"></script>
--}}
<script type="text/javascript"
        src="{{ asset('backend/js/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.min.js')}}"></script>
<script src="{{ asset('/vendor/vakata/jstree/jstree.min.js')}}"></script>

<script type="text/javascript" src="{{ asset('vendor/plupload-2.3.6/js/plupload.full.min.js')}}"></script>
<script type="text/javascript"
        src="{{ asset('vendor/plupload-2.3.6/js/jquery.ui.plupload/jquery.ui.plupload.js')}}"></script>
<script type="text/javascript" src="{{ asset('vendor/plupload-2.3.6/js/i18n/'.config('app.locale').'.js')}}"></script>
<script src="{{ asset('/vendor/plupload/assets/js/uploadQueue.js')}}"></script>

</body>
</html>
