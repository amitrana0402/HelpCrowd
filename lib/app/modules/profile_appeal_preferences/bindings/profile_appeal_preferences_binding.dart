import 'package:get/get.dart';
import '../controllers/profile_appeal_preferences_controller.dart';

class ProfileAppealPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileAppealPreferencesController>(
        () => ProfileAppealPreferencesController());
  }
}

