import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../data/models/appeal_model.dart';
import '../controllers/profile_appeal_preferences_controller.dart';

class ProfileAppealPreferencesView
    extends GetView<ProfileAppealPreferencesController> {
  const ProfileAppealPreferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Instructional Text
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Text(
                'Select the appeals that you want to make donations to',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
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

            // Save Changes Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
        'APPEAL PREFERENCES',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17,
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
}
