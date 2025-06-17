<?php
namespace App\Controllers\V1;
use App\Controllers\BaseController;
use CodeIgniter\API\ResponseTrait;

class Message extends BaseController
{
    use ResponseTrait;

    public function __construct()
    {
        $this->message  = model('App\Models\V1\Mdl_message');
    }

    public function postSend_message() {
        $data = $this->request->getJSON();
		$result = $this->message->add($data);
		if (!@$result->success) {
			return $this->respond(error_msg(400, "message", '01', $result->message), 400);
		}


        return $this->respond(error_msg(201, "message", null, $result->message), 201);
    }
    
    public function getAll_message(){
        $id = filter_var($this->request->getVar('id'), FILTER_SANITIZE_NUMBER_INT);
        
		$result = $this->message->read_message($id);
        return $this->respond(error_msg(201, "message", null, $result), 200);
    }
    
    public function getMessage_byid(){
        $id = filter_var($this->request->getVar('id'), FILTER_SANITIZE_NUMBER_INT);
        
		$result = $this->message->read_byID($id);
        return $this->respond(error_msg(200, "message", null, $result), 200);
    }
    
    public function getUpdate_status(){
        $id = filter_var($this->request->getVar('id'), FILTER_SANITIZE_NUMBER_INT);
        $status = filter_var($this->request->getVar('status'));

		$result = $this->message->update_status($id,$status);
        return $this->respond(error_msg(200, "message", null, $result->message), 200);
    }
    
    public function getDelete_byid(){
        $id = filter_var($this->request->getVar('id'), FILTER_SANITIZE_NUMBER_INT);
        
		$result = $this->message->delete_message($id);
        return $this->respond(error_msg(200, "message", null, $result->message), 200);
    }

}
