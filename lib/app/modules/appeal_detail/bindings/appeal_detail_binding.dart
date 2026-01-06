import 'package:get/get.dart';
import '../controllers/appeal_detail_controller.dart';

class AppealDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppealDetailController>(
      () => AppealDetailController(),
    );
  }
}

