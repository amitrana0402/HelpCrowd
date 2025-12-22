import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LandingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void onCreateAccountTap() {
    // Navigate to signup (future implementation)
    Get.toNamed(Routes.SIGNUP);
  }

  void onLoginTap() {
    Get.toNamed(Routes.LOGIN_EMAIL);
  }
}

