import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/core/constants/api_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../data/models/category_amount_model.dart';
import '../controllers/profile_donation_preferences_controller.dart';

class ProfileDonationPreferencesView
    extends GetView<ProfileDonationPreferencesController> {
  const ProfileDonationPreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
          onPressed: controller.onBackTap,
        ),
        centerTitle: true,
        title: Text(
          'DONATION PREFERENCES',
          style: AppTextStyles.h3.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Subtitle
                        Text(
                          'Select the amount to be collected every time you make a transaction from your chosen categories.',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.textDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
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

                  // Save Button
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Obx(
                      () => AppButton(
                        text: 'Manage Categories',
                        onPressed: !controller.isLoading.value
                            ? controller.onManageCategoriesTap
                            : null,
                        variant: ButtonVariant.primary,
                        isLoading: controller.isLoading.value,
                        icon: SizedBox(width: 0),
                        suffixIcon: Container(width: 0),
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Image.network(
              ApiConstants.imageBaseUrl + category.icon,
              color: AppColors.primaryBlue,
              height: 28,
            ),
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
}
