import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../data/models/category_amount_model.dart';
import '../controllers/specify_amount_controller.dart';

class SpecifyAmountView extends GetView<SpecifyAmountController> {
  const SpecifyAmountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Image.asset(
          AppImages.topLogo,
          height: AppDimensions.logoSizeS,
          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        ),
        actions: [
          TextButton(
            onPressed: controller.onSkip,
            child: Text(
              'Skip',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            _buildProgressIndicator(),
            Divider(color: AppColors.inputBorder, height: 1),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: AppDimensions.paddingM),

                        // Title
                        Text(
                          'Specify Amount',
                          style: AppTextStyles.h2,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppDimensions.paddingM),

                        // Subtitle
                        Text(
                          'Select the amount to be collected every time you make a transaction from your chosen categories.',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.textDark,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppDimensions.paddingXL),
                      ],
                    ),
                  ),

                  // Categories List
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingL,
                        ),
                        itemCount: controller.categories.length,
                        itemBuilder: (context, index) {
                          final category = controller.categories[index];
                          return _buildCategoryItem(category, context);
                        },
                      ),
                    ),
                  ),

                  // Continue Button
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Obx(
                      () => AppButton(
                        text: 'Continue',
                        onPressed: !controller.isLoading.value
                            ? controller.onContinue
                            : null,
                        variant: ButtonVariant.primary,
                        isLoading: controller.isLoading.value,
                        icon: SizedBox(width: 33, height: 33),
                        suffixIcon: Container(
                          width: 33,
                          height: 33,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
    CategoryAmountModel category,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.inputBorder, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Icon
          Image.network(
            ApiConstants.imageBaseUrl + category.icon,
            width: 24,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),

          const SizedBox(width: AppDimensions.paddingM),

          // Title and Amount
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (category.amount != null) ...[
                  const SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    category.formattedAmount,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: AppDimensions.paddingM),

          // Edit Icon
          IconButton(
            onPressed: () => controller.openEditDialog(category.id, context),
            icon: const Icon(Icons.edit, color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 2,
      color: AppColors.inputBorder,
      child: Row(
        children: List.generate(11, (index) {
          final stepNumber = index + 1;
          final isCompleted = stepNumber <= 9;
          return Expanded(
            child: Container(
              color: isCompleted
                  ? AppColors.primaryBlue
                  : AppColors.inputBorder,
            ),
          );
        }),
      ),
    );
  }
}
