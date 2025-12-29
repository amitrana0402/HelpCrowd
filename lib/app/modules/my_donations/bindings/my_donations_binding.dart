import 'package:get/get.dart';
import '../controllers/my_donations_controller.dart';

class MyDonationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDonationsController>(() => MyDonationsController());
  }
}

