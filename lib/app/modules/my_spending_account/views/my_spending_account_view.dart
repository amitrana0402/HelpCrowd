import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/my_spending_account_controller.dart';

class MySpendingAccountView extends GetView<MySpendingAccountController> {
  const MySpendingAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Divider(
                color: AppColors.lightGrey,
                height: 1,
                thickness: 1,
              ),
              const SizedBox(height: AppDimensions.paddingXL),
              _buildPiggyBankIcon(),
              const SizedBox(height: AppDimensions.paddingL),
              _buildDescriptionText(),
              const SizedBox(height: AppDimensions.paddingXL),
              const Divider(
                color: AppColors.lightGrey,
                height: 1,
                thickness: 1,
              ),
              const SizedBox(height: AppDimensions.paddingL),
              _buildAccountSection(),

              const SizedBox(height: AppDimensions.paddingL),
              const Divider(
                color: AppColors.lightGrey,
                height: 1,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: controller.onBackTap,
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
      ),
      title: Text(
        'MY SPENDING ACCOUNT',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildPiggyBankIcon() {
    return
    // Piggy bank image
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Image.asset(
        AppImages.controlDonation,
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
    // Coins above piggy bank - first coin (entirely dark blue)
  }

  Widget _buildDescriptionText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Text(
        'Track purchases on this account for round-up opportunities.',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAccountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Row(
        children: [
          // Bank logo (yellow diamond shape - Commonwealth Bank)
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(controller.bankLogoColor),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Color(controller.bankLogoColor),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'CBA',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.accountNumber.value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXS),
                Obx(
                  () => Text(
                    controller.bankName.value,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: controller.onEditAccountTap,
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.textSecondary,
              size: AppDimensions.iconM,
            ),
          ),
        ],
      ),
    );
  }
}
