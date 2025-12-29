import 'package:get/get.dart';
import '../../../data/models/news_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/dialogs/donation_control_dialog.dart';

class NewsDetailController extends GetxController {
  final NewsModel? news = Get.arguments as NewsModel?;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (news == null) {
      // If no news passed, go back
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
    if (news?.content != null && news!.content!.isNotEmpty) {
      return news!.content!;
    }
    // Default content if not provided
    return '''
${news?.description ?? ''}

Traditional aid can be slow to reach those in need. Our project is piloting innovative cash-transfer programming in partnership with aid groups on the ground.

By using these smart, efficient delivery methods, HelpCrowd is improving access to care for vulnerable communities—faster, and with greater impact.
''';
  }
}

