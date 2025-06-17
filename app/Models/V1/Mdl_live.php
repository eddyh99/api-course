<?php

namespace App\Models\V1;

use CodeIgniter\Model;
use Exception;

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
    protected $table      = 'live';
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

    public function getLive()
    {

        try {

            $sql = "SELECT
                        live.id,
                        live.title,
                        live.start_date,
                        live.roomid,
                        DATE_ADD(live.start_date, INTERVAL live.duration MINUTE) AS end_date,
                        u.name AS mentor
                    FROM
                        live
                        INNER JOIN user u ON u.id = live.mentor_id
                        -- filter live yang sudah berlalu/selesai
                    WHERE
                        live.start_date >= NOW() - INTERVAL 1 DAY";

            $query = $this->db->query($sql)->getResult();

            if (!$query) {
                return (object) [
                    'code'    => 404,
                    'message' => []
                ];
            }
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred' . $e
            ];
        }

        return (object) [
            "code"    => 200,
            "message"    => $query
        ];
    }

    private function checkEvent($data) {
        $startNew = $data['start_date'];
    
        $builder = $this->db->table('live');
    
        $builder->groupStart()
        ->where('start_date <=', $startNew)
        ->where("ADDTIME(start_date, SEC_TO_TIME((duration + 60) * 60)) >=", $startNew)
        ->groupEnd();    
    
        $existing = $builder->get()->getResult();
    
        return count($existing) > 0;
    }
    
    

    public function deleteby_id($id)
    {
        try {
            $deleted = $this->delete($id);
    
            if (!$deleted) {
                return (object) [
                    'code'    => 404,
                    'message' => 'Live not found or already deleted.'
                ];
            }
    
            return (object) [
                'code'    => 201,
                'message' => 'Live has been successfully deleted.'
            ];
        } catch (Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred while deleting the live.'
            ];
        }
    }

    public function getActive_live()
    {

        try {

            $sql = "SELECT
                        live.title,
                        DATE_FORMAT(start_date, '%W, %d %M %Y - %h.%i %p') as start_date,
                        u.name as mentor,
                        live.roomid,
                        TIMESTAMPDIFF(MINUTE, NOW(), start_date) AS remaining
                    FROM
                        live
                        INNER JOIN user u ON u.id = live.mentor_id
                    WHERE
                        -- Sedang berlangsung sekarang
                        NOW() BETWEEN start_date
                        AND DATE_ADD(start_date, INTERVAL duration MINUTE)
                        OR -- Akan dimulai dalam 2 jam
                        start_date BETWEEN NOW()
                        AND DATE_ADD(NOW(), INTERVAL 2 HOUR)";

            $query = $this->db->query($sql)->getRow();

            if (!$query) {
                return (object) [
                    'code'    => 404,
                    'message' => []
                ];
            }
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred'
            ];
        }

        return (object) [
            "code"    => 200,
            "message"    => $query
        ];
    }

    
}