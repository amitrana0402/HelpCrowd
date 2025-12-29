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
  static const APPEAL_PREFERENCES = _Paths.APPEAL_PREFERENCES;
  static const DONATION_PREFERENCES = _Paths.DONATION_PREFERENCES;
  static const SPECIFY_AMOUNT = _Paths.SPECIFY_AMOUNT;
  static const MAIN_NAVIGATION = _Paths.MAIN_NAVIGATION;
  static const HOME = _Paths.HOME;
  static const TRANSACTIONS = _Paths.TRANSACTIONS;
  static const PROFILE = _Paths.PROFILE;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const SETTINGS = _Paths.SETTINGS;
  static const NEWS_DETAIL = _Paths.NEWS_DETAIL;
  static const MY_DONATIONS = _Paths.MY_DONATIONS;
  static const FAVORITE_APPEALS = _Paths.FAVORITE_APPEALS;
  static const MAKE_ADHOC_DONATION = _Paths.MAKE_ADHOC_DONATION;
  static const MY_SPENDING_ACCOUNT = _Paths.MY_SPENDING_ACCOUNT;
  static const PROFILE_DONATION_PREFERENCES =
      _Paths.PROFILE_DONATION_PREFERENCES;
  static const PROFILE_APPEAL_PREFERENCES = _Paths.PROFILE_APPEAL_PREFERENCES;
  static const PROFILE_MANAGE_DONATION_CATEGORY =
      _Paths.PROFILE_MANAGE_DONATION_CATEGORY;
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
  static const APPEAL_PREFERENCES = '/appeal-preferences';
  static const DONATION_PREFERENCES = '/donation-preferences';
  static const SPECIFY_AMOUNT = '/specify-amount';
  static const MAIN_NAVIGATION = '/main-navigation';
  static const HOME = '/home';
  static const TRANSACTIONS = '/transactions';
  static const PROFILE = '/profile';
  static const NOTIFICATIONS = '/notifications';
  static const SETTINGS = '/settings';
  static const NEWS_DETAIL = '/news-detail';
  static const MY_DONATIONS = '/my-donations';
  static const FAVORITE_APPEALS = '/favorite-appeals';
  static const MAKE_ADHOC_DONATION = '/make-adhoc-donation';
  static const MY_SPENDING_ACCOUNT = '/my-spending-account';
  static const PROFILE_DONATION_PREFERENCES = '/profile-donation-preferences';
  static const PROFILE_APPEAL_PREFERENCES = '/profile-appeal-preferences';
  static const PROFILE_MANAGE_DONATION_CATEGORY =
      '/profile-manage-donation-category';
}
