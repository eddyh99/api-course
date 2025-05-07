<?php
namespace App\Controllers\V1;
use App\Controllers\BaseController;
use CodeIgniter\API\ResponseTrait;

class Course extends BaseController
{
    use ResponseTrait;

    public function __construct()
    {
        $this->course  = model('App\Models\V1\Mdl_course');
    }

    public function getAll_course()
    {
        $result = $this->course->getcourse();
        return $this->respond(error_msg($result->code, "user", null, $result->message), $result->code);
    }

    public function getCourse_byid()
    {
        $idcourse = filter_var($this->request->getVar('id'), FILTER_SANITIZE_NUMBER_INT);
        $result = $this->course->getCourse_byId($idcourse);
        return $this->respond(error_msg($result->code, "user", null, $result->message), $result->code);
    }

}
