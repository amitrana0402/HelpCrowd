import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginEmailView extends GetView<AuthController> {
  const LoginEmailView({super.key});

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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Divider(color: AppColors.inputBorder, height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: ListView(
                  children: [
                    const SizedBox(height: AppDimensions.paddingXL),

                    // Welcome Heading
                    Text(
                      'Welcome back!',
                      style: AppTextStyles.h2,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppDimensions.paddingM),

                    // Subtitle
                    Text(
                      'Login with your email address',
                      style: AppTextStyles.subtitle,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppDimensions.paddingXL),

                    // Email Input Field
                    CustomTextField(
                      hint: 'Email address',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      showBorder: false,
                      textColor: AppColors.emailText,
                      validator: (value) {
                        controller.validateEmail();
                        return controller.emailError.value.isEmpty
                            ? null
                            : controller.emailError.value;
                      },
                    ),

                    if (controller.emailError.value.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimensions.paddingS,
                        ),
                        child: Text(
                          controller.emailError.value,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),

                    // Signup Link
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.onSignupTap,
              child: Text(
                "Don't have an account?",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textDark,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            // Continue Button
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppButton(
                  text: 'Continue',
                  onPressed: controller.isEmailValid.value
                      ? controller.onEmailContinue
                      : null,
                  variant: ButtonVariant.primary,
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
    );
  }
}
