import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../widgets/buttons/app_button.dart';
import '../controllers/my_donations_controller.dart';
import '../../../data/models/donation_model.dart';

class MyDonationsView extends GetView<MyDonationsController> {
  const MyDonationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),

            _buildIntroText(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAdhocDonationsSection(),
                    _buildRoundOffDonationsSection(),
                    const SizedBox(height: AppDimensions.paddingXL),
                  ],
                ),
              ),
            ),
            _buildViewInvoiceButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: controller.onBackTap,
        icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.black),
      ),
      title: Text(
        'MY DONATIONS',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Text(
        'These are all of the donations you have contributed on this period.',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAdhocDonationsSection() {
    return Obx(
      () => controller.adhocDonations.isEmpty
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                  ),
                  child: Text(
                    'ADHOC DONATIONS',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingM),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                  ),
                  itemCount: controller.adhocDonations.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimensions.paddingM),
                  itemBuilder: (context, index) {
                    final donation = controller.adhocDonations[index];
                    return _buildDonationItem(donation);
                  },
                ),
                const SizedBox(height: AppDimensions.paddingXL),
              ],
            ),
    );
  }

  Widget _buildRoundOffDonationsSection() {
    return Obx(
      () => controller.roundOffDonations.isEmpty
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                  ),
                  child: Text(
                    'ROUND-OFF DONATIONS',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingM),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingL,
                  ),
                  itemCount: controller.roundOffDonations.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimensions.paddingM),
                  itemBuilder: (context, index) {
                    final donation = controller.roundOffDonations[index];
                    return _buildDonationItem(donation);
                  },
                ),
              ],
            ),
    );
  }

  Widget _buildDonationItem(DonationModel donation) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.topLogo,
            height: 40,
            width: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donation.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXS),
                Text(
                  donation.date,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${donation.amount.toStringAsFixed(2)}',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewInvoiceButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: AppButton(
        text: 'View Invoice',
        onPressed: controller.onViewInvoiceTap,
        variant: ButtonVariant.primary,
        icon: Container(width: 33, height: 33),
        suffixIcon: Container(width: 33, height: 33),
      ),
    );
  }
}
