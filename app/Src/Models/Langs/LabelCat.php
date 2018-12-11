<?php

namespace App\Src\Models\Langs;

use App\Src\Services\I18nService;
use Encore\Admin\Traits\AdminBuilder;
use Encore\Admin\Traits\ModelTree;
use Illuminate\Database\Eloquent\Model;

class LabelCat extends Model
{
    use ModelTree, AdminBuilder;
    public $incrementing = 'id';
    public $timestamps = false;

    protected $primaryKey = 'id';

    protected $table = 'label_cats';

    protected $fillable = ['name', 'alias', 'ord', 'state', 'parent_id'];

    public function __construct(array $attributes = [])
    {
        parent::__construct($attributes);

        $this->setParentColumn('parent_id');
        $this->setOrderColumn('ord');
        $this->setTitleColumn('name');
    }

    public function fetchTree()
    {
        return collect($this->getStructure());
    }

    public function getStructure($parent_id = 0, $exclude_id = 0, $just_state_on = false, $depth = 1, $parent_link = '')
    {
        $table = self::query();
        $table->where($this->getParentColumn(), $parent_id)
            ->where($this->getKeyName(), '!=', $exclude_id);

        if ($just_state_on) {
            $table->where('state', 1);
        }
        $data = $table->orderBy($this->getOrderColumn())->get();

        $result = [];
        $counter = 1;
        foreach ($data as $value) {
            // $value = (array) $value;

            $result[$value['id']] = $value;
            $result[$value['id']]->depth = $depth;
            $result[$value['id']]->first = (1 === $counter);
            $result[$value['id']]->last = ($counter === count($data));
            $result[$value['id']]->link = $parent_link.$value->alias.'/';

            $add_data = $this->getStructure($value->id, $exclude_id, $just_state_on, $depth + 1, $result[$value['id']]->link);
            $result[$value['id']]->child_count = count($add_data);
            $result += $add_data;

            $counter++;
        }

        unset($table);

        return $result;
    }

    public function getStructure4Select($parent_id = 0, $exclude_id = 0)
    {
        $data = $this->getStructure($parent_id);

        if (!$exclude_id) {
            return $data;
        }
        $ids = [$exclude_id];
        foreach ($data as &$value) {
            if (!in_array($value['parent_id'], $ids, true) && !in_array($value['id'], $ids, true)) {
                continue;
            }
            $value['disabled'] = true;
            $ids[$value['id']] = $value['id'];
        }

        return $data;
    }

    protected static function boot()
    {
        parent::boot();

        static::saved(function (LabelCat $cat) {
            I18nService::export();

            return true;
        });
    }
}
