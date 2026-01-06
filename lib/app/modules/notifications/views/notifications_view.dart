import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/notifications_controller.dart';
import '../../../data/models/activity_model.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),

      body: Column(
        children: [
          const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),
          Expanded(child: _buildActivityList()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'ACTIVITY',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: controller.activities.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),
        itemBuilder: (context, index) {
          final activity = controller.activities[index];
          return _buildActivityItem(activity);
        },
      ),
    );
  }

  Widget _buildActivityItem(ActivityModel activity) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActivityIcon(activity),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.description,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXS),
                Text(
                  activity.timestamp,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityIcon(ActivityModel activity) {
    switch (activity.iconType) {
      case ActivityIconType.image:
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGrey,
          ),
          child: activity.imageUrl != null && activity.imageUrl!.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    activity.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholderIcon(),
                  ),
                )
              : _buildPlaceholderIcon(),
        );
      case ActivityIconType.globe:
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryBlue, width: 2),
          ),
          child: Icon(
            Icons.public_outlined,
            color: AppColors.primaryBlue,
            size: AppDimensions.iconM,
          ),
        );
      case ActivityIconType.australiaMap:
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryBlue, width: 2),
          ),
          child: Image.asset(
            AppImages.topLogo,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
        );
    }
  }

  Widget _buildPlaceholderIcon() {
    return Icon(
      Icons.person_outline,
      color: AppColors.grey,
      size: AppDimensions.iconM,
    );
  }
}
