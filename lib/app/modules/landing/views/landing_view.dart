import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Column(
        children: [
          // Logo

          // Main Content
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Link Up.\nCustomise.\nCollect.\nDonate.',
                      textAlign: TextAlign.left,
                      style: AppTextStyles.h1Light.copyWith(fontSize: 48),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Subtitle
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Together, we can change the world..',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMediumLight,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingL),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      AppImages.landingDots,
                      height: 300,

                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buttons Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                // Create an account button
                AppButton(
                  text: 'Create an account',
                  onPressed: controller.onCreateAccountTap,
                  variant: ButtonVariant.secondary,
                  icon: Row(
                    children: [
                      SizedBox(width: 6),
                      Image.asset(
                        AppImages.signUpPrefix,
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  suffixIcon: Container(
                    width: 33,
                    height: 33,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.paddingM),

                // Login button
                AppButton(
                  text: 'Login',
                  onPressed: controller.onLoginTap,
                  variant: ButtonVariant.primary,
                  icon: Row(
                    children: [
                      SizedBox(width: 6),
                      Image.asset(AppImages.loginPrefix, width: 26, height: 24),
                    ],
                  ),
                  suffixIcon: Container(
                    width: 33,
                    height: 33,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
