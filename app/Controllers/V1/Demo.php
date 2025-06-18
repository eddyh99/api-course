<?php
namespace App\Controllers\V1;
use App\Controllers\BaseController;
use CodeIgniter\API\ResponseTrait;

class Demo extends BaseController
{
    use ResponseTrait;

    public function __construct()
    {
        $this->demo  = model('App\Models\V1\Mdl_demo');
        $this->user  = model('App\Models\V1\Mdl_user');
    }

    public function getBalance()
    {
        $id = filter_var($this->request->getVar('id'), FILTER_SANITIZE_NUMBER_INT);
        $result = $this->demo->getbalance_byid($id);
        if ($result->code==200){
            return $this->respond(error_msg($result->code, "demo", null, $result->message), $result->code);
        }
    }
    
    function floorToDecimal($value, $decimals = 6) {
        $factor = bcpow('10', (string)$decimals);
        $multiplied = bcmul((string)$value, $factor, 8);
        $floored = floor((float)$multiplied);
        return bcdiv((string)$floored, $factor, $decimals);
    }


    public function postTrade_buy (){
        $data   = $this->request->getJSON();
        $result = $this->demo->getbalance_byid($data->user_id)->message;
        $balance    = $result->available_balance ?? 0;

        $price      = str_replace(',', '', $data->order_price);
        $usdtAmount = str_replace(',', '', $data->usdt_qty);

        if (bccomp($usdtAmount, $balance, 8) === 1) {
            return $this->respond(error_msg(400, "order", '01', 'Insufficient Balance'), 400);
        }
        
        $btcQty = $this->floorToDecimal($usdtAmount / $price, 6);
        $data->btc_qty = $btcQty;
        $result = $this->demo->buy_trade($data);
        if (!$result->status){
            return $this->respond(error_msg(400, "order", '02', $result->message), 400);
        }
        
        $data->order_id = $result->message;
        return $this->respond(error_msg(200, "order", '01', $data), 200);
    }
    
    public function getTrade_history(){
        $id = filter_var($this->request->getVar('id'), FILTER_SANITIZE_NUMBER_INT);
        $result = $this->demo->trade_historybyID($id);
        if ($result->status){
            return $this->respond(error_msg(200, "demo", null, $result->message), 200);
        }
    }
    
    public function getTrade_historybyemail(){
        $email = filter_var($this->request->getVar('email'), FILTER_VALIDATE_EMAIL);
        $result = $this->demo->trade_historybyEmail($email);
        if ($result->status){
            return $this->respond(error_msg(200, "demo", null, $result->message), 200);
        }
    }
    
     public function postOpen_exam(){
        $data   = $this->request->getJSON();
        $user_id = $this->user->getUser_byEmail($data->email)->message->id;
        $mdata = array(
                "user_id"   => $user_id,
                "capital"   => $data->capital,
                "status"    => 'active'
            );

        $result = $this->demo->trade_exam($mdata);
        if (!$result->status){
            return $this->respond(error_msg(400, "order", '02', $result->message), 400);
        }
        
        return $this->respond(error_msg(200, "order", '01', $result->message), 200);
    }
    
    public function postReopen(){
        $data   = $this->request->getJSON();
        $result = $this->demo->reopen_trade($data->status, $data->trade_id);
        if (!$result->status){
            return $this->respond(error_msg(400, "order", '02', $result->message), 400);
        }
        
        return $this->respond(error_msg(200, "order", '01', $result->message), 200);
    }
}
