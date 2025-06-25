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


class Mdl_user extends Model
{
    protected $server_tz = "Asia/Singapore";
    protected $table      = 'user';
    protected $primaryKey = 'id';

    protected $protectFields = false;
    protected $returnType = 'array';
    protected $useTimestamps = false;

    // Tambahkan data ke database
    public function add($data)
    {
        try {
            $user = $this->db->table("user");
            $user->insert($data);

            return (object) [
                'success'  => true,
                'message' => 'User registered successfully'
            ];
        } catch (\Exception $e) {
            return (object) [
                'success'  => false,
                'code'    => $e->getCode(),
                'message' => 'An error occurred.'
            ];
        }
    }

    public function getMentor()
    {

        try {

            $sql = "SELECT * FROM user WHERE role = 'mentor' AND is_delete = false";

            $query = $this->db->query($sql)->getResult();

            if (!$query) {
                return (object) [
                    'code'    => 200,
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
    
    public function member_email(){
        try {

            $sql = "SELECT id, email FROM user WHERE role = 'member' AND is_delete = false AND payment_status='completed'";

            $query = $this->db->query($sql)->getResult();

            if (!$query) {
                return (object) [
                    'code'    => 200,
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

    public function getMember()
    {

        try {

            $sql = "SELECT 
                u.*, 
                100 AS material_exam, 
                100 AS demo_trade, 
                tc.id AS trade_id,
                tc.status
            FROM user u
            LEFT JOIN (
                SELECT 
                    t1.*
                FROM trade_capital t1
                WHERE t1.id = (
                    SELECT t2.id
                    FROM trade_capital t2
                    WHERE t2.user_id = t1.user_id
                    ORDER BY 
                        -- Prefer active
                        CASE WHEN t2.status = 'active' THEN 1 ELSE 2 END,
                        t2.created_at DESC
                    LIMIT 1
                )
            ) tc ON u.id = tc.user_id
            WHERE 
                u.role = 'member' 
                AND u.is_delete = false 
                -- AND u.payment_status = 'completed'
            ";

            $query = $this->db->query($sql)->getResult();

            if (!$query) {
                return (object) [
                    'code'    => 200,
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

    public function getUser_byEmail($email)
    {

        try {

            $sql = "SELECT * FROM user WHERE email = ?";

            $query = $this->db->query($sql, [$email])->getRow();

            if (!$query) {
                return (object) [
                    'code'    => 200,
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

    
    public function setUser_paid($email) {
        try {
            // Cek apakah email ada di database
            $user = $this->where('email', $email)->first();
            
            if (!$user) {
                return (object) [
                    'code'    => 404,
                    'message' => 'User not found'
                ];
            }

            // Update status berdasarkan email
            $this->set(['status' => 'active', 'payment_status' => 'completed'])->where('email', $email)->update();

            return (object) [
                'code'    => 201,
                'message' => 'Payment successfully updated.'
            ];
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred while updating payment status' . $e
            ];
        }
    }

    public function setstatus_user($mdata) {
        try {
    
            // Update status "member"
            $this->set(['status' => $mdata['status']])
                 ->where('email', $mdata['email'])
                 ->update();
    
            return (object) [
                'code'    => 201,
                'message' => 'The account has been updated.'
            ];
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred'
            ];
        }
    }

    public function reset_password($mdata, $isgodmode)
    {
        try {
            // Validasi OTP dan email
            $builder = $this->where('email', $mdata['email']);

            if (!$isgodmode) {
                $builder = $builder->where('otp', $mdata['otp']);
            }

            $valid = $builder->first();
    
            if (!$valid) {
                return (object) [
                    'code'    => 400,
                    'message' => 'Invalid token' . ''
                ];
            }
    
            // Update password dan hapus OTP
            $this->set([
                'status' => $valid['status'] == 'new' ? 'active' : $valid['status'],
                'password' => $mdata['password'],
                'otp'    => null // menghapus otp
            ])
            ->where('email', $mdata['email'])
            ->update();
    
            return (object) [
                'code'    => 201,
                'message' => 'Password has been reset successfully'
            ];
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred while resetting the password' .$e
            ];
        }
    }

    public function otp_check($mdata)
    {
        try {
            // Validasi OTP dan email
            $valid = $this->where('email', $mdata['email'])
                ->where('otp', $mdata['otp'])
                ->first();
    
            if (!$valid) {
                return (object) [
                    'code'    => 400,
                    'message' => false
                ];
            }

            return (object) [
                'code'    => 200,
                'message' => true
            ];

        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => false
            ];
        }
    }

    public function update_otp($mdata) {
        try {
            // Cek apakah email ada di database
            $member = $this->where('email', $mdata['email'])->first();
            
            if (!$member) {
                return (object) [
                    'code'    => 404,
                    'message' => 'User not found'
                ];
            }

            // Update OTP berdasarkan email
            $this->set('otp', $mdata['otp'])->where('email', $mdata['email'])->update();

            return (object) [
                'code'    => 201,
                'message' => 'Your token has been resent via email'
            ];
        } catch (\Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred while updating token'
            ];
        }
    }

    public function deleteby_email($mdata)
    {
        try {
            $sql = "SELECT email, role FROM user where email = ?";
            $user = $this->db->query($sql, $mdata['email'])->getRow();

            if (!$user) {
                return (object) [
                    'code'    => 404,
                    'message' => 'User not found.'
                ];
            }

            if($user->role == 'superadmin') {
                return (object) [
                    'code'    => 403,
                    'message' => 'Action denied. Superadmin cannot be deleted.'
                ];
            }

            $this->set([
                'email' => $mdata['new_email'],
                'is_delete' => true
            ])->where('email', $user->email)->update();

        } catch (Exception $e) {
            return (object) [
                'code'    => 500,
                'message' => 'An error occurred while deleting the account.' .$e
            ];
        }

        return (object) [
            'code'    => 201,
            'message' => 'Account has been successfully deleted.'
        ];
    }
}
