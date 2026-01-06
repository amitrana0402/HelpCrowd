import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../controllers/make_adhoc_donation_controller.dart';

class MakeAdhocDonationView extends GetView<MakeAdhocDonationController> {
  const MakeAdhocDonationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppDimensions.paddingXL),
                    _buildQuestionText(),
                    const SizedBox(height: AppDimensions.paddingL),
                    _buildDonationAmount(),
                    const SizedBox(height: AppDimensions.paddingXL),
                    _buildDonationDetailsSection(),
                  ],
                ),
              ),
            ),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
        ),
        onPressed: controller.onBackTap,
      ),
      centerTitle: true,
      title: Text(
        'MAKE ADHOC DONATION',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuestionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Text(
        'How much would you like to contribute today?',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDonationAmount() {
    return Obx(
      () => Text(
        '\$ ${controller.donationAmount.value.toStringAsFixed(2)}',
        style: AppTextStyles.h1.copyWith(
          color: AppColors.black,
          fontSize: 45,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDonationDetailsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'DONATION DETAILS',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Text(
            'What appeal do you want to donate to?',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),
          const SizedBox(height: AppDimensions.paddingM),
          _buildAppealSelection(),
          const SizedBox(height: AppDimensions.paddingM),
          const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),
          const SizedBox(height: AppDimensions.paddingM),
          _buildRecurringDonationSection(),
        ],
      ),
    );
  }

  Widget _buildAppealSelection() {
    return Obx(
      () => InkWell(
        onTap: controller.onEditAppealTap,
        child: Row(
          children: [
            Image.asset(
              AppImages.topLogo,
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Text(
                controller.selectedAppeal.value.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 15,
                ),
              ),
            ),
            const Icon(
              Icons.edit,
              color: AppColors.textSecondary,
              size: AppDimensions.iconM,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecurringDonationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Set as a Recurring Donation',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                fontSize: 15,
              ),
            ),
            Obx(
              () => Switch(
                value: controller.isRecurring.value,
                onChanged: controller.onRecurringToggle,
                activeColor: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingS),
        RichText(
          text: TextSpan(
            style: AppTextStyles.bodySmall.copyWith(),
            children: [
              const TextSpan(
                text:
                    'Your donation will be made on a weekly basis. You can change this from your ',
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: controller.onSettingsTap,
                  child: Text(
                    'Settings',
                    style: AppTextStyles.bodySmall.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: AppButton(
          icon: SizedBox(width: 0),
          suffixIcon: SizedBox(width: 0),
          text: 'Confirm donation',
          onPressed: controller.onConfirmDonation,
          variant: ButtonVariant.primary,
        ),
      ),
    );
  }
}
