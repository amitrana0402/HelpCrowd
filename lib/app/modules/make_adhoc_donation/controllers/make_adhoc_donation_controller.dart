import 'package:get/get.dart';
import '../../../data/models/appeal_model.dart';
import '../../../routes/app_pages.dart';

class MakeAdhocDonationController extends GetxController {
  final donationAmount = 15.00.obs;
  final selectedAppeal = AppealModel(
    id: '1',
    title: 'HELPCROWD',
    imageUrl: '',
    isSelected: true,
  ).obs;
  final isRecurring = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onBackTap() {
    Get.back();
  }

  void onEditAppealTap() {
    // TODO: Navigate to appeal selection
    Get.toNamed(Routes.FAVORITE_APPEALS);
  }

  void onRecurringToggle(bool value) {
    isRecurring.value = value;
  }

  void onSettingsTap() {
    // TODO: Navigate to settings
  }

  void onConfirmDonation() {
    // TODO: Implement donation confirmation
    Get.snackbar(
      'Success',
      'Donation confirmed successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }
}

