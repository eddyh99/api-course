<?php

namespace App\Models\V1;

use CodeIgniter\Model;
use Exception;

/*----------------------------------------------------------
    Modul Name  : Database Member course 
    Desc        : Menyimpan data member course, proses member course
    Sub fungsi  : 
        - getby_id          : Mendapatkan data user dari username
        - change_password   : Ubah password
------------------------------------------------------------*/


class Mdl_demo extends Model
{
    protected $server_tz = "Asia/Singapore";
    protected $table      = 'trade_table';
    protected $primaryKey = 'id';

    protected $protectFields = false;
    protected $returnType = 'array';
    protected $useTimestamps = false;

    public function getbalance_byid($id)
    {

        try {

            $sql = "WITH
                      -- 1. Total initial capital per user
                      initial_capital AS (
                        SELECT
                          user_id, id as trade_id,
                          SUM(capital) AS initial_capital
                        FROM trade_capital
                        WHERE status = 'active'
                        GROUP BY user_id
                      ),
                    
                      -- 2. Aggregate all BUYs (filled) per user
                      buy_summary AS (
                        SELECT
                          user_id,
                          SUM(usdt_qty)        AS total_buy_usdt,
                          SUM(btc_qty)         AS total_buy_btc
                        FROM trade_table
                        WHERE order_type = 'buy'
                          AND status = 'filled'
                        GROUP BY user_id
                      ),
                    
                      -- 3. Aggregate all SELLs (filled) per user
                      sell_summary AS (
                        SELECT
                          user_id,
                          SUM(order_price * btc_qty) AS total_sell_usdt,
                          SUM(btc_qty)               AS total_sell_btc
                        FROM trade_table
                        WHERE order_type = 'sell'
                          AND status = 'filled'
                        GROUP BY user_id
                      )
                    
                    SELECT
                      ic.trade_id,
                      ic.user_id,
                      ic.initial_capital,
                    
                      -- money spent buying
                      COALESCE(bs.total_buy_usdt, 0)  AS total_buy_usdt,
                      -- usdt received from selling
                      COALESCE(ss.total_sell_usdt, 0) AS total_sell_usdt,
                    
                      -- net realized P/L = sold proceeds − cost of the BTC that was actually closed out
                      --   cost_closed = total_buy_usdt − usdt_locked
                      --   profit      = total_sell_usdt − cost_closed
                      -- but you can also see net P/L simply as total_sell_usdt − total_buy_usdt + usdt_locked
                      (COALESCE(ss.total_sell_usdt, 0)
                       - (COALESCE(bs.total_buy_usdt, 0)
                          - ((COALESCE(bs.total_buy_usdt, 0) / NULLIF(bs.total_buy_btc,1))
                             * GREATEST(COALESCE(bs.total_buy_btc, 0) - COALESCE(ss.total_sell_btc, 0), 0))
                         )
                      ) AS realized_profit,
                    
                      -- how much BTC still open
                      GREATEST(COALESCE(bs.total_buy_btc, 0) - COALESCE(ss.total_sell_btc, 0), 0)
                        AS btc_qty,
                    
                      -- USDT locked up in the remaining (open) BTC position, 
                      --   using weighted-average buy price = total_buy_usdt/total_buy_btc
                      ((COALESCE(bs.total_buy_usdt, 0) 
                        / NULLIF(bs.total_buy_btc, 1))
                       * GREATEST(COALESCE(bs.total_buy_btc, 0) - COALESCE(ss.total_sell_btc, 0), 0)
                      ) AS usdt_locked_in_buys,
                    
                      -- finally, available balance = initial + realized_profit − usdt_locked
                      (ic.initial_capital
                       + (COALESCE(ss.total_sell_usdt, 0)
                          - (COALESCE(bs.total_buy_usdt, 0)
                             - ((COALESCE(bs.total_buy_usdt, 0) / NULLIF(bs.total_buy_btc,1))
                                * GREATEST(COALESCE(bs.total_buy_btc, 0) - COALESCE(ss.total_sell_btc, 0), 0))
                            )
                         )
                       - ((COALESCE(bs.total_buy_usdt, 0) / NULLIF(bs.total_buy_btc,1))
                          * GREATEST(COALESCE(bs.total_buy_btc, 0) - COALESCE(ss.total_sell_btc, 0), 0))
                      ) AS available_balance
                    
                    FROM initial_capital ic
                    LEFT JOIN buy_summary  bs ON bs.user_id = ic.user_id
                    LEFT JOIN sell_summary ss ON ss.user_id = ic.user_id
                    WHERE ic.user_id=?
            
            ";

            $query = $this->db->query($sql, [$id])->getRow();

            if (!$query) {
                return (object) [
                    'code'    => 404,
                    'message' => 'User not found or no trade data'
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
    
    public function buy_trade($data){
        try{
            $trade = $this->db->table("trade_table");
            if (!$trade->insert($data)) {
                return (object) [
                    'status' => false,
                    'message' => 'Failed to create order'
                ];
            }
        } catch (\Exception $e) {
            return (object) [
                'status'    => false,
                'message' => $e->getMessage()//'An error occurred'
            ];
        }

        return (object) [
            "status"    => true,
            "message"    => $this->db->insertID()
        ];
    }

    public function trade_exam($data){
        try{
            $trade = $this->db->table("trade_capital");
            if (!$trade->insert($data)) {
                return (object) [
                    'status' => false,
                    'message' => 'Failed to set capital'
                ];
            }
        } catch (\Exception $e) {
            return (object) [
                'status'    => false,
                'message' => $e->getMessage()//'An error occurred'
            ];
        }

        return (object) [
            "status"    => true,
            'message' => 'Successfully open Demo Trade'       
        ];
    }
    
    public function reopen_trade($status, $trade_id){
        $this->db->table('trade_capital')
        ->where('id', $trade_id)
        ->update(['status' => $status]);
        return (object) [
            "status"    => true,
            'message' => 'Successfully Updated'       
        ];
    }
    
    public function filled_orders($orderid){
        $this->db->table('trade_table')
        ->where('id', $orderid)
        ->update(['status' => 'filled']);
    }
    
    public function trade_historybyID($id){
        $sql="SELECT tt.* 
                FROM trade_table tt INNER JOIN trade_capital tc 
                    ON tt.trade_id=tc.id 
                WHERE tt.user_id=? 
                AND tt.status='filled' 
                AND tc.status='active'";
        $query=$this->db->query($sql,$id);
        return (object) [
            "status"     => true,
            "message"    => $query->getResult()
        ];
    }
    
    public function trade_historybyEmail($email){
        $sql="SELECT tt.* 
                FROM trade_table tt INNER JOIN trade_capital tc 
                    ON tt.trade_id=tc.id 
                INNER JOIN user us ON tt.user_id=us.id
                WHERE us.email=? 
                AND tc.status='active'";
        $query=$this->db->query($sql,$email);
        return (object) [
            "status"     => true,
            "message"    => $query->getResult()
        ];
    }
    
}
