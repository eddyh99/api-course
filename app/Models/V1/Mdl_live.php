<?php

namespace App\Models\V1;

use CodeIgniter\Model;

/*----------------------------------------------------------
    Modul Name  : Database live 
    Desc        : Menyimpan data course, proses course
    Sub fungsi  : 
        - getby_id          : Mendapatkan data user dari username
        - change_password   : Ubah password
------------------------------------------------------------*/


class Mdl_live extends Model
{
    protected $server_tz = "Asia/Singapore";
    protected $table      = 'courses';
    protected $primaryKey = 'id';

    protected $protectFields = false;
    protected $returnType = 'array';
    protected $useTimestamps = true;


    public function add($data)
    {
        if($this->checkEvent($data)) {
            return (object) [
                'code'    => 400,
                'message' => 'Live streaming time overlaps with another event.'
            ];
        }
        try {
            $course = $this->db->table("live");
            $course->insert($data);
    
            return (object) [
                'code'    => 201,
                'message' => 'Live schedule added successfully.'
            ];
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'Failed to add live schedule.'
            ];
        }
    }

    private function checkEvent($data) {
        $startDateTime = $data['start_date'];    
        $durationStr = $data['duration'];     

        $start = new \DateTime($startDateTime);
        $end = clone $start;
        $end->modify("+{$durationStr} minutes");
        $end->modify("+60 minutes");

        $startStr = $start->format('Y-m-d H:i:s');
        $endStr = $end->format('Y-m-d H:i:s');

        $builder = $this->db->table('live');

        $builder->groupStart()
            ->where('start_date <', $endStr)
            ->where("DATE_ADD(start_date, INTERVAL duration MINUTE) > ", $startStr)
            ->groupEnd();

        $existing = $builder->get()->getResult();

        return count($existing) > 0;
    }
}