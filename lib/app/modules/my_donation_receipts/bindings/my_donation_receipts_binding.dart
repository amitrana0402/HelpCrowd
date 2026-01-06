import 'package:get/get.dart';
import '../controllers/my_donation_receipts_controller.dart';

class MyDonationReceiptsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyDonationReceiptsController>(
      () => MyDonationReceiptsController(),
    );
  }
}

