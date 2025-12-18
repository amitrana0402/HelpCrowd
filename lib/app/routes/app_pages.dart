import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_email_view.dart';
import '../modules/auth/views/login_password_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_step1_view.dart';
import '../modules/signup/views/signup_step2_view.dart';
import '../modules/signup/views/signup_step3_view.dart';
import '../modules/signup/views/signup_step4_view.dart';
import '../modules/signup/views/signup_step5_view.dart';
import '../modules/signup/views/signup_step6_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INTRO;
  static const INTRO = Routes.INTRO;
  static const LANDING = Routes.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.INTRO,
      page: () => const IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_EMAIL,
      page: () => const LoginEmailView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PASSWORD,
      page: () => const LoginPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupStep1View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP1,
      page: () => const SignupStep1View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP2,
      page: () => const SignupStep2View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP3,
      page: () => const SignupStep3View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP4,
      page: () => const SignupStep4View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP5,
      page: () => const SignupStep5View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_STEP6,
      page: () => const SignupStep6View(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
