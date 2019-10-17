@extends('admin::index', ['header' => $header])

@section('content')
    <section class="content-header">

        @widget('Admin\Submenu', [])


        {!! app('backend.breadcrumbs')->render() !!}

        <div class="page_header">
            <h3>
                {{ $header?$header:trans('admin.title') }}
                <small>{{ $description?$description:trans('admin.description') }}</small>
            </h3>
        </div>

    </section>

    <section class="content">

        @include('admin::partials.alerts')
        @include('admin::partials.exception')
        @include('admin::partials.toastr')

        {!! $content !!}

    </section>
@endsection