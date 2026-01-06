import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../controllers/rewards_controller.dart';
import '../../../data/models/reward_model.dart';

class RewardsView extends GetView<RewardsController> {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: AppColors.lightGrey, height: 1, thickness: 1),
            Expanded(child: _buildRewardsList()),
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
        'REWARDS',
        style: AppTextStyles.h3.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRewardsList() {
    return Obx(
      () => ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        children: controller.rewards.map((reward) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.paddingL),
            child: _buildRewardBanner(reward),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRewardBanner(RewardModel reward) {
    switch (reward.type) {
      case RewardType.starbucks:
        return _buildStarbucksBanner(reward);
      case RewardType.mcdonalds:
        return _buildMcDonaldsBanner(reward);
      case RewardType.eventCinemas:
        return _buildEventCinemasBanner(reward);
    }
  }

  Widget _buildStarbucksBanner(RewardModel reward) {
    return InkWell(
      onTap: () => controller.onRewardTap(reward),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF1E3A2E), // Dark green
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Stack(
          children: [
            // Horizontal line pattern overlay
            Positioned.fill(child: CustomPaint(painter: _LinePatternPainter())),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_buildStarbucksTitle()],
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingM),
                  _buildStarbucksImages(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarbucksTitle() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'HAPPY M',
            style: AppTextStyles.h1Light.copyWith(
              fontSize: 36,
              color: const Color(0xFF90EE90), // Light green
              fontWeight: FontWeight.bold,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.favorite, color: AppColors.error, size: 36),
            ),
          ),
          TextSpan(
            text: 'NDAYS',
            style: AppTextStyles.h1Light.copyWith(
              fontSize: 36,
              color: const Color(0xFF90EE90), // Light green
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarbucksImages() {
    return Row(
      children: [
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: const Icon(
            Icons.local_drink,
            size: 50,
            color: AppColors.white,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingS),
        Container(
          width: 60,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: const Icon(
            Icons.phone_android,
            size: 40,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildMcDonaldsBanner(RewardModel reward) {
    return InkWell(
      onTap: () => controller.onRewardTap(reward),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFFDC143C), // Red
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Row(
            children: [
              _buildMcDonaldsImages(),
              const SizedBox(width: AppDimensions.paddingL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reward.title,
                      style: AppTextStyles.h1Light.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$',
                          style: AppTextStyles.h2Light.copyWith(fontSize: 24),
                        ),
                        Text(
                          reward.price ?? '',
                          style: AppTextStyles.h1Light.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingS),
                    Text(
                      reward.subtitle,
                      style: AppTextStyles.bodyMediumLight.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    if (reward.finePrint != null) ...[
                      const SizedBox(height: AppDimensions.paddingM),
                      Text(
                        reward.finePrint!,
                        style: AppTextStyles.captionLight.copyWith(fontSize: 8),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMcDonaldsImages() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: const Icon(
            Icons.lunch_dining,
            size: 60,
            color: AppColors.white,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 20,
          child: Container(
            width: 40,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: const Icon(
              Icons.local_drink,
              size: 30,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCinemasBanner(RewardModel reward) {
    return InkWell(
      onTap: () => controller.onRewardTap(reward),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF8B0000), // Dark red
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.movie,
                  size: 40,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reward.title,
                      style: AppTextStyles.bodyLargeLight.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reward.logoText ?? 'EVENT',
                          style: AppTextStyles.h3Light.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'REWARDS',
                          style: AppTextStyles.h3Light.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    Container(
                      width: 80,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusS,
                        ),
                      ),
                      child: CustomPaint(painter: _CinemaPatternPainter()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom painter for horizontal line pattern
class _LinePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    for (double y = 0; y < size.height; y += 10) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for cinema pattern
class _CinemaPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2;

    // Draw diagonal lines
    for (double i = -size.height; i < size.width; i += 10) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
