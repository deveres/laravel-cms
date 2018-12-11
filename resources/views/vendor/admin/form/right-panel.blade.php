<div class="col-md-3">
    <div class="box-body pl-0 pr-0">

        @foreach($formRightObj->getPanels() as $panel)


            <div id="right-panel-{{ $panel['id'] }}"
                 class="box box-{{$panel['theme']}} {{ !$panel['active'] ? 'collapsed-box' : '' }}">
                <div class="box-header with-border">
                    <h3 class="box-title">  {{ $panel['title'] }}</h3>

                    <div class="box-tools pull-right">
                        <button type="button" class="btn btn-box-tool" data-widget="collapse"><i
                                    class="fa fa-minus"></i></button>
                        <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i>
                        </button>
                    </div>
                </div>
                <!-- /.box-header -->


                <div class="box-body">
                    <div class="row">
                        <div class="col-md-12">

                            @foreach($panel['fields'] as $field)
                                {!! $field->render() !!}
                            @endforeach

                        </div>

                        <!-- /.col -->
                    </div>
                    <!-- /.row -->
                </div>
                <!-- /.box-body -->
                <div class="box-footer">

                </div>


            </div>


        @endforeach


    </div>
</div>