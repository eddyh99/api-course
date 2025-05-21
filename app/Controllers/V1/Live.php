<?php
namespace App\Controllers\V1;
use App\Controllers\BaseController;
use CodeIgniter\API\ResponseTrait;

class Live extends BaseController
{
    use ResponseTrait;

    public function __construct()
    {
        $this->live  = model('App\Models\V1\Mdl_live');
    }

    public function postStore() {
        $data = $this->request->getJSON();

        $mdata = [
            'title'      => trim($data->title),
            'mentor_id'  => trim($data->mentor_id),
            'start_date' => trim($data->start_date),
            'status'     => 'upcoming',
            'duration'   => trim($data->duration)
        ];

		$result = $this->live->add($mdata);
		if (@$result->code != 201) {
			return $this->respond(error_msg(400, "course", '01', $result->message), 400);
		}

        return $this->respond(error_msg(201, "course", null, $result->message), 201);
    }
}