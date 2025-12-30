import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/signup_controller.dart';
import '../widgets/signup_base_scaffold.dart';

class SignupStep3View extends GetView<SignupController> {
  const SignupStep3View({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBaseScaffold(
      title: "What's your mobile number?",
      step: SignupController.step3,
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
                    "What's your mobile number?",
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppDimensions.paddingXL),

                  // Mobile Number Input with Country Code
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Country Code
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(
                            top: AppDimensions.paddingM,
                            right: AppDimensions.paddingS,
                          ),
                          child: Text(
                            controller.countryCode.value,
                            style: AppTextStyles.textFieldText.copyWith(
                              color: AppColors.emailText,
                            ),
                          ),
                        ),
                      ),
                      // Mobile Number Field
                      SizedBox(
                        width: 200,
                        child: CustomTextField(
                          hint: '412 345 678',
                          controller: controller.mobileNumberController,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          showBorder: false,
                          textColor: AppColors.emailText,
                          onEditingComplete: () =>
                              controller.onContinue(SignupController.step3),
                          validator: (value) {
                            controller.validateStep3();
                            return controller.mobileNumberError.value.isEmpty
                                ? null
                                : controller.mobileNumberError.value;
                          },
                        ),
                      ),
                    ],
                  ),

                  Obx(
                    () => controller.mobileNumberError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimensions.paddingS,
                            ),
                            child: Text(
                              controller.mobileNumberError.value,
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
            // Info Text
            Text(
              'By continuing, you will receive a SMS with a 6-digit code. Carrier charges may apply.',
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: AppDimensions.paddingM),

            // Continue Button
            Obx(
              () => AppButton(
                text: 'Continue',
                onPressed:
                    controller.isStep3Valid.value && !controller.isLoading.value
                    ? () => controller.onContinue(SignupController.step3)
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
