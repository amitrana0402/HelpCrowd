import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../data/models/appeal_model.dart';
import '../controllers/appeal_preferences_controller.dart';

class AppealPreferencesView extends GetView<AppealPreferencesController> {
  const AppealPreferencesView({super.key});

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
                          'Appeal Preferences',
                          style: AppTextStyles.h2,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppDimensions.paddingM),

                        // Subtitle
                        Text(
                          'Choose the appeals you want to donate from your everyday transactions.',
                          style: AppTextStyles.subtitle.copyWith(
                            color: AppColors.textDark,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppDimensions.paddingXL),
                      ],
                    ),
                  ),

                  // Appeals List
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingL,
                        ),
                        itemCount: controller.appeals.length,
                        itemBuilder: (context, index) {
                          final appeal = controller.appeals[index];
                          return _buildAppealItem(appeal);
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

  Widget _buildAppealItem(AppealModel appeal) {
    return InkWell(
      onTap: () => controller.toggleAppealSelection(appeal.id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
              child: Image.network(
                appeal.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 60,
                  height: 60,
                  color: AppColors.lightGrey,
                  child: const Icon(
                    Icons.image,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Title
            Expanded(
              child: Text(
                appeal.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const SizedBox(width: AppDimensions.paddingM),

            // Selection Indicator
            Obx(() {
              final isSelected = controller.appeals
                  .firstWhere((a) => a.id == appeal.id)
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

  Widget _buildProgressIndicator() {
    return Container(
      height: 2,
      color: AppColors.inputBorder,
      child: Row(
        children: List.generate(11, (index) {
          final stepNumber = index + 1;
          final isCompleted = stepNumber <= 7;
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
