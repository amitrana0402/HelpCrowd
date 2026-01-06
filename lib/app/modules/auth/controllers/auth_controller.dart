import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/validators.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/storage_keys.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../data/models/login_request_model.dart';
import '../../../data/models/login_response_model.dart';

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

  // API Service
  late final ApiService _apiService;

  // Storage
  final GetStorage _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
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
    passwordError.value = '';

    try {
      // Create login request
      final loginRequest = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Call login API
      final response = await _apiService.post(
        ApiConstants.login,
        loginRequest.toJson(),
        includeCsrf: true,
      );

      // Parse response
      final loginResponse = LoginResponseModel.fromJson(response);

      if (loginResponse.success) {
        // Login successful
        Get.snackbar(
          'Success',
          loginResponse.message,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Save user data and token to storage
        if (loginResponse.data?.token != null) {
          await _storage.write(
            StorageKeys.userToken,
            loginResponse.data!.token!,
          );
          await _storage.write(StorageKeys.isLoggedIn, true);
        }
        if (loginResponse.data?.user != null) {
          await _storage.write(
            StorageKeys.userData,
            loginResponse.data!.user!.toJson(),
          );
          if (loginResponse.data!.user!.email != null) {
            await _storage.write(
              StorageKeys.userEmail,
              loginResponse.data!.user!.email!,
            );
          }
        }

        if (loginResponse.data?.user?.username == null) {
          Get.offAllNamed(Routes.SIGNUP_STEP6);
        } else {
          Get.offAllNamed(Routes.MAIN_NAVIGATION);
        }
      } else {
        // Login failed
        passwordError.value = loginResponse.message;
        Get.snackbar(
          'Error',
          loginResponse.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on ApiException catch (e) {
      // Handle API errors
      if (e.errorModel != null) {
        final errorModel = e.errorModel!;

        // Set field-specific errors
        final emailErr = errorModel.getFieldError('email');
        if (emailErr != null) {
          emailError.value = emailErr;
        }

        final passwordErr = errorModel.getFieldError('password');
        if (passwordErr != null) {
          passwordError.value = passwordErr;
        }

        // Show error message
        Get.snackbar(
          'Error',
          errorModel.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Generic error
        passwordError.value = e.message;
        Get.snackbar('Error', e.message, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // Handle unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
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
