import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  // Total number of steps in signup flow
  static const int totalSteps = 11;

  // Current step (1-based)
  final currentStep = 1.obs;

  // Step 1: Name Fields
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final firstNameError = RxString('');
  final lastNameError = RxString('');
  final isStep1Valid = false.obs;

  // Step 2: Email Field
  final emailController = TextEditingController();
  final emailError = RxString('');
  final isStep2Valid = false.obs;

  // Step 3: Mobile Number Field
  final mobileNumberController = TextEditingController();
  final countryCode = '+61'.obs;
  final mobileNumberError = RxString('');
  final isStep3Valid = false.obs;
  final otpSent = false.obs;

  // Step 4: OTP Verification
  final otpController = TextEditingController();
  final otpError = RxString('');
  final isStep4Valid = false.obs;
  final canResendOtp = true.obs;

  // Step 5: Password
  final passwordController = TextEditingController();
  final passwordError = RxString('');
  final isStep5Valid = false.obs;

  // Step 6: Username
  final usernameController = TextEditingController();
  final usernameError = RxString('');
  final isStep6Valid = false.obs;

  // Loading State
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    firstNameController.addListener(_validateStep1);
    lastNameController.addListener(_validateStep1);
    emailController.addListener(_validateStep2);
    mobileNumberController.addListener(_validateStep3);
    otpController.addListener(_validateStep4);
    passwordController.addListener(_validateStep5);
    usernameController.addListener(_validateStep6);
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    otpController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.onClose();
  }

  // Get progress percentage (0.0 to 1.0)
  double get progress => currentStep.value / totalSteps;

  // Validate Step 1 (First Name and Last Name)
  void validateStep1() {
    final firstNameErrorText = Validators.required(
      firstNameController.text,
      fieldName: 'First name',
    );
    final lastNameErrorText = Validators.required(
      lastNameController.text,
      fieldName: 'Last name',
    );

    firstNameError.value = firstNameErrorText ?? '';
    lastNameError.value = lastNameErrorText ?? '';

    isStep1Valid.value =
        firstNameErrorText == null &&
        lastNameErrorText == null &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty;
  }

  void _validateStep1() {
    validateStep1();
  }

  // Validate Step 2 (Email)
  void validateStep2() {
    final emailErrorText = Validators.email(emailController.text);
    emailError.value = emailErrorText ?? '';
    isStep2Valid.value =
        emailErrorText == null && emailController.text.isNotEmpty;
  }

  void _validateStep2() {
    validateStep2();
  }

  // Validate Step 3 (Mobile Number)
  void validateStep3() {
    final mobileNumber = mobileNumberController.text.trim();
    if (mobileNumber.isEmpty) {
      mobileNumberError.value = 'Mobile number is required';
      isStep3Valid.value = false;
    } else if (mobileNumber.length < 8) {
      mobileNumberError.value = 'Please enter a valid mobile number';
      isStep3Valid.value = false;
    } else {
      mobileNumberError.value = '';
      isStep3Valid.value = true;
    }
  }

  void _validateStep3() {
    validateStep3();
  }

  // Validate Step 4 (OTP)
  void validateStep4() {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      otpError.value = 'Verification code is required';
      isStep4Valid.value = false;
    } else if (otp.length < 6) {
      otpError.value = 'Please enter a valid 6-digit code';
      isStep4Valid.value = false;
    } else {
      otpError.value = '';
      isStep4Valid.value = true;
    }
  }

  void _validateStep4() {
    validateStep4();
  }

  // Validate Step 5 (Password)
  void validateStep5() {
    final passwordErrorText = Validators.password(passwordController.text);
    passwordError.value = passwordErrorText ?? '';
    isStep5Valid.value =
        passwordErrorText == null && passwordController.text.isNotEmpty;
  }

  void _validateStep5() {
    validateStep5();
  }

  // Validate Step 6 (Username)
  void validateStep6() {
    final username = usernameController.text.trim();
    if (username.isEmpty) {
      usernameError.value = 'Username is required';
      isStep6Valid.value = false;
    } else if (username.length < 3) {
      usernameError.value = 'Username must be at least 3 characters';
      isStep6Valid.value = false;
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      usernameError.value =
          'Username can only contain letters, numbers, and underscores';
      isStep6Valid.value = false;
    } else {
      usernameError.value = '';
      isStep6Valid.value = true;
    }
  }

  void _validateStep6() {
    validateStep6();
  }

  // Navigate to next step
  void onContinue() {
    switch (currentStep.value) {
      case 1:
        _handleStep1Continue();
        break;
      case 2:
        _handleStep2Continue();
        break;
      case 3:
        _handleStep3Continue();
        break;
      case 4:
        _handleStep4Continue();
        break;
      case 5:
        _handleStep5Continue();
        break;
      case 6:
        _handleStep6Continue();
        break;
      // TODO: Add handlers for other steps (7-11)
      default:
        break;
    }
  }

  void _handleStep1Continue() {
    validateStep1();
    if (isStep1Valid.value) {
      currentStep.value = 2;
      Get.toNamed(Routes.SIGNUP_STEP2);
    }
  }

  void _handleStep2Continue() {
    validateStep2();
    if (isStep2Valid.value) {
      currentStep.value = 3;
      Get.toNamed(Routes.SIGNUP_STEP3);
    }
  }

  Future<void> _handleStep3Continue() async {
    validateStep3();
    if (!isStep3Valid.value) {
      return;
    }

    isLoading.value = true;
    try {
      // TODO: Implement actual OTP sending API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      otpSent.value = true;
      // Navigate to step 4 after OTP is sent
      currentStep.value = 4;
      Get.toNamed(Routes.SIGNUP_STEP4);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handleStep4Continue() async {
    validateStep4();
    if (!isStep4Valid.value) {
      return;
    }

    isLoading.value = true;
    try {
      // TODO: Implement actual OTP verification API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      // Navigate to step 5 after verification
      currentStep.value = 5;
      Get.toNamed(Routes.SIGNUP_STEP5);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid verification code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _handleStep5Continue() async {
    validateStep5();
    if (!isStep5Valid.value) {
      return;
    }

    isLoading.value = true;
    try {
      // TODO: Implement actual account creation API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      // Navigate to step 6 after account creation
      currentStep.value = 6;
      Get.toNamed(Routes.SIGNUP_STEP6);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create account. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _handleStep6Continue() {
    validateStep6();
    if (isStep6Valid.value) {
      // TODO: Navigate to next step when implemented
      // currentStep.value = 7;
      // Get.toNamed(Routes.SIGNUP_STEP7);
    }
  }

  // Resend OTP
  Future<void> onResendOtp() async {
    if (!canResendOtp.value) return;

    isLoading.value = true;
    canResendOtp.value = false;
    try {
      // TODO: Implement actual OTP resend API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      otpController.clear();
      Get.snackbar(
        'Success',
        'Verification code has been resent.',
        snackPosition: SnackPosition.BOTTOM,
      );
      // Enable resend after 30 seconds
      Future.delayed(const Duration(seconds: 30), () {
        canResendOtp.value = true;
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      canResendOtp.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  // Get current step validation status
  bool get isCurrentStepValid {
    switch (currentStep.value) {
      case 1:
        return isStep1Valid.value;
      case 2:
        return isStep2Valid.value;
      case 3:
        return isStep3Valid.value;
      case 4:
        return isStep4Valid.value;
      case 5:
        return isStep5Valid.value;
      case 6:
        return isStep6Valid.value;
      default:
        return false;
    }
  }

  // Navigate to previous step
  void onBack() {
    if (currentStep.value > 1) {
      currentStep.value--;
      Get.back();
    } else {
      Get.back();
    }
  }
}
