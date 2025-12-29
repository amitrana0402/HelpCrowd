import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../controllers/settings_controller.dart';
import '../../../data/models/settings_menu_item_model.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            _buildMenuList(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: AppButton(
                icon: SizedBox(width: 0),
                suffixIcon: SizedBox(width: 0),
                text: 'Log out',
                onPressed: controller.onLogout,
                variant: ButtonVariant.primary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              'Version ${AppConstants.appVersion}',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingL),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'MORE',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: controller.menuItems.length,
        separatorBuilder: (context, index) {
          // Add separators after specific items
          if (index == 0 ||
              index == 2 ||
              index == 7 ||
              index == 9 ||
              index == 13) {
            return Divider(
              color: AppColors.lightGrey.withOpacity(0.4),
              height: 1,
              thickness: 6,
            );
          }
          return Divider(
            color: AppColors.lightGrey.withOpacity(0.4),
            height: 1,
            thickness: 1,
          );
        },
        itemBuilder: (context, index) {
          final item = controller.menuItems[index];
          return _buildMenuItem(item);
        },
      ),
    );
  }

  Widget _buildMenuItem(SettingsMenuItemModel item) {
    return InkWell(
      onTap: () => controller.onMenuItemTap(item.id),
      child: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          children: [
            if (item.isProfileItem)
              _buildProfileAvatar()
            else if (item.imagePath != null)
              _buildIcon(item.imagePath!)
            else
              const SizedBox(width: 0),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Text(
                item.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (item.trailingText != null)
              Padding(
                padding: const EdgeInsets.only(right: AppDimensions.paddingS),
                child: Text(
                  item.trailingText!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightBlue,
                  ),
                ),
              ),
            if (item.showDot)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightGrey,
      ),
      child: const Icon(
        Icons.person,
        color: AppColors.grey,
        size: AppDimensions.iconM,
      ),
    );
  }

  Widget _buildIcon(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(imagePath, width: 26, height: 26, fit: BoxFit.contain),
    );
  }
}
