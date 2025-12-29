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
import '../modules/appeal_preferences/bindings/appeal_preferences_binding.dart';
import '../modules/appeal_preferences/views/appeal_preferences_view.dart';
import '../modules/donation_preferences/bindings/donation_preferences_binding.dart';
import '../modules/donation_preferences/views/donation_preferences_view.dart';
import '../modules/specify_amount/bindings/specify_amount_binding.dart';
import '../modules/specify_amount/views/specify_amount_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_view.dart';
import '../modules/my_donations/bindings/my_donations_binding.dart';
import '../modules/my_donations/views/my_donations_view.dart';
import '../modules/favorite_appeals/bindings/favorite_appeals_binding.dart';
import '../modules/favorite_appeals/views/favorite_appeals_view.dart';
import '../modules/make_adhoc_donation/bindings/make_adhoc_donation_binding.dart';
import '../modules/make_adhoc_donation/views/make_adhoc_donation_view.dart';
import '../modules/my_spending_account/bindings/my_spending_account_binding.dart';
import '../modules/my_spending_account/views/my_spending_account_view.dart';
import '../modules/profile_donation_preferences/bindings/profile_donation_preferences_binding.dart';
import '../modules/profile_donation_preferences/views/profile_donation_preferences_view.dart';
import '../modules/profile_appeal_preferences/bindings/profile_appeal_preferences_binding.dart';
import '../modules/profile_appeal_preferences/views/profile_appeal_preferences_view.dart';
import '../modules/profile_manage_donation_category/bindings/profile_manage_donation_category_binding.dart';
import '../modules/profile_manage_donation_category/views/profile_manage_donation_category_view.dart';

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
      name: _Paths.APPEAL_PREFERENCES,
      page: () => const AppealPreferencesView(),
      binding: AppealPreferencesBinding(),
    ),
    GetPage(
      name: _Paths.DONATION_PREFERENCES,
      page: () => const DonationPreferencesView(),
      binding: DonationPreferencesBinding(),
    ),
    GetPage(
      name: _Paths.SPECIFY_AMOUNT,
      page: () => const SpecifyAmountView(),
      binding: SpecifyAmountBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_NAVIGATION,
      page: () => const MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () => const NewsDetailView(),
      binding: NewsDetailBinding(),
    ),
    GetPage(
      name: _Paths.MY_DONATIONS,
      page: () => const MyDonationsView(),
      binding: MyDonationsBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE_APPEALS,
      page: () => const FavoriteAppealsView(),
      binding: FavoriteAppealsBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_ADHOC_DONATION,
      page: () => const MakeAdhocDonationView(),
      binding: MakeAdhocDonationBinding(),
    ),
    GetPage(
      name: _Paths.MY_SPENDING_ACCOUNT,
      page: () => const MySpendingAccountView(),
      binding: MySpendingAccountBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_DONATION_PREFERENCES,
      page: () => const ProfileDonationPreferencesView(),
      binding: ProfileDonationPreferencesBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_APPEAL_PREFERENCES,
      page: () => const ProfileAppealPreferencesView(),
      binding: ProfileAppealPreferencesBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_MANAGE_DONATION_CATEGORY,
      page: () => const ProfileManageDonationCategoryView(),
      binding: ProfileManageDonationCategoryBinding(),
    ),
  ];
}
