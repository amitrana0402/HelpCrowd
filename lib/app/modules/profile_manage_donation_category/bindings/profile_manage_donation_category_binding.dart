import 'package:get/get.dart';
import '../controllers/profile_manage_donation_category_controller.dart';

class ProfileManageDonationCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileManageDonationCategoryController>(
        () => ProfileManageDonationCategoryController());
  }
}

