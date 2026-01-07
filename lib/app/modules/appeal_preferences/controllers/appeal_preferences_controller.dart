import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/appeal_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/storage_keys.dart';
import '../../signup/controllers/signup_controller.dart';

class AppealPreferencesController extends GetxController {
  // Services
  final ApiService _apiService = Get.find<ApiService>();
  final GetStorage _storage = GetStorage();

  // List of appeals
  final appeals = <AppealModel>[].obs;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAppeals();
  }

  // Load appeals from API
  Future<void> _loadAppeals() async {
    isLoading.value = true;
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
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to load appeals: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle selection for an appeal
  void toggleAppealSelection(int appealId) {
    final index = appeals.indexWhere((appeal) => appeal.id == appealId);
    if (index != -1) {
      appeals[index] = appeals[index].copyWith(
        isSelected: !appeals[index].isSelected,
      );
    }
  }

  // Get selected appeals
  List<AppealModel> get selectedAppeals {
    return appeals.where((appeal) => appeal.isSelected).toList();
  }

  // Check if any appeal is selected
  bool get hasSelectedAppeals => selectedAppeals.isNotEmpty;

  // Skip this step
  void onSkip() {
    // Update signup step to 8
    if (Get.isRegistered<SignupController>()) {
      Get.find<SignupController>().updateStepTo8();
    }
    // Navigate to Donation Preferences (step 8)
    Get.toNamed(Routes.DONATION_PREFERENCES);
  }

  // Continue to next step
  Future<void> onContinue() async {
    // Get selected appeal IDs
    final selectedIds = selectedAppeals.map((appeal) => appeal.id).toList();

    // Show loading
    isLoading.value = true;

    try {
      // Get auth token
      final authToken = _storage.read<String>(StorageKeys.userToken);

      // Prepare request body
      final requestBody = {'appeal_ids': selectedIds};

      // Make API call to save preferences
      final response = await _apiService.post(
        ApiConstants.saveAppealPreferences,
        requestBody,
        includeCsrf: true,
        authToken: authToken,
      );

      // Handle response
      if (response['message'] != null) {
        // Success - update signup step to 8
        if (Get.isRegistered<SignupController>()) {
          Get.find<SignupController>().updateStepTo8();
        }
        // Navigate to Donation Preferences (step 8)
        Get.toNamed(Routes.DONATION_PREFERENCES);
      }
    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to save preferences: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
