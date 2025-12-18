import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../routes/app_pages.dart';

class IntroController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void skipOnboarding() {
    _markOnboardingCompleted();
    Get.offAllNamed(Routes.LANDING);
  }

  void onHelpChangeWorldTap() {
    if (currentPage.value < 3) {
      // Move to next page
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page, navigate to landing
      _markOnboardingCompleted();
      Get.offAllNamed(Routes.LANDING);
    }
  }

  void onLoginTap() {
    _markOnboardingCompleted();
    Get.offAllNamed(Routes.LOGIN_EMAIL);
  }

  void _markOnboardingCompleted() {
    _storage.write(StorageKeys.onboardingCompleted, true);
  }

  bool isOnboardingCompleted() {
    return _storage.read(StorageKeys.onboardingCompleted) ?? false;
  }
}
