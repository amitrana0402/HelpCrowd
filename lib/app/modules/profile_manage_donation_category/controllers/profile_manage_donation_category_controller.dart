import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/donation_category_model.dart';
import '../../../core/theme/app_colors.dart';

class ProfileManageDonationCategoryController extends GetxController {
  // List of donation categories
  final categories = <DonationCategoryModel>[
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
  ].obs;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
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

  void onBackTap() {
    Get.back();
  }

  void onSave() {
    // Save selected categories
    // TODO: Implement API call to save preferences
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      Get.snackbar(
        'Success',
        'Categories saved successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: AppColors.white,
      );
      Get.back();
    });
  }
}
