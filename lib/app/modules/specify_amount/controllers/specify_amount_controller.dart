import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/models/category_amount_model.dart';
import '../../donation_preferences/controllers/donation_preferences_controller.dart';

class SpecifyAmountController extends GetxController {
  // List of categories with amounts (only selected ones)
  final categories = <CategoryAmountModel>[].obs;

  // Loading state
  final isLoading = false.obs;

  // Dialog state
  final selectedAmountIndex = RxInt(-1); // -1 means custom amount
  final customAmountController = TextEditingController();
  final customAmountError = RxString('');
  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  @override
  void onClose() {
    customAmountController.dispose();
    super.onClose();
  }

  // Load categories from donation preferences (only selected ones)
  void _loadCategories() {
    if (Get.isRegistered<DonationPreferencesController>()) {
      final donationController = Get.find<DonationPreferencesController>();
      final selectedCategories = donationController.selectedCategories;

      categories.value = selectedCategories.map((category) {
        // Set default amounts for some categories
        double? defaultAmount;
        if (category.id == '2') {
          // GROCERIES
          defaultAmount = 0.50;
        } else if (category.id == '4') {
          // RESTAURANT & DINING
          defaultAmount = 10.00;
        }

        return CategoryAmountModel(
          id: category.id.toString(),
          title: category.title,
          icon: category.icon,
          amount: defaultAmount,
        );
      }).toList();
    }
  }

  // Open edit dialog for a category
  void openEditDialog(String categoryId, BuildContext context) {
    final category = categories.firstWhere((c) => c.id == categoryId);

    // Reset dialog state
    selectedAmountIndex.value = -1;
    currentPage.value = 0;
    customAmountController.clear();
    customAmountError.value = '';

    // Pre-fill custom amount if category has an amount
    if (category.amount != null) {
      customAmountController.text = category.amount!.toStringAsFixed(2);
    }

    showDialog(
      context: context,
      builder: (context) => _buildEditDialog(categoryId, category, context),
    );
  }

  Widget _buildEditDialog(
    String categoryId,
    CategoryAmountModel category,
    BuildContext context,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: _EditAmountDialogContent(
        categoryId: categoryId,
        category: category,
        controller: this,
      ),
    );
  }

  Widget buildAmountSlideItem(int index, double amount) {
    return Obx(() {
      final isSelected = currentPage.value == index;
      final scale = isSelected
          ? 1.0
          : 0.6; // Selected: 100%, Others: 80% (20% smaller)

      return Center(
        child: Transform.scale(
          scale: scale,
          child: Container(
            width: 120,
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryBlue.withOpacity(0.1)
                  : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.inputBorder,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.attach_money,
                  color: isSelected
                      ? AppColors.primaryBlue
                      : AppColors.textSecondary,
                  size: 40,
                ),
                const SizedBox(height: AppDimensions.paddingXS),
                Text(
                  '\$${amount.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void saveAmount(String categoryId) {
    double? amountToSave;

    // Check if user entered custom amount
    final customAmountText = customAmountController.text.trim();
    if (customAmountText.isNotEmpty) {
      // Use custom amount
      final parsedAmount = double.tryParse(customAmountText);
      if (parsedAmount == null || parsedAmount <= 0) {
        customAmountError.value = 'Please enter a valid amount';
        return;
      }
      amountToSave = parsedAmount;
    } else if (selectedAmountIndex.value >= 0) {
      // Use selected preset amount from slider
      final presetAmounts = [0.50, 1.00, 2.00];
      amountToSave = presetAmounts[selectedAmountIndex.value];
    } else {
      customAmountError.value = 'Please select or enter an amount';
      return;
    }

    // Update category amount
    final index = categories.indexWhere((c) => c.id == categoryId);
    if (index != -1) {
      categories[index] = categories[index].copyWith(amount: amountToSave);
    }

    // Close dialog
    Get.back();
  }

  // Skip this step
  void onSkip() {
    // Navigate to next step (step 10)
    // TODO: Update when step 10 is implemented
    Get.back();
  }

  // Continue to next step
  void onContinue() {
    // Save amounts
    // TODO: Implement API call to save amounts
    // Navigate to next step (step 10)
    // TODO: Update when step 10 is implemented
    Get.back();
  }
}

// Separate StatefulWidget to manage PageController lifecycle
class _EditAmountDialogContent extends StatefulWidget {
  final String categoryId;
  final CategoryAmountModel category;
  final SpecifyAmountController controller;

  const _EditAmountDialogContent({
    required this.categoryId,
    required this.category,
    required this.controller,
  });

  @override
  State<_EditAmountDialogContent> createState() =>
      _EditAmountDialogContentState();
}

class _EditAmountDialogContentState extends State<_EditAmountDialogContent> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.5, // Show 80% of current item, 10% of left and right
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            'Select Amount',
            style: AppTextStyles.h3,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppDimensions.paddingXL),

          // Amount Selection Slider (PageView)
          SizedBox(
            height: 120,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                widget.controller.currentPage.value = index;
                widget.controller.selectedAmountIndex.value = index;
                widget.controller.customAmountController.clear();
                widget.controller.customAmountError.value = '';
              },
              itemCount: 3,
              padEnds: true, // Enable padding to center items properly
              itemBuilder: (context, index) {
                final amounts = [0.50, 1.00, 2.00];
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: widget.controller.buildAmountSlideItem(
                      index,
                      amounts[index],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppDimensions.paddingM),

          // Pagination Dots
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.controller.currentPage.value == index
                        ? AppColors.primaryBlue
                        : AppColors.lightGrey,
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: AppDimensions.paddingXL),

          // Custom Amount Text
          Text(
            'or specify your own',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppDimensions.paddingM),

          // Custom Amount Input
          TextFormField(
            controller: widget.controller.customAmountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              prefixText: '\$',
              hintText: '0.00',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(
                  color: AppColors.primaryBlue,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
                vertical: AppDimensions.paddingM,
              ),
            ),
            style: AppTextStyles.bodyMedium,
            onChanged: (value) {
              widget.controller.selectedAmountIndex.value =
                  -1; // Reset to custom
              widget.controller.customAmountError.value = '';
            },
          ),

          Obx(
            () => widget.controller.customAmountError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: AppDimensions.paddingS),
                    child: Text(
                      widget.controller.customAmountError.value,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: AppDimensions.paddingXL),

          // Save Changes Button
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeightM,
            child: ElevatedButton(
              onPressed: () => widget.controller.saveAmount(widget.categoryId),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: AppColors.buttonTextPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Save Changes',
                style: AppTextStyles.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const SizedBox(height: AppDimensions.paddingS),

          // Cancel Button
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
