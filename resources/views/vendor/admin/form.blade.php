<div class="row">
    <div class="col-md-12">
        <div class="box box-info box-no-margin">
            <div class="box-header with-border">
                <h3 class="box-title">{{ $form->title() }}</h3>

                <div class="box-tools">
                    {!! $form->renderTools() !!}
                </div>
            </div>
        </div>
    </div>
    <!-- /.box-header -->
    <!-- form start -->
    {!! $form->open(['class' => "form-horizontal"]) !!}
    <div class="@if (isset($formRightObj) && !$formRightObj->isEmpty()) col-md-9 @else col-md-12 @endif">
        <div class="box-body pl-0 pr-0">

            @if(!$tabObj->isEmpty())
                @include('admin::form.tab', compact('tabObj'))
            @else
                <div class="nav-tabs-custom mb-0">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#tab-form-1" data-toggle="tab">
                                Общее <i class="fa fa-exclamation-circle text-red hide"></i>
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content fields-group" >
                    <div class="tab-pane active" id="tab-form-1">
                        <div class="fields-group ">

                            @if($form->hasRows())
                                @foreach($form->getRows() as $row)
                                    {!! $row->render() !!}
                                @endforeach
                            @else
                                @foreach($form->fields() as $field)
                                    {!! $field->render() !!}
                                @endforeach
                            @endif


                        </div>
                    </div>
                    </div>
                </div>
            @endif

        </div>
    </div>
    @if (isset($formRightObj) && !$formRightObj->isEmpty())
        @include('admin::form.right-panel', compact('formRightObj'))

    @endif
<!-- /.box-body -->
    <div class="col-md-12">
    {!! $form->renderFooter() !!}

    @foreach($form->getHiddenFields() as $field)
        {!! $field->render() !!}
    @endforeach

    <!-- /.box-footer -->
    </div>
    {!! $form->close() !!}
</div>
