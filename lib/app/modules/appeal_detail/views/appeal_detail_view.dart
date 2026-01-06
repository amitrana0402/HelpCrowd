import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/widgets/buttons/app_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/appeal_detail_controller.dart';

class AppealDetailView extends GetView<AppealDetailController> {
  const AppealDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.appeal == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            _buildScrollableContent(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: AppButton(
                text: 'Donate now',
                onPressed: controller.onDonateTap,
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

  Widget _buildScrollableContent(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(children: [_buildHeroImage(context), _buildArticleBody()]),
            Positioned(
              top: 230,
              left: 20,
              right: 20,
              child: _buildArticleCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          controller.appeal!.imageUrl,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: MediaQuery.of(context).size.height * 0.4,
            color: AppColors.lightGrey,
            child: const Icon(Icons.image, size: 48, color: AppColors.grey),
          ),
        ),
        // Gradient overlay effect
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArticleCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.appeal!.title,
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingS),
                if (controller.formattedDate != null)
                  Text(
                    controller.formattedDate!,
                    style: AppTextStyles.caption,
                  ),
                const SizedBox(height: AppDimensions.paddingS),
                _buildShareSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Share',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
        ),
        Row(
          children: [
            _buildShareImageIcon(AppImages.facebook, () {
              controller.onShareTap('facebook');
            }),
            const SizedBox(width: AppDimensions.paddingS),
            _buildShareImageIcon(AppImages.twitter, () {
              controller.onShareTap('twitter');
            }),
            const SizedBox(width: AppDimensions.paddingS),
            _buildShareImageIcon(AppImages.instagram, () {
              controller.onShareTap('instagram');
            }),
            const SizedBox(width: AppDimensions.paddingS),
            _buildShareIcon(Icons.more_horiz, AppColors.primaryBlue, () {
              controller.onShareTap('more');
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildShareImageIcon(String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: Image.asset(
            imagePath,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildShareIcon(
    IconData icon,
    Color backgroundColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(icon, size: 20, color: AppColors.white)),
      ),
    );
  }

  Widget _buildArticleBody() {
    final paragraphs = controller.fullContent
        .split('\n\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingL,
        120,
        AppDimensions.paddingL,
        AppDimensions.paddingL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: paragraphs.map((paragraph) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.paddingL),
            child: Text(paragraph.trim(), style: AppTextStyles.bodyMedium),
          );
        }).toList(),
      ),
    );
  }
}

