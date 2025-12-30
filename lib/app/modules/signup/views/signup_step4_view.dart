import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/signup_controller.dart';
import '../widgets/signup_base_scaffold.dart';

class SignupStep4View extends GetView<SignupController> {
  const SignupStep4View({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBaseScaffold(
      title: 'Set your password',
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: AppDimensions.paddingXL),

                  // Heading
                  Text(
                    'Set your password',
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
                    showBorder: false,
                    textColor: AppColors.emailText,
                    onEditingComplete: controller.onContinue,
                    validator: (value) {
                      controller.validateStep5();
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
            // Terms and Conditions Text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                children: [
                  const TextSpan(
                    text: "By tapping 'Create Account', I agree to The MSF's ",
                  ),
                  TextSpan(
                    text: "T&C's",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Navigate to Terms & Conditions
                        Get.snackbar(
                          'Terms & Conditions',
                          'T&C page will be implemented soon.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Navigate to Privacy Policy
                        Get.snackbar(
                          'Privacy Policy',
                          'Privacy Policy page will be implemented soon.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Create Account Button
            Obx(
              () => AppButton(
                text: 'Create Account',
                onPressed:
                    controller.isStep5Valid.value && !controller.isLoading.value
                    ? controller.onContinue
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
          ],
        ),
      ),
    );
  }
}
