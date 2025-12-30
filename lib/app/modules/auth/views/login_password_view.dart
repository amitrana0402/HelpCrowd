import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginPasswordView extends GetView<AuthController> {
  const LoginPasswordView({super.key});

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppDimensions.paddingXL),

                    // Heading
                    Text(
                      'Enter password',
                      style: AppTextStyles.h2,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppDimensions.paddingXL),

                    // Password Input Field
                    CustomTextField(
                      hint: 'Password',
                      controller: controller.passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: controller.onLogin,
                      showBorder: false,
                      textColor: AppColors.emailText,
                      validator: (value) {
                        controller.validatePassword();
                        return controller.passwordError.value.isEmpty
                            ? null
                            : controller.passwordError.value;
                      },
                    ),

                    Obx(
                      () => controller.passwordError.value.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: AppDimensions.paddingS,
                              ),
                              child: Text(
                                controller.passwordError.value,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ), // Forgot Password Link
            GestureDetector(
              onTap: controller.onForgotPassword,
              child: Text(
                'Forgot password?',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textDark,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            // Log In Button
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppButton(
                  text: 'Log In',
                  onPressed:
                      controller.isPasswordValid.value &&
                          !controller.isLoading.value
                      ? controller.onLogin
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
    );
  }
}
