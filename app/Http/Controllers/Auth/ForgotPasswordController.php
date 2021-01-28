<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\BackendController;
use App\Http\Controllers\FrontendController;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;

class ForgotPasswordController extends FrontendController
{
    /*
    |--------------------------------------------------------------------------
    | Password Reset BackendController
    |--------------------------------------------------------------------------
    |
    | This controller is responsible for handling password reset emails and
    | includes a trait which assists in sending these notifications from
    | your application to your users. Feel free to explore this trait.
    |
    */

    use SendsPasswordResetEmails;
}
