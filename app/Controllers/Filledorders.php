<?php

namespace App\Controllers;
use CodeIgniter\Exceptions\PageNotFoundException;

class Filledorders extends BaseController
{
    protected $group       = 'Custom';
    protected $name        = 'sync:filled-orders';
    protected $description = 'Sync filled orders from Redis to MySQL trade_table';
    
    public function __construct()
    {
        $this->demo  = model('App\Models\V1\Mdl_demo');
    }
    
    public function getFilled()
    {

        $key = 'filled_orders:BTCUSDT';
        $allItems = $this->redis->lrange($key, 0, -1);
        if (!empty($allItems)) {
            foreach ($allItems as $raw) {
                $order = json_decode($raw, true);
                if (!is_array($order) || !isset($order['order_id'])) {
                    log_message('error', 'Invalid order data: ' . $raw);
                    continue;
                }
                
                log_message('info', 'ORDER DATA : ' . $raw);
                $this->demo->filled_orders($order['order_id']);
                $this->redis->lrem($key, 1, $raw);
            }
        }
        echo "done";
    }
}
