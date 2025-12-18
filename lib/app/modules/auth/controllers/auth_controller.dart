import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  // Email Screen State
  final emailController = TextEditingController();
  final emailError = RxString('');
  final isEmailValid = false.obs;

  // Password Screen State
  final passwordController = TextEditingController();
  final passwordError = RxString('');
  final isPasswordValid = false.obs;

  // Loading State
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePassword);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void validateEmail() {
    final error = Validators.email(emailController.text);
    emailError.value = error ?? '';
    isEmailValid.value = error == null && emailController.text.isNotEmpty;
  }

  void validatePassword() {
    final error = Validators.password(passwordController.text);
    passwordError.value = error ?? '';
    isPasswordValid.value = error == null && passwordController.text.isNotEmpty;
  }

  void _validateEmail() {
    validateEmail();
  }

  void _validatePassword() {
    validatePassword();
  }

  void onEmailContinue() {
    _validateEmail();
    if (isEmailValid.value) {
      Get.toNamed(Routes.LOGIN_PASSWORD);
    }
  }

  Future<void> onLogin() async {
    _validatePassword();
    if (!isPasswordValid.value) {
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Implement actual login API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Navigate to home after successful login
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onForgotPassword() {
    // TODO: Implement forgot password flow
    Get.snackbar(
      'Forgot Password',
      'Forgot password functionality will be implemented soon.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onSignupTap() {
    Get.toNamed(Routes.SIGNUP);
  }
}

