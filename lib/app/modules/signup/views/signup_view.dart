import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../../../widgets/inputs/custom_text_field.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

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
          onPressed: controller.onBack,
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
            // Progress Indicator
            Obx(() => _buildProgressIndicator()),
            Divider(color: AppColors.inputBorder, height: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppDimensions.paddingXL),

                    // Dynamic Heading based on step
                    Obx(() => _buildHeading()),

                    const SizedBox(height: AppDimensions.paddingXL),

                    // Dynamic Step Content
                    Obx(() => _buildStepContent()),

                    const Spacer(),

                    // OTP Sent Text (for step 3)
                    Obx(() => _buildOtpSentText()),

                    // Continue Button
                    Obx(
                      () => AppButton(
                        text: 'Continue',
                        onPressed:
                            controller.isCurrentStepValid &&
                                !controller.isLoading.value
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

                    const SizedBox(height: AppDimensions.paddingL),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      height: 2,
      color: AppColors.inputBorder,
      child: Row(
        children: List.generate(SignupController.totalSteps, (index) {
          final stepNumber = index + 1;
          final isCompleted = stepNumber <= controller.currentStep.value;
          return Expanded(
            child: Container(
              color: isCompleted
                  ? AppColors.primaryBlue
                  : AppColors.inputBorder,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeading() {
    switch (controller.currentStep.value) {
      case 1:
        return Text(
          "Let's get started",
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        );
      case 2:
        return Text(
          "What's your email address?",
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        );
      case 3:
        return Text(
          "What's your mobile number?",
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        );
      default:
        return Text(
          "Let's get started",
          style: AppTextStyles.h2,
          textAlign: TextAlign.center,
        );
    }
  }

  Widget _buildStepContent() {
    switch (controller.currentStep.value) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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

        if (controller.firstNameError.value.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimensions.paddingS,
            ),
            child: Text(
              controller.firstNameError.value,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.error),
            ),
          ),

        const SizedBox(height: AppDimensions.paddingXL),

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

        if (controller.lastNameError.value.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimensions.paddingS,
            ),
            child: Text(
              controller.lastNameError.value,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.error),
            ),
          ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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

        if (controller.emailError.value.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimensions.paddingS,
            ),
            child: Text(
              controller.emailError.value,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.error),
            ),
          ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mobile Number Input with Country Code
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Code
            Padding(
              padding: const EdgeInsets.only(
                top: AppDimensions.paddingM,
                right: AppDimensions.paddingS,
              ),
              child: Text(
                controller.countryCode.value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.emailText,
                ),
              ),
            ),
            // Mobile Number Field
            Expanded(
              child: CustomTextField(
                hint: '412 345 678',
                controller: controller.mobileNumberController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                showBorder: false,
                textColor: AppColors.emailText,
                onEditingComplete: controller.onContinue,
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

        if (controller.mobileNumberError.value.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimensions.paddingS,
            ),
            child: Text(
              controller.mobileNumberError.value,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(color: AppColors.error),
            ),
          ),

        const SizedBox(height: AppDimensions.paddingM),

        // Info Text
        Text(
          'By continuing, you will receive a SMS with a 6-digit code. Carrier charges may apply.',
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpSentText() {
    if (controller.currentStep.value == 3 && controller.otpSent.value) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
        child: Text(
          'OTP sent',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryBlue,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
