import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/signup_controller.dart';

class SignupBaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onBack;

  const SignupBaseScaffold({
    super.key,
    required this.title,
    required this.body,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupController>();
    
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
          onPressed: onBack ?? controller.onBack,
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
            Obx(() => _buildProgressIndicator(controller)),
            Divider(color: AppColors.inputBorder, height: 1),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(SignupController controller) {
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
}

