import 'package:get/get.dart';
import '../controllers/my_spending_account_controller.dart';

class MySpendingAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySpendingAccountController>(() => MySpendingAccountController());
  }
}

