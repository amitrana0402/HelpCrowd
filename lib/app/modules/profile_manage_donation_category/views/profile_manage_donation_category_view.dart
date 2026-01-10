import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/core/constants/api_constants.dart';
import 'package:help_crowd/app/core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../data/models/donation_category_model.dart';
import '../controllers/profile_manage_donation_category_controller.dart';

class ProfileManageDonationCategoryView
    extends GetView<ProfileManageDonationCategoryController> {
  const ProfileManageDonationCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),

            // Introductory Text
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Choose the categories you want to donate from your everyday transactions.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Categories List
            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                  ),
                  itemCount: controller.categories.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: AppColors.inputBorder,
                    height: 1,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return _buildCategoryItem(category);
                  },
                ),
              ),
            ),

            // Save Changes Button
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Obx(
                () => AppButton(
                  text: 'Save changes',
                  onPressed: !controller.isLoading.value
                      ? controller.onSave
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
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
        onPressed: controller.onBackTap,
      ),
      centerTitle: true,
      title: Text(
        'MANAGE CATEGORIES',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(DonationCategoryModel category) {
    return InkWell(
      onTap: () => controller.toggleCategorySelection(category.id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
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

            // Title
            Expanded(
              child: Text(
                category.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Selection Indicator
            Obx(() {
              final isSelected = controller.categories
                  .firstWhere((c) => c.id == category.id)
                  .isSelected;
              return isSelected
                  ? Image.asset(AppImages.checked, width: 26)
                  : Padding(
                      padding: const EdgeInsets.all(7),
                      child: Container(
                        width: 13,
                        height: 13,
                        decoration: BoxDecoration(
                          color: AppColors.lightBlue.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
