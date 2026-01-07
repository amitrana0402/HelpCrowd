import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/appeal_model.dart';
import '../../../data/models/profile_donation_category_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/storage_keys.dart';

class ProfileController extends GetxController {
  // Services
  final ApiService _apiService = Get.find<ApiService>();
  final GetStorage _storage = GetStorage();

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

  // All Appeals
  final appeals = <AppealModel>[].obs;

  // Loading state
  final isLoadingAppeals = false.obs;

  // Get favorite appeals (where isFavourite is true)
  List<AppealModel> get favoriteAppeals {
    return appeals.where((appeal) => appeal.isFavourite).toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadAppeals();
  }

  // Load appeals from API
  Future<void> _loadAppeals() async {
    isLoadingAppeals.value = true;
    try {
      // Get auth token
      final authToken = _storage.read<String>(StorageKeys.userToken);

      // Make API call
      final response = await _apiService.get(
        ApiConstants.appealPreferences,
        authToken: authToken,
        includeCsrf: true,
      );

      // Parse response
      if (response['data'] != null) {
        final List<dynamic> appealsData = response['data'] as List<dynamic>;
        appeals.value = appealsData
            .map((json) => AppealModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      // Handle error silently for profile view
      // Error will be shown if user navigates to favorite appeals page
    } finally {
      isLoadingAppeals.value = false;
    }
  }

  // Refresh appeals (called when returning from favorite appeals page)
  Future<void> refreshAppeals() async {
    await _loadAppeals();
  }

  void onMenuTap() {
    // TODO: Show menu options
  }

  void onProfileImageTap() {
    // TODO: Handle profile image edit
  }

  void onAppealTap(int appealId) {
    // TODO: Navigate to appeal detail
  }
}
