import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:help_crowd/app/widgets/buttons/app_button.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../data/models/latest_appeals_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(child: _buildTabView()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      centerTitle: false,
      title: Image.asset(
        AppImages.homeLogo,
        height: AppDimensions.logoSizeM,
        errorBuilder: (context, error, stackTrace) =>
            Text(AppConstants.appName, style: AppTextStyles.h3),
      ),
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
                'LATEST NEWS',
                0,
                controller.selectedTabIndex.value == 0,
              ),
            ),
            Expanded(
              child: _buildTabItem(
                'APPEALS',
                1,
                controller.selectedTabIndex.value == 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, int index, bool isSelected) {
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
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: isSelected
              ? AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                )
              : AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
        ),
      ),
    );
  }

  Widget _buildTabView() {
    return Obx(
      () => IndexedStack(
        index: controller.selectedTabIndex.value,
        children: [_buildLatestNewsTab(), _buildAppealsTab()],
      ),
    );
  }

  Widget _buildLatestNewsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.newsList.clear();
        controller.currentNewsPage.value = 1;
        controller.hasMoreNews.value = true;
        await controller.loadInitialNews();
      },
      child: Obx(() {
        if (controller.newsList.isEmpty && controller.isLoadingNews.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadingNews.value &&
                controller.hasMoreNews.value &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
              controller.loadMoreNews();
            }
            return false;
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              if (controller.featuredNews != null)
                _buildFeaturedArticle(controller.featuredNews!),
              _buildTopStoriesSection(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20.0,
                ),

                child: AppButton(
                  text: 'Donate now',
                  onPressed: () {},
                  variant: ButtonVariant.primary,
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

              _buildRegularNewsSection(),
              if (controller.isLoadingNews.value)
                const Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingL),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ),
              if (!controller.hasMoreNews.value &&
                  controller.newsList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingL),
                  child: Center(
                    child: Text(
                      'No more news to load',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildFeaturedArticle(news) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.primaryBlue.withOpacity(0.2),

      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      news.imageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 250,
                        color: AppColors.lightGrey,
                        child: const Icon(
                          Icons.image,
                          size: 48,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingL),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.title,
                            style: AppTextStyles.h2Light,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: AppDimensions.paddingM),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.NEWS_DETAIL, arguments: news);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingXL,
                                vertical: AppDimensions.paddingS,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                'Read more',
                                style: AppTextStyles.buttonText,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildTopStoriesSection() {
    return Obx(() {
      final topStories = controller.topStories;
      if (topStories.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Text(
              'TOP STORIES',
              style: AppTextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          ...topStories.map((news) => _buildNewsCard(news)),
        ],
      );
    });
  }

  Widget _buildRegularNewsSection() {
    return Obx(() {
      final regularNews = controller.regularNews;

      return Column(
        children: regularNews.map((news) => _buildNewsCard(news)).toList(),
      );
    });
  }

  Widget _buildNewsCard(news) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.NEWS_DETAIL, arguments: news);
      },
      child: SizedBox(
        height: 410,
        child: Stack(
          children: [
            Image.network(
              news.imageUrl,
              width: double.infinity,
              height: 175,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 175,
                color: AppColors.lightGrey,
                child: const Icon(Icons.image, size: 48, color: AppColors.grey),
              ),
            ),

            Positioned(
              top: 150,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      news.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.paddingS),

                    Text(
                      news.description,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textDark.withOpacity(0.8),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.paddingM),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (news.datePosted != null)
                          Text(news.datePosted!, style: AppTextStyles.caption)
                        else
                          const SizedBox.shrink(),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.NEWS_DETAIL, arguments: news);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: AppDimensions.iconS,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppealsTab() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.appealsList.clear();
        controller.currentAppealsPage.value = 1;
        controller.hasMoreAppeals.value = true;
        controller.isInitialLoadingAppeals.value = true;
        await controller.loadInitialAppeals();
      },
      child: Obx(() {
        // Show shimmer on initial load
        if (controller.isInitialLoadingAppeals.value &&
            controller.appealsList.isEmpty) {
          return _buildShimmerList();
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadingAppeals.value &&
                controller.hasMoreAppeals.value &&
                scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent - 200) {
              controller.loadMoreAppeals();
            }
            return false;
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            itemCount:
                controller.appealsList.length +
                (controller.isLoadingAppeals.value ? 1 : 0) +
                (!controller.hasMoreAppeals.value &&
                        controller.appealsList.isNotEmpty
                    ? 1
                    : 0),
            itemBuilder: (context, index) {
              if (index == controller.appealsList.length) {
                if (controller.isLoadingAppeals.value) {
                  return const Padding(
                    padding: EdgeInsets.all(AppDimensions.paddingL),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  );
                } else if (!controller.hasMoreAppeals.value) {
                  return Padding(
                    padding: const EdgeInsets.all(AppDimensions.paddingL),
                    child: Center(
                      child: Text(
                        'No more appeals to load',
                        style: AppTextStyles.caption,
                      ),
                    ),
                  );
                }
              }

              if (index < controller.appealsList.length) {
                final appeal = controller.appealsList[index];

                return _buildAppealCard(appeal);
              }

              return const SizedBox.shrink();
            },
          ),
        );
      }),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      itemCount: 10, // Show 10 shimmer items
      itemBuilder: (context, index) {
        return _buildShimmerCard();
      },
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGrey.withOpacity(0.3),
      highlightColor: AppColors.lightGrey.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimensions.paddingL),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Container(
                    width: 100,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
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

  Widget _buildAppealCard(LatestAppealsModel appeal) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.APPEAL_DETAIL, arguments: appeal);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimensions.paddingL),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              child: appeal.imageUrl.isNotEmpty
                  ? Image.network(
                      appeal.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100,
                        height: 100,
                        color: AppColors.lightGrey,
                        child: const Icon(
                          Icons.image,
                          size: 32,
                          color: AppColors.grey,
                        ),
                      ),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      color: AppColors.lightGrey,
                      child: const Icon(
                        Icons.image,
                        size: 32,
                        color: AppColors.grey,
                      ),
                    ),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appeal.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (appeal.formattedDate != null) ...[
                    const SizedBox(height: AppDimensions.paddingS),
                    Text(appeal.formattedDate!, style: AppTextStyles.caption),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
