import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    // Use Get.put to persist controller across navigation
    if (!Get.isRegistered<SignupController>()) {
      Get.put(SignupController(), permanent: true);
    }
  }
}
