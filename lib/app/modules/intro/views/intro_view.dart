import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Ripple Effect Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, 0),
                  radius: 1.0,
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.3, 0.6],
                ),
              ),
            ),
          ),

          // Content
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: [
              _buildOnboardingPage(
                "In this digital age, we're finding it\n"
                "harder to give our loose change.\n"
                "HelpCrowd have changed that\n"
                "with the new small change app.",
                AppImages.intro1,
              ),
              _buildOnboardingPage(
                "Choose your transaction category\n"
                "from your desired debit or credit\n"
                "card and select your small\n"
                "donation amount. It's as simple\n"
                "as set and forget.!",
                AppImages.intro2,
              ),
              _buildOnboardingPage(
                "Make one-off donations or\n"
                "schedule weekly donations...\n"
                "Every little bit helps! ",
                AppImages.intro3,
              ),
              _buildOnboardingPage(
                "Even better still, we will track\n"
                "your donations and provide you a\n"
                "tax deduction receipt at the end\n"
                "of the year.",
                AppImages.intro4,
              ),
            ],
          ),

          Positioned(
            bottom: 180,
            left: 0,
            right: 0,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingXS,
                    ),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentPage.value == index
                          ? AppColors.primaryBlue
                          : AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(AppImages.introBottom),
          ),
          // Bottom Section with Pagination and Buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: Get.width,

              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Help Change the World Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppButton(
                      text: 'Help change the world',
                      onPressed: controller.onHelpChangeWorldTap,

                      variant: ButtonVariant.secondary,
                      icon: SizedBox(width: 0, height: 33),
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
                  ),

                  const SizedBox(height: 10),

                  // Login Link
                  GestureDetector(
                    onTap: controller.onLoginTap,
                    child: RichText(
                      text: TextSpan(
                        text: 'Got a profile? ',
                        style: AppTextStyles.bodyMediumLight,
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: AppTextStyles.bodyMediumLight.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),

          Positioned(
            top: 80,
            left: 40,
            child: Image.asset(
              AppImages.introTop,
              height: 56,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),

          // Skip Button
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(String text, String image) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: AppColors.backgroundBlue),
          ),
        ),
        Positioned(
          bottom: 210,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingXL,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLargeLight,
            ),
          ),
        ),
      ],
    );
  }
}
