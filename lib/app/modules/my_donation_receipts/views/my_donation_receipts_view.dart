import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/my_donation_receipts_controller.dart';
import '../../../data/models/donation_receipt_model.dart';

class MyDonationReceiptsView extends GetView<MyDonationReceiptsController> {
  const MyDonationReceiptsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(child: _buildReceiptsList()),
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
        'MY DONATION RECEIPTS',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildReceiptsList() {
    return Obx(
      () => ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: controller.donationReceipts.length,
        separatorBuilder: (context, index) =>
            Divider(height: 1, thickness: 1, color: AppColors.lightGrey),
        itemBuilder: (context, index) {
          final receipt = controller.donationReceipts[index];
          return _buildReceiptItem(receipt);
        },
      ),
    );
  }

  Widget _buildReceiptItem(DonationReceiptModel receipt) {
    return InkWell(
      onTap: () => controller.onReceiptTap(receipt),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          children: [
            _buildReceiptIcon(),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receipt.invoiceNumber,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXS),
                  Text(
                    receipt.date,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptIcon() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Image.asset(
        AppImages.donationReceiptItem,
        width: 50,
        height: 50,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.backgroundBlue,
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: const Icon(Icons.favorite, color: AppColors.error, size: 24),
        ),
      ),
    );
  }
}
