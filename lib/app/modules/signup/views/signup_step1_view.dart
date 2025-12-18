import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/signup_controller.dart';
import '../widgets/signup_base_scaffold.dart';

class SignupStep1View extends GetView<SignupController> {
  const SignupStep1View({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBaseScaffold(
      title: "Let's get started",
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
                    "Let's get started",
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppDimensions.paddingXL),

                  // First Name Input Field
                  CustomTextField(
                    hint: 'First name',
                    controller: controller.firstNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    showBorder: false,
                    textColor: AppColors.emailText,
                    validator: (value) {
                      controller.validateStep1();
                      return controller.firstNameError.value.isEmpty
                          ? null
                          : controller.firstNameError.value;
                    },
                  ),

                  Obx(
                    () => controller.firstNameError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimensions.paddingS,
                            ),
                            child: Text(
                              controller.firstNameError.value,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  const SizedBox(height: AppDimensions.paddingS),

                  // Last Name Input Field
                  CustomTextField(
                    hint: 'Last name',
                    controller: controller.lastNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    showBorder: false,
                    textColor: AppColors.emailText,
                    onEditingComplete: controller.onContinue,
                    validator: (value) {
                      controller.validateStep1();
                      return controller.lastNameError.value.isEmpty
                          ? null
                          : controller.lastNameError.value;
                    },
                  ),

                  Obx(
                    () => controller.lastNameError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimensions.paddingS,
                            ),
                            child: Text(
                              controller.lastNameError.value,
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
                    controller.isStep1Valid.value && !controller.isLoading.value
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
