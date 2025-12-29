import 'package:get/get.dart';
import '../controllers/profile_donation_preferences_controller.dart';

class ProfileDonationPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileDonationPreferencesController>(
        () => ProfileDonationPreferencesController());
  }
}

