import 'package:get/get.dart';
import '../controllers/make_adhoc_donation_controller.dart';

class MakeAdhocDonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakeAdhocDonationController>(
      () => MakeAdhocDonationController(),
    );
  }
}
