import 'package:get/get.dart';
import '../controllers/donation_preferences_controller.dart';

class DonationPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationPreferencesController>(
      () => DonationPreferencesController(),
    );
  }
}

