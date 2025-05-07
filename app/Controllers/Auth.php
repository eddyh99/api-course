<?php

namespace App\Controllers;

use App\Controllers\BaseController;
use CodeIgniter\API\ResponseTrait;

class Auth extends BaseController
{
	use ResponseTrait;

	public function __construct()
	{
		$this->user  = model('App\Models\V1\Mdl_user');
	}

	public function postSignin()
	{
		$validation = $this->validation;
		$validation->setRules([
			'email' => [
				'rules'  => 'required|valid_email',
				'errors' => [
					'required'      => 'Email is required',
					'valid_email'   => 'Invalid Email format'
				]
			],
			'password' => [
				'rules'  => 'required|min_length[8]',
				'errors' =>  [
					'required'      => 'Password is required',
					'min_length'    => 'Min length password is 8 character'
				]
			],
		]);

		if (!$validation->withRequest($this->request)->run()) {
			return $this->fail($validation->getErrors());
		}

		$data           = $this->request->getJSON();

		$member = $this->user->getUser_byEmail($data->email);
		if (@$member->code != 200) {
			return $this->respond(error_msg($member->code, "auth", "01", $member->message), $member->code);
		}

		if(empty($member->message)) {
			return $this->respond(error_msg(404, "auth", "02", 'Account not found'), 404);
		}

		if ($data->password == $member->message->password) {
			$response = $member->message;

			if($response->status == 'disabled') {
				return $this->respond(error_msg(400, "auth", "02", 'Account has been disabled'), 400);
			}

			return $this->respond(error_msg(200, "auth", "02", $response), 200);
		} else {
			$response = "Invalid email or password";
			return $this->respond(error_msg(400, "auth", "02", $response), 400);
		}
	}

	public function postResetpassword() {

		$data       = $this->request->getJSON();

		$mdata = [
			'email' 	=> trim($data->email),
			'password'  => trim($data->password),
			'otp'		=> trim($data->otp)
		];

		$result = $this->user->reset_password($mdata);
		if ($result->code !== 200) {
			return $this->respond(error_msg($result->code, "auth", '01', $result->message), $result->code);
		}

		return $this->respond(error_msg(200, "auth", null, $result->message), 200);
	}

	public function postOtp_check() {
        $data = $this->request->getJSON();
        $mdata = [
            "email" => $data->email,
            "otp" => $data->otp
        ];

        $result = $this->user->otp_check($mdata);
        if (@$result->code != 200) {
			return $this->respond(error_msg($result->code, "member", "01", $result->message), $result->code);
		}

        return $this->respond(error_msg(200, "member", null, $result->message), 200);
    }

	public function postResendtoken()
	{
		$email = $this->request->getJSON()->email;
		$mdata = [
			'email' => filter_var($email, FILTER_VALIDATE_EMAIL),
			'otp'	=> rand(1000, 9999)
		];

		$result = $this->user->update_otp($mdata);
		if ($result->code !== 201) {
			return $this->respond(error_msg($result->code, "auth", '01', $result->message), $result->code);
		}

		$message = [
			'text' => $result->message,
			"otp"	  => $mdata['otp']
		];

		return $this->respond(error_msg(201, "auth", null, $message), 201);
	}
}
