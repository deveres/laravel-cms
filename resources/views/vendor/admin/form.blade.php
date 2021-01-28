<div class="row">
    <div class="col-md-12">
        <div class="box box-info">
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
        <div class="box-body">

            @if(!$tabObj->isEmpty())
                @include('admin::form.tab', compact('tabObj'))
            @else
                <div class="fields-group">

                    @if($form->hasRows())
                        @foreach($form->getRows() as $row)
                            {!! $row->render() !!}
                        @endforeach
                    @else
                        @foreach($layout->columns() as $column)
                            <div class="col-md-{{ $column->width() }}">
                                @foreach($column->fields() as $field)
                                    {!! $field->render() !!}
                                @endforeach
                            </div>
                        @endforeach
                    @endif
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
    </div>
    <!-- /.box-footer -->
    {!! $form->close() !!}

</div>

