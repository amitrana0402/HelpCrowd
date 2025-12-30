import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../widgets/buttons/app_button.dart';
import '../controllers/signup_controller.dart';
import '../widgets/signup_base_scaffold.dart';

class SignupStep5View extends GetView<SignupController> {
  const SignupStep5View({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupBaseScaffold(
      title: 'Enter Verification Code',
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
                    'Enter Verification Code',
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppDimensions.paddingXL),

                  // OTP Input Field (Masked)
                  _buildOtpInput(),

                  Obx(
                    () => controller.otpError.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: AppDimensions.paddingS,
                            ),
                            child: Text(
                              controller.otpError.value,
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
            // Resend Code Link
            Obx(
              () => Center(
                child: GestureDetector(
                  onTap:
                      controller.canResendOtp.value &&
                          !controller.isLoading.value
                      ? controller.onResendOtp
                      : null,
                  child: Text(
                    'Resend Code',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color:
                          controller.canResendOtp.value &&
                              !controller.isLoading.value
                          ? AppColors.textDark
                          : AppColors.textDark.withOpacity(0.5),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Verify Button
            Obx(
              () => AppButton(
                text: 'Verify',
                onPressed:
                    controller.isStep4Valid.value && !controller.isLoading.value
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

  Widget _buildOtpInput() {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: TextField(
        controller: controller.otpController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 6,
        obscureText: true,
        obscuringCharacter: '●',
        style: AppTextStyles.h2.copyWith(
          color: AppColors.emailText,
          letterSpacing: 8,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: '●●●●●●',
          hintStyle: AppTextStyles.h2.copyWith(
            color: AppColors.textSecondary.withOpacity(0.3),
            letterSpacing: 8,
          ),
        ),
        onChanged: (value) {
          controller.validateStep4();
        },
      ),
    );
  }
}
