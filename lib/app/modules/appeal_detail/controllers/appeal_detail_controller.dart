import 'package:get/get.dart';
import '../../../data/models/latest_appeals_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/dialogs/donation_control_dialog.dart';

class AppealDetailController extends GetxController {
  final LatestAppealsModel? appeal = Get.arguments as LatestAppealsModel?;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (appeal == null) {
      // If no appeal passed, go back
      Get.back();
    }
  }

  void onBackTap() {
    Get.back();
  }

  void onShareTap(String platform) {
    // TODO: Implement share functionality
    // Platform can be: 'facebook', 'twitter', 'instagram', 'more'
  }

  void onDonateTap() {
    // Show donation control dialog
    Get.dialog(
      DonationControlDialog(
        onManageDonation: onManageDonation,
        onMaybeLater: onMaybeLater,
      ),
      barrierDismissible: true,
      barrierColor: AppColors.black.withOpacity(0.5),
    );
  }

  void onManageDonation() {
    Get.back(); // Close dialog
    // TODO: Navigate to manage donation screen
  }

  void onMaybeLater() {
    Get.back(); // Close dialog
  }

  String get fullContent {
    if (appeal?.description != null && appeal!.description!.isNotEmpty) {
      return appeal!.description!;
    }
    // Default content if not provided
    return appeal?.summary ?? '';
  }

  String? get formattedDate {
    return appeal?.formattedDate;
  }
}

