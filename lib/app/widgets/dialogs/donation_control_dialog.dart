import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/constants/app_constants.dart';
import '../buttons/app_button.dart';

class DonationControlDialog extends StatelessWidget {
  final VoidCallback? onManageDonation;
  final VoidCallback? onMaybeLater;

  const DonationControlDialog({
    super.key,
    this.onManageDonation,
    this.onMaybeLater,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'CONTROL YOUR DONATIONS',
              style: AppTextStyles.h3.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingL),
            // Piggy Bank Icon
            Image.asset(
              AppImages.controlDonation,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: AppDimensions.paddingL),
            // Body Text
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
              ),
              child: Text(
                'Select how much and when you want to donate based on your transactions.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXL),
            // Manage donation button
            AppButton(
              text: 'Manage donation',
              onPressed: onManageDonation ?? () => Navigator.of(context).pop(),
              variant: ButtonVariant.primary,
              icon: SizedBox(width: 33, height: 33),
              suffixIcon: Container(width: 33, height: 33),
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            // Maybe later text button
            TextButton(
              onPressed: onMaybeLater ?? () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical: AppDimensions.paddingS,
                ),
              ),
              child: Text(
                'Maybe later',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    VoidCallback? onManageDonation,
    VoidCallback? onMaybeLater,
  }) {
    showDialog(
      context: context,
      barrierColor: AppColors.black.withOpacity(0.5),
      barrierDismissible: true,
      builder: (context) => DonationControlDialog(
        onManageDonation: onManageDonation,
        onMaybeLater: onMaybeLater,
      ),
    );
  }
}
