import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/settings_menu_item_model.dart';
import '../../../routes/app_pages.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/storage_keys.dart';

class SettingsController extends GetxController {
  final GetStorage _storage = GetStorage();

  final menuItems = <SettingsMenuItemModel>[
    // Account section
    SettingsMenuItemModel(
      id: 'account_details',
      title: 'Account Details',
      isProfileItem: true,
      showDot: true,
    ),
    SettingsMenuItemModel(
      id: 'spending_account',
      title: 'My Spending Account',
      imagePath: AppImages.spending,
      trailingText: 'Ending 1234',
    ),
    SettingsMenuItemModel(
      id: 'funding_account',
      title: 'My Funding Account',
      imagePath: AppImages.spending,
      trailingText: 'Ending 5678',
    ),
    // Donation section
    SettingsMenuItemModel(
      id: 'donation_preferences',
      title: 'Donation Preferences',
      imagePath: AppImages.donation,
    ),
    SettingsMenuItemModel(
      id: 'appeal_preferences',
      title: 'Appeal Preferences',
      imagePath: AppImages.topLogo,
    ),
    SettingsMenuItemModel(
      id: 'scheduled_donations',
      title: 'Scheduled Donations',
      imagePath: AppImages.scheduledDonation,
    ),
    SettingsMenuItemModel(
      id: 'donation_receipts',
      title: 'My Donation Receipts',
      imagePath: AppImages.donationReceipt,
    ),
    SettingsMenuItemModel(
      id: 'rewards',
      title: 'Rewards',
      imagePath: AppImages.rewards,
    ),
    // Other section
    SettingsMenuItemModel(id: 'privacy_security', title: 'Privacy & Security'),
    SettingsMenuItemModel(
      id: 'push_notifications',
      title: 'Push Notifications',
    ),
    SettingsMenuItemModel(id: 'help_center', title: 'Help Center'),
    SettingsMenuItemModel(id: 'report_problem', title: 'Report Problem'),
    SettingsMenuItemModel(id: 'terms_of_use', title: 'Terms of Use'),
    SettingsMenuItemModel(id: 'privacy_policy', title: 'Privacy Policy'),
    SettingsMenuItemModel(id: 'about', title: 'About The HelpCrowd App'),
    SettingsMenuItemModel(id: 'facebook', title: 'Like Us on Facebook'),
    SettingsMenuItemModel(id: 'invite_friends', title: 'Invite Friends'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onMenuItemTap(String itemId) {
    switch (itemId) {
      case 'account_details':
        // TODO: Navigate to account details
        break;
      case 'spending_account':
        Get.toNamed(Routes.MY_SPENDING_ACCOUNT);
        break;
      case 'funding_account':
        // TODO: Navigate to funding account
        break;
      case 'donation_preferences':
        Get.toNamed(Routes.PROFILE_DONATION_PREFERENCES);
        break;
      case 'appeal_preferences':
        Get.toNamed(Routes.PROFILE_APPEAL_PREFERENCES);
        break;
      case 'scheduled_donations':
        // TODO: Navigate to scheduled donations
        break;
      case 'donation_receipts':
        Get.toNamed(Routes.MY_DONATIONS);
        break;
      case 'rewards':
        // TODO: Navigate to rewards
        break;
      case 'privacy_security':
        // TODO: Navigate to privacy & security
        break;
      case 'push_notifications':
        // TODO: Navigate to push notifications
        break;
      case 'help_center':
        // TODO: Navigate to help center
        break;
      case 'report_problem':
        // TODO: Navigate to report problem
        break;
      case 'terms_of_use':
        // TODO: Navigate to terms of use
        break;
      case 'privacy_policy':
        // TODO: Navigate to privacy policy
        break;
      case 'about':
        // TODO: Navigate to about
        break;
      case 'facebook':
        // TODO: Open Facebook
        break;
      case 'invite_friends':
        // TODO: Invite friends
        break;
    }
  }

  Future<void> onLogout() async {
    try {
      // Clear authentication data from storage
      await _storage.remove(StorageKeys.userToken);
      await _storage.remove(StorageKeys.userEmail);
      await _storage.remove(StorageKeys.isLoggedIn);
      await _storage.remove(StorageKeys.userData);

      // Navigate to login screen and clear navigation stack
      Get.offAllNamed(Routes.LOGIN_EMAIL);
    } catch (e) {
      // Handle any errors during logout
      Get.snackbar(
        'Error',
        'An error occurred during logout. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
