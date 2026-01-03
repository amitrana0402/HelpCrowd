import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/donation_category_model.dart';
import '../../../routes/app_pages.dart';
import '../../signup/controllers/signup_controller.dart';

class DonationPreferencesController extends GetxController {
  // List of donation categories
  final categories = <DonationCategoryModel>[].obs;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  // Load dummy categories data
  void _loadCategories() {
    categories.value = [
      DonationCategoryModel(
        id: '1',
        title: 'ALL',
        icon: Icons.home,
        isSelected: false,
      ),
      DonationCategoryModel(
        id: '2',
        title: 'GROCERIES',
        icon: Icons.shopping_bag,
        isSelected: true,
      ),
      DonationCategoryModel(
        id: '3',
        title: 'PETROL & CAR EXPENSES',
        icon: Icons.directions_car,
        isSelected: false,
      ),
      DonationCategoryModel(
        id: '4',
        title: 'RESTAURANT & DINING',
        icon: Icons.restaurant,
        isSelected: true,
      ),
      DonationCategoryModel(
        id: '5',
        title: 'ENTERTAINMENT & RECREATION',
        icon: Icons.theater_comedy,
        isSelected: false,
      ),
      DonationCategoryModel(
        id: '6',
        title: 'PUBLIC TRANSPORT & TAXIS',
        icon: Icons.train,
        isSelected: true,
      ),
      DonationCategoryModel(
        id: '7',
        title: 'TAKE AWAY & FAST FOOD',
        icon: Icons.fastfood,
        isSelected: false,
      ),
      DonationCategoryModel(
        id: '8',
        title: 'TRAVEL',
        icon: Icons.flight,
        isSelected: true,
      ),
    ];
  }

  // Toggle selection for a category
  void toggleCategorySelection(String categoryId) {
    final index = categories.indexWhere(
      (category) => category.id == categoryId,
    );
    if (index != -1) {
      categories[index] = categories[index].copyWith(
        isSelected: !categories[index].isSelected,
      );
    }
  }

  // Get selected categories
  List<DonationCategoryModel> get selectedCategories {
    return categories.where((category) => category.isSelected).toList();
  }

  // Check if any category is selected
  bool get hasSelectedCategories => selectedCategories.isNotEmpty;

  // Skip this step
  void onSkip() {
    // Update signup step to 9
    if (Get.isRegistered<SignupController>()) {
      Get.find<SignupController>().updateStepTo9();
    }
    // Navigate to Specify Amount (step 9)
    Get.offAllNamed(Routes.MAIN_NAVIGATION);
  }

  // Continue to next step
  void onContinue() {
    // Save selected categories
    // TODO: Implement API call to save preferences
    // Update signup step to 9
    if (Get.isRegistered<SignupController>()) {
      Get.find<SignupController>().updateStepTo9();
    }
    // Navigate to Specify Amount (step 9)
    Get.toNamed(Routes.SPECIFY_AMOUNT);
  }
}
