import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/core/constants/app_constants.dart';
import 'package:help_crowd/app/routes/app_pages.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../data/models/appeal_model.dart';
import '../controllers/favorite_appeals_controller.dart';

class FavoriteAppealsView extends GetView<FavoriteAppealsController> {
  const FavoriteAppealsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),

            InkWell(
              onTap: () => Get.toNamed(Routes.MAKE_ADHOC_DONATION),
              child: _buildIntroText(),
            ),
            Expanded(child: _buildAppealsList()),
            _buildFollowButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
      title: Text(
        'FAVOURITE APPEALS',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Text(
        'Keep up to date with your favourite charities with the latest news',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAppealsList() {
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
        itemCount: controller.appeals.length,
        separatorBuilder: (context, index) =>
            const SizedBox(height: AppDimensions.paddingS),
        itemBuilder: (context, index) {
          final appeal = controller.appeals[index];
          return _buildAppealItem(appeal);
        },
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
              final isFavourite = controller.appeals
                  .firstWhere((a) => a.id == appeal.id)
                  .isFavourite;
              return isFavourite
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

  Widget _buildFollowButton() {
    return SafeArea(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: AppButton(
            icon: SizedBox(width: 0),
            suffixIcon: SizedBox(width: 0),
            text: 'Follow selected (${controller.selectedCount})',
            onPressed: controller.selectedCount > 0
                ? controller.onFollowSelected
                : null,
            variant: ButtonVariant.primary,
          ),
        ),
      ),
    );
  }
}
