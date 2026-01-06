import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../controllers/transactions_controller.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/models/donation_model.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedTabIndex.value,
                children: [_buildTransactionsTab(), _buildDonationsTab()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'MY ACCOUNT',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: controller.onFilterTap,
          child: Text(
            'Filter',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Obx(
      () => Container(
        color: AppColors.backgroundLight,
        child: Row(
          children: [
            Expanded(
              child: _buildTabItem(
                'TRANSACTIONS',
                0,
                controller.selectedTabIndex.value == 0,
                showDot: true,
              ),
            ),
            Expanded(
              child: _buildTabItem(
                'DONATIONS',
                1,
                controller.selectedTabIndex.value == 1,
                showDot: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(
    String label,
    int index,
    bool isSelected, {
    required bool showDot,
  }) {
    return InkWell(
      onTap: () => controller.onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primaryBlue : AppColors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              label,
              style: isSelected
                  ? AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    )
                  : AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
            ),
            if (showDot && !isSelected) ...[
              const SizedBox(width: AppDimensions.paddingXS),
              Positioned(
                right: 10,
                top: 0,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTransactionSummaryCard(),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Text(
              'LATEST TRANSACTIONS',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          _buildTransactionList(),
        ],
      ),
    );
  }

  Widget _buildDonationsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDonationSummaryCard(),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Text(
              'LATEST DONATIONS',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          _buildDonationList(),
        ],
      ),
    );
  }

  Widget _buildTransactionSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingL),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.transactionHeader),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                _formatCurrency(controller.donatedThisMonth.value),
                textAlign: TextAlign.center,
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            Text(
              'DONATED THIS MONTH',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    _formatCurrency(controller.spentThisMonth.value),
                    style: AppTextStyles.h2.copyWith(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 20),
                Text(
                  'SPENT THIS MONTH',
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingL),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.donationHeader),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                _formatCurrency(controller.donationsFor2025.value),
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            Text(
              'DONATIONS FOR 2025',
              style: AppTextStyles.h2.copyWith(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Obx(
              () => Text(
                '\$${controller.taxSaving.value.toStringAsFixed(2)} APPROX. TAX SAVING',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingXS),
            Obx(
              () => Text(
                '(based on ${controller.taxRate.value}% Tax Rate)',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.transactions.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.lightGrey, height: 1),
        itemBuilder: (context, index) {
          final transaction = controller.transactions[index];
          return _buildTransactionItem(transaction);
        },
      ),
    );
  }

  Widget _buildTransactionItem(TransactionModel transaction) {
    final iconColor = controller.getIconColor(transaction.iconColor);
    final iconData = controller.getIconData(transaction.iconType);

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(iconData, color: iconColor, size: AppDimensions.iconM),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXS),
                Text(
                  transaction.date,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${transaction.amount.abs().toStringAsFixed(2)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXS),
              Text(
                '+\$${transaction.donationAmount.toStringAsFixed(2)}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDonationList() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.donations.length,
        separatorBuilder: (context, index) =>
            const Divider(color: AppColors.lightGrey, height: 1),
        itemBuilder: (context, index) {
          final donation = controller.donations[index];
          return _buildDonationItem(donation);
        },
      ),
    );
  }

  Widget _buildDonationItem(DonationModel donation) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppImages.topLogo, height: 30),
          const SizedBox(width: AppDimensions.paddingS),
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

  String _formatCurrency(double amount) {
    // Format with commas for thousands
    final parts = amount.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    String formatted = '';
    for (int i = integerPart.length - 1; i >= 0; i--) {
      if ((integerPart.length - 1 - i) % 3 == 0 && i < integerPart.length - 1) {
        formatted = ',$formatted';
      }
      formatted = integerPart[i] + formatted;
    }

    return '\$$formatted.$decimalPart';
  }
}
