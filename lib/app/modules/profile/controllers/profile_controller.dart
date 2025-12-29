import 'package:get/get.dart';
import '../../../data/models/appeal_model.dart';
import '../../../data/models/profile_donation_category_model.dart';
import '../../../core/theme/app_colors.dart';

class ProfileController extends GetxController {
  // User Profile Data
  final username = 'AMYSTAR1107'.obs;
  final fullName = 'Amy Smith'.obs;
  final totalDonations = 7507.93.obs;
  final memberSince = 'Sep 2018'.obs;
  final profileImageUrl = ''.obs; // Placeholder for profile image

  // Monthly Donation Data
  final monthlyDonation = 10.77.obs;

  // Donation Categories
  final donationCategories = <ProfileDonationCategoryModel>[
    ProfileDonationCategoryModel(
      id: '1',
      name: 'Groceries',
      percentage: 35.0,
      color: AppColors.error, // Red
    ),
    ProfileDonationCategoryModel(
      id: '2',
      name: 'Take Away',
      percentage: 28.0,
      color: AppColors.warning, // Yellow
    ),
    ProfileDonationCategoryModel(
      id: '3',
      name: 'Online',
      percentage: 19.0,
      color: AppColors.success, // Green
    ),
    ProfileDonationCategoryModel(
      id: '4',
      name: 'Travel',
      percentage: 13.0,
      color: AppColors.info, // Blue
    ),
    ProfileDonationCategoryModel(
      id: '5',
      name: 'Other',
      percentage: 5.0,
      color: AppColors.transactionPurple, // Purple
    ),
  ].obs;

  // Favorite Appeals
  final favoriteAppeals = <AppealModel>[
    AppealModel(
      id: '1',
      title: 'Food Distribution',
      imageUrl: '', // Placeholder for hands with bowls image
      isSelected: true,
    ),
    AppealModel(
      id: '2',
      title: 'Health Check',
      imageUrl: '', // Placeholder for health check image
      isSelected: true,
    ),
    AppealModel(
      id: '3',
      title: 'Community Aid',
      imageUrl: '', // Placeholder for community aid image
      isSelected: true,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onMenuTap() {
    // TODO: Show menu options
  }

  void onProfileImageTap() {
    // TODO: Handle profile image edit
  }

  void onAppealTap(String appealId) {
    // TODO: Navigate to appeal detail
  }
}
