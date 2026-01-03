import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/signup_controller.dart';
import '../widgets/signup_base_scaffold.dart';

class SignupStep6View extends GetView<SignupController> {
  const SignupStep6View({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBaseScaffold(
      title: 'Set Username',
      step: SignupController.step6,
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
                    'Welcome ${controller.firstNameController.text}',
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Instructional Text
                  Text(
                    'Give yourself a new identity by creating a username',

                    style: AppTextStyles.subtitle.copyWith(
                      color: AppColors.textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppDimensions.paddingXL),

                  // Username Input Field
                  CustomTextField(
                    hint: 'Username',
                    controller: controller.usernameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    showBorder: false,
                    textColor: AppColors.emailText,
                    onEditingComplete: () =>
                        controller.onContinue(SignupController.step6),
                    validator: (value) {
                      controller.validateStep6();
                      return controller.usernameError.value.isEmpty
                          ? null
                          : controller.usernameError.value;
                    },
                  ),

                  // Username availability status
                  Obx(() {
                    // Show loading indicator
                    if (controller.isCheckingUsername.value) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimensions.paddingS,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryBlue,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppDimensions.paddingS),
                            Text(
                              'Checking availability...',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Show success message when available
                    if (controller.isUsernameAvailable.value == true &&
                        controller
                            .usernameAvailabilityMessage
                            .value
                            .isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimensions.paddingS,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: AppDimensions.paddingS),
                            Expanded(
                              child: Text(
                                controller.usernameAvailabilityMessage.value,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Show error message
                    if (controller.usernameError.value.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimensions.paddingS,
                        ),
                        child: Text(
                          controller.usernameError.value,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
            // Informational Text
            Text(
              'Creating a public username allows you to make donations anonymously.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppDimensions.paddingM),

            // Continue Button
            Obx(
              () => AppButton(
                text: 'Continue',
                onPressed:
                    controller.isStep6Valid.value &&
                        !controller.isLoading.value &&
                        !controller.isCheckingUsername.value &&
                        controller.isUsernameAvailable.value == true
                    ? () => controller.onContinue(SignupController.step6)
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
