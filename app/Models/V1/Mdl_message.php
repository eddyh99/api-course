<?php

namespace App\Models\V1;

use CodeIgniter\Model;
use Exception;
use Hashids\Hashids;

/*----------------------------------------------------------
    Modul Name  : Database Member course 
    Desc        : Menyimpan data member course, proses member course
    Sub fungsi  : 
        - getby_id          : Mendapatkan data user dari username
        - change_password   : Ubah password
------------------------------------------------------------*/


class Mdl_message extends Model
{
    protected $server_tz = "Asia/Singapore";
    protected $table      = 'message';
    protected $primaryKey = 'id';

    protected $protectFields = false;
    protected $returnType = 'array';
    protected $useTimestamps = false;

    // Tambahkan data ke database
    public function add($data)
    {
        try {
            $message = $this->db->table("message");
            $message->insertBatch($data);

            return (object) [
                'success'  => true,
                'message' => 'Message Successfully sent'
            ];
        } catch (\Exception $e) {
            return (object) [
                'success'  => false,
                'code'    => $e->getCode(),
                'message' => 'An error occurred.'
            ];
        }
    }
    
    public function read_message($id){
        $sql="SELECT m.id, u.email as sender, m.subject, m.created_at as sent_date, is_read as isread, is_fav as isfav FROM
                user u INNER JOIN message m ON u.id=m.sender_id
                WHERE m.receiver_id=? ORDER BY m.created_at DESC
        ";
        $query=$this->db->query($sql,$id);
        return $query->getResult();
    }
    
    public function read_byID($id){
        $sql="SELECT m.id, u.email as sender, m.subject,m.content as text, m.created_at as sent_date, is_read as isread, is_fav as isfav FROM
                user u INNER JOIN message m ON u.id=m.sender_id
                WHERE m.id=? ORDER BY m.created_at DESC
        ";
        $query=$this->db->query($sql,$id);
        return $query->getRow();
    }

    public function update_status($id, $status)
    {

        if ($status === 'is_fav') {
            $sql = "UPDATE message SET $status = NOT $status WHERE id = ?";
            $query = $this->db->query($sql, [$id]); // Use array for parameters
    
            if ($query && $this->db->affectedRows() > 0) {
                return (object) ['success' => true, 'message' => 'Status updated successfully.'];
            }
        }else if ($status === 'is_read'){
            $sql = "UPDATE message SET is_read = 1 WHERE id = ?";
            $query = $this->db->query($sql, [$id]); // Use array for parameters
            return (object) ['success' => true, 'message' => 'Status updated successfully.'];
        }
    
        return (object) ['success' => false, 'message' => 'Update failed or invalid status.'];
    }
    
    public function delete_message($id){
        $this->delete($id);
        if ($this->db->affectedRows() > 0) {
            return (object) ['success' => true, 'message' => 'Delete Message successfully.'];
        }
        return (object) ['success' => false, 'message' => 'Update failed or invalid status.'];
    }

}
