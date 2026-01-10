import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/donation_category_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/storage_keys.dart';

class ProfileManageDonationCategoryController extends GetxController {
  // Services
  final ApiService _apiService = Get.find<ApiService>();
  final GetStorage _storage = GetStorage();

  // List of donation categories
  final categories = <DonationCategoryModel>[].obs;

  // Loading state
  final isLoading = false.obs;

  // Error message
  final errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  // Load categories from API
  Future<void> _loadCategories() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Get auth token
      final authToken = _storage.read<String>(StorageKeys.userToken);

      // Make API call
      final response = await _apiService.get(
        ApiConstants.categoryPreferences,
        authToken: authToken,
        includeCsrf: true,
      );

      // Parse response
      if (response['data'] != null) {
        final List<dynamic> categoriesData = response['data'] as List<dynamic>;
        categories.value = categoriesData
            .map(
              (json) =>
                  DonationCategoryModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    } catch (e) {
      // Handle error
      errorMessage.value = 'Failed to load categories: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle selection for a category
  // Toggle selection for a category
  void toggleCategorySelection(int categoryId) {
    // specific logic for 'Select All' (id == 1)
    if (categoryId == 0) {
      final index = categories.indexWhere((c) => c.id == 0);
      if (index != -1) {
        // Toggle the 'Select All' item
        final newState = !categories[index].isPreferred;
        categories[index] = categories[index].copyWith(isPreferred: newState);

        // Update all other items to match
        for (int i = 0; i < categories.length; i++) {
          if (categories[i].id != 0) {
            categories[i] = categories[i].copyWith(isPreferred: newState);
          }
        }
      }
    } else {
      // Logic for individual items
      final index = categories.indexWhere((c) => c.id == categoryId);
      if (index != -1) {
        categories[index] = categories[index].copyWith(
          isPreferred: !categories[index].isPreferred,
        );

        // Check availability of 'Select All' (id == 1)
        final selectAllIndex = categories.indexWhere((c) => c.id == 0);
        if (selectAllIndex != -1) {
          // Check if all other items are selected
          final allOthersSelected = categories
              .where((c) => c.id != 0)
              .every((c) => c.isPreferred);

          // Update 'Select All' state based on others
          if (categories[selectAllIndex].isPreferred != allOthersSelected) {
            categories[selectAllIndex] = categories[selectAllIndex].copyWith(
              isPreferred: allOthersSelected,
            );
          }
        }
      }
    }
    categories.refresh();
  }

  // Get selected categories
  List<DonationCategoryModel> get selectedCategories {
    return categories.where((category) => category.isPreferred).toList();
  }

  // Check if any category is selected
  bool get hasSelectedCategories => selectedCategories.isNotEmpty;

  void onBackTap() {
    Get.back();
  }

  Future<void> onSave() async {
    // Get selected category IDs
    final selectedIds = selectedCategories
        .where((category) => category.id != 0)
        .map((category) => category.id)
        .toList();

    // Show loading
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // Get auth token
      final authToken = _storage.read<String>(StorageKeys.userToken);

      // Prepare request body
      final requestBody = {'category_ids': selectedIds};

      // Make API call to save preferences
      final response = await _apiService.post(
        ApiConstants.saveCategoryPreferences,
        requestBody,
        includeCsrf: true,
        authToken: authToken,
      );

      // Handle response
      if (response['message'] != null) {
        Get.snackbar(
          'Success',
          response['message']?.toString() ?? 'Categories saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success,
          colorText: AppColors.white,
        );
        Get.back();
      }
    } catch (e) {
      // Handle error
      errorMessage.value = 'Failed to save categories: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
