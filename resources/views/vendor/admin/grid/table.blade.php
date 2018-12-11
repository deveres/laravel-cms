<div class="box box-info">
    @if(isset($title))
        <div class="box-header with-border">
            <h3 class="box-title"> {{-- $title --}}</h3>
        </div>
    @endif


    <div class="box-header with-border">
        <div class="pull-right">
            {!! $grid->renderExportButton() !!}
            {!! $grid->renderCreateButton() !!}
        </div>
        <span>
            {!! $grid->renderHeaderTools() !!}
        </span>
    </div>

    {!! $grid->renderFilter() !!}

<!-- /.box-header -->
@php
    try{
        $grid_mini_filter = $grid->option('grid_mini_filter');
    }catch(\Exception $e){
        $grid_mini_filter = null;
    }
@endphp

    <div id="adminGrid" class="box-body table-responsive no-padding">

                @if (!empty($grid_mini_filter) && $grid_mini_filter)
                    @foreach ($grid_mini_filter as $one_minifilter_key=>$one_minifilter)
                        @widget( $one_minifilter_key, $one_minifilter)
                    @endforeach
                @endif

        <table class="table table_bord table-bordered table-striped table-hover">
            <thead>
            <tr>
                @foreach($grid->columns() as $column)
                    <th>{{$column->getLabel()}}{!! $column->sorter() !!}</th>
                @endforeach
            </tr>
            </thead>

            <tbody>
            @foreach($grid->rows() as $row)
                <tr {!! $row->getRowAttributes() !!}>
                    @foreach($grid->columnNames as $name)
                        <td {!! $row->getColumnAttributes($name) !!}>
                            {!! $row->column($name) !!}
                        </td>
                    @endforeach
                </tr>
            @endforeach
            </tbody>

        </table>

    </div>

    {!! $grid->renderFooter() !!}

    <div class="box-footer clearfix">
        {!! $grid->paginator() !!}
    </div>
    <!-- /.box-body -->
</div>
