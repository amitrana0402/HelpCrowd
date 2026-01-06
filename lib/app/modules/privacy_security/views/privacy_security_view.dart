import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../controllers/privacy_security_controller.dart';

class PrivacySecurityView extends GetView<PrivacySecurityController> {
  const PrivacySecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: _buildSettingsList(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: controller.onBackTap,
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
      ),
      title: Text(
        'PRIVACY & SECURITY',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsList() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildPinSetting(),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.lightGrey,
        ),
        _buildChangePinSetting(),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.lightGrey,
        ),
        _buildFaceIdSetting(),
      ],
    );
  }

  Widget _buildPinSetting() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PIN',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            _buildCustomSwitch(
              value: controller.isPinEnabled.value,
              onChanged: controller.onPinToggle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePinSetting() {
    return InkWell(
      onTap: controller.onChangePinTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Change PIN',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaceIdSetting() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Face ID',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            _buildCustomSwitch(
              value: controller.isFaceIdEnabled.value,
              onChanged: controller.onFaceIdToggle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 51,
        height: 31,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.5),
          color: value ? AppColors.primaryBlue : AppColors.grey,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 22 : 2,
              top: 2,
              child: Container(
                width: 27,
                height: 27,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

