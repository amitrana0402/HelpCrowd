import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/signup_controller.dart';
import '../widgets/signup_base_scaffold.dart';

class SignupStep2View extends GetView<SignupController> {
  const SignupStep2View({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBaseScaffold(
      title: "What's your email address?",
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
                    "What's your email address?",
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppDimensions.paddingXL),

                  // Email Input Field
                  CustomTextField(
                    hint: 'Email address',
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    showBorder: false,
                    textColor: AppColors.emailText,
                    onEditingComplete: controller.onContinue,
                    validator: (value) {
                      controller.validateStep2();
                      return controller.emailError.value.isEmpty
                          ? null
                          : controller.emailError.value;
                    },
                  ),

                  Obx(
                    () => controller.emailError.value.isNotEmpty
                        ? Padding(
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
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            // Continue Button
            Obx(
              () => AppButton(
                text: 'Continue',
                onPressed:
                    controller.isStep2Valid.value && !controller.isLoading.value
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
