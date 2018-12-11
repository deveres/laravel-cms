<?php

namespace App\Src\Admin\Extensions;

use Encore\Admin\Admin;
use Encore\Admin\Grid\Displayers\AbstractDisplayer;

class RowOrderable extends AbstractDisplayer
{
    public function display($outGrid = 'left', $route = null)
    {
        $this->grid->rows(function (\Encore\Admin\Grid\Row $row) {
            $row->setAttributes(['id' => 'tr_'.$row->id, 'class' => 'tr_depth_'.(($row->depth) ? $row->depth : 0).' tr_parent_'.$row->parent_id]);
        });

        Admin::script($this->_getScript($route));

        return '<i class="fa fa-fw fa-arrows img_mover" style="cursor:move;" ></i> 
				<input type="hidden" value="'.$this->row->id.'" class="input_sort_parent_'.$this->row->parent_id.'" />';
    }

    protected function _getScript($route = null)
    {
        $url = $route;

        return <<<EOT
       (function(){
        
          
		var grid_normal_tr_size = [];
		var grid_move_tr_ids = [];
		var grid_tr_list = null;

		
			$('#adminGrid').find('table.table_bord tr:eq(1) > td').each(function(i){
				grid_normal_tr_size[i] = $(this).outerWidth()
			});

			grid_tr_list = $('#adminGrid').find('table.table_bord')
			grid_tr_list.sortable({
				axis: 'y', items : 'tr', containment: 'parent', cancel : '#tr_head',
				handle : '.img_mover', start : grid_start_move, placeholder : 'ui-sortable-placeholder',
				stop : grid_stop_move, forceHelperSize: true, forcePlaceholderSize: true
			});
		

		function grid_start_move(event, ui)
		{
			grid_filter_by_parent(ui.item[0]);
			grid_hide_rows_recursive(ui.item[0]);

			ui.item.find('>td').each(function(i){
			
				$(this).css('width', grid_normal_tr_size[i]+'px');
			});
		}

		function grid_hide_rows_recursive(obj)
		{
			var current_id = parseInt(obj.id.toString().substr(3));

			if ($('.tr_parent_'+current_id).size() == 0) return;

			$('.tr_parent_'+current_id).each(function(){
				grid_hide_rows_recursive(this);
			});

			$('.tr_parent_'+current_id).hide();
			grid_tr_list.sortable('refreshPositions');
		}

		function grid_move_rows_recursive(obj)
		{
			var current_id = parseInt(obj.id.toString().substr(3));

			$(obj).after($('.tr_parent_'+current_id));
			$('.tr_parent_'+current_id).each(function(){
				grid_move_rows_recursive(this);
			});
		}

		function grid_filter_by_parent(obj)
		{
			var parent_pattern = /tr_parent_([0-9])+/gi;
			var parent_id = obj.className.match(parent_pattern).toString().substr(10);
			var parent_id = parseInt(parent_id);

			grid_tr_list.sortable('option', 'items', 'tr.tr_parent_'+parent_id);
			grid_tr_list.sortable('refresh');
		}

		function grid_stop_move(event, ui)
		{
			var result = grid_tr_list.sortable('toArray');
			
                            $.ajax({
                                method: 'post',
                                url: '{$url}',
                                data: {
                                    _token:LA.token,
                                    items:   result                  
                                },
                                success: function () {
                                   
                                    toastr.success('Данные сохранены');
                                },
                                error:function(){
                                   toastr.error('Ошибка!!!');
                                }
                              });
                                        
	
			grid_move_rows_recursive(ui.item[0]);
			ui.item.parent().find('tr').show();
		} 
		}());
EOT;
    }
}
