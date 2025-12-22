import 'package:get/get.dart';
import '../controllers/appeal_preferences_controller.dart';

class AppealPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppealPreferencesController>(
      () => AppealPreferencesController(),
    );
  }
}

