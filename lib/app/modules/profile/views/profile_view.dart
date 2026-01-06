import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/routes/app_pages.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/profile_controller.dart';
import '../../../data/models/profile_donation_category_model.dart';
import '../../../data/models/appeal_model.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            _buildMonthlyDonationCard(),
            _buildFavoriteAppealsSection(),
            const SizedBox(height: AppDimensions.paddingXL),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 188,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingM,
              ),
              color: AppColors.lightBlue,
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: controller.onMenuTap,
                          icon: const Icon(
                            Icons.more_vert,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 130,
              color: AppColors.backgroundLight,
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Row(
                children: [
                  Spacer(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Positioned(
          top: 120,
          left: 20,
          right: 20,
          child: Row(
            children: [
              _buildProfileImage(),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        controller.username.value,
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                      () => Text(
                        controller.fullName.value,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Obx(
                      () => Text(
                        '\$${_formatCurrency(controller.totalDonations.value)}',
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    Text(
                      'Total Donations',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    Obx(
                      () => Text(
                        'Member since ${controller.memberSince.value}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.lightBlue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        Container(
          width: 135,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: controller.profileImageUrl.value.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  child: Image.network(
                    controller.profileImageUrl.value,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceholderImage(),
                  ),
                )
              : _buildPlaceholderImage(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: controller.onProfileImageTap,
              icon: const Icon(
                Icons.camera_alt,
                color: AppColors.white,
                size: 16,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderImage() {
    return Icon(
      Icons.person,
      size: AppDimensions.iconXL,
      color: AppColors.grey,
    );
  }

  Widget _buildMonthlyDonationCard() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingL),
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingL),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingL,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          '\$${controller.monthlyDonation.value.toStringAsFixed(2)}',
                          style: AppTextStyles.h2.copyWith(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXS),
                      Text(
                        'DONATED THIS MONTH',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    AppImages.heartDonation,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.lightGrey.withOpacity(0.5), height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingL,
            ),
            child: Row(
              children: [
                Expanded(flex: 2, child: _buildDonutChart()),
                SizedBox(width: AppDimensions.paddingM),
                Expanded(flex: 3, child: _buildCategoryLegend()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonutChart() {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: DonutChartPainter(controller.donationCategories),
      ),
    );
  }

  Widget _buildCategoryLegend() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.donationCategories.map((category) {
          return Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: category.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: Text(
                  category.name,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
              Text(
                '${category.percentage.toStringAsFixed(0)}%',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFavoriteAppealsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Get.toNamed(Routes.FAVORITE_APPEALS),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingL,
            ),
            child: Text(
              'FAVOURITE APPEALS',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        Obx(
          () => SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
              ),
              itemCount: controller.favoriteAppeals.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppDimensions.paddingM),
              itemBuilder: (context, index) {
                final appeal = controller.favoriteAppeals[index];
                return _buildAppealCard(appeal);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppealCard(AppealModel appeal) {
    return GestureDetector(
      onTap: () => controller.onAppealTap(appeal.id),
      child: Container(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  child: appeal.imageUrl.isNotEmpty
                      ? Image.network(
                          appeal.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildAppealPlaceholder(),
                        )
                      : _buildAppealPlaceholder(),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              appeal.title,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppealPlaceholder() {
    return Container(
      color: AppColors.lightGrey,
      child: const Icon(Icons.image, size: 48, color: AppColors.grey),
    );
  }

  String _formatCurrency(double amount) {
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

    return '$formatted.$decimalPart';
  }
}

// Donut Chart Painter
class DonutChartPainter extends CustomPainter {
  final List<ProfileDonationCategoryModel> categories;

  DonutChartPainter(this.categories);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 5;
    final strokeWidth = radius * 0.4;

    double startAngle = -math.pi / 2; // Start from top

    for (var category in categories) {
      final sweepAngle = (category.percentage / 100) * 2 * math.pi;

      // Draw arc segment
      final paint = Paint()
        ..color = category.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;

      final rect = Rect.fromCircle(
        center: center,
        radius: radius - strokeWidth / 2,
      );

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is DonutChartPainter) {
      return oldDelegate.categories != categories;
    }
    return true;
  }
}
