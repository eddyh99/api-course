<?php

namespace App\Models\V1;

use CodeIgniter\Model;

/*----------------------------------------------------------
    Modul Name  : Database course 
    Desc        : Menyimpan data course, proses course
    Sub fungsi  : 
        - getby_id          : Mendapatkan data user dari username
        - change_password   : Ubah password
------------------------------------------------------------*/


class Mdl_course extends Model
{
    protected $server_tz = "Asia/Singapore";
    protected $table      = 'courses';
    protected $primaryKey = 'id';

    protected $protectFields = false;
    protected $returnType = 'array';
    protected $useTimestamps = true;


    public function add($data)
    {
        try {
            $course = $this->db->table("courses");
            $course->insert($data);
    
            return (object) [
                'code'    => 201,
                'message' => 'Course added successfully.'
            ];
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'Failed to add course.'
            ];
        }
    }
    

    public function getCourse()
    {

        try {

            $sql = "SELECT 
                    *,
                    SUBSTRING_INDEX(courses.description, ' ', 30) AS short_desc,
                    u.name AS mentor
                    FROM courses
                    INNER JOIN user u ON u.id = courses.mentor_id";

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

    public function getCourse_byId($id_course)
    {

        try {

            $sql = "SELECT * FROM courses INNER JOIN user u ON u.id = courses.mentor_id WHERE courses.id = ?";

            $query = $this->db->query($sql, $id_course)->getRow();

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
}
