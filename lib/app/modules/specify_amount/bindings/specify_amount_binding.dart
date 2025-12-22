import 'package:get/get.dart';
import '../controllers/specify_amount_controller.dart';

class SpecifyAmountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecifyAmountController>(
      () => SpecifyAmountController(),
    );
  }
}

