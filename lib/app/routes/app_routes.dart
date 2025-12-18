part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const INTRO = _Paths.INTRO;
  static const LANDING = _Paths.LANDING;
  static const LOGIN_EMAIL = _Paths.LOGIN_EMAIL;
  static const LOGIN_PASSWORD = _Paths.LOGIN_PASSWORD;
  static const SIGNUP = _Paths.SIGNUP;
  static const SIGNUP_STEP1 = _Paths.SIGNUP_STEP1;
  static const SIGNUP_STEP2 = _Paths.SIGNUP_STEP2;
  static const SIGNUP_STEP3 = _Paths.SIGNUP_STEP3;
  static const SIGNUP_STEP4 = _Paths.SIGNUP_STEP4;
  static const SIGNUP_STEP5 = _Paths.SIGNUP_STEP5;
  static const SIGNUP_STEP6 = _Paths.SIGNUP_STEP6;
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  _Paths._();
  static const INTRO = '/intro';
  static const LANDING = '/landing';
  static const LOGIN_EMAIL = '/login-email';
  static const LOGIN_PASSWORD = '/login-password';
  static const SIGNUP = '/signup';
  static const SIGNUP_STEP1 = '/signup/step1';
  static const SIGNUP_STEP2 = '/signup/step2';
  static const SIGNUP_STEP3 = '/signup/step3';
  static const SIGNUP_STEP4 = '/signup/step4';
  static const SIGNUP_STEP5 = '/signup/step5';
  static const SIGNUP_STEP6 = '/signup/step6';
  static const HOME = '/home';
}
