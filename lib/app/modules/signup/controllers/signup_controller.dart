import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/validators.dart';
import '../../../core/constants/api_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_service.dart';
import '../../../data/models/signup_request_model.dart';
import '../../../data/models/signup_response_model.dart';
import '../../../data/models/verify_otp_request_model.dart';
import '../../../data/models/verify_otp_response_model.dart';
import '../../../data/models/create_account_request_model.dart';
import '../../../data/models/create_account_response_model.dart';

class SignupController extends GetxController {
  // Total number of steps in signup flow
  static const int totalSteps = 11;

  // Static step values
  static const int step1 = 1;
  static const int step2 = 2;
  static const int step3 = 3;
  static const int step4 = 4;
  static const int step5 = 5;
  static const int step6 = 6;
  static const int step7 = 7;
  static const int step8 = 8;
  static const int step9 = 9;

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

  // API Service
  late final ApiService _apiService;

  @override
  void onInit() {
    super.onInit();
    _apiService = Get.find<ApiService>();
    firstNameController.addListener(_validateStep1);
    lastNameController.addListener(_validateStep1);
    emailController.addListener(_validateStep2);
    mobileNumberController.addListener(_validateStep3);
    otpController.addListener(_validateStep5);
    passwordController.addListener(_validateStep4);
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
  void validateStep5() {
    final otp = otpController.text.trim();
    if (otp.isEmpty) {
      otpError.value = 'Verification code is required';
      isStep5Valid.value = false;
    } else if (otp.length < 6) {
      otpError.value = 'Please enter a valid 6-digit code';
      isStep5Valid.value = false;
    } else {
      otpError.value = '';
      isStep5Valid.value = true;
    }
  }

  void _validateStep5() {
    validateStep5();
  }

  // Validate Step 5 (Password)
  void validateStep4() {
    final passwordErrorText = Validators.password(passwordController.text);
    passwordError.value = passwordErrorText ?? '';
    isStep4Valid.value =
        passwordErrorText == null && passwordController.text.isNotEmpty;
  }

  void _validateStep4() {
    validateStep4();
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
  void onContinue(int step) {
    switch (step) {
      case step1:
        _handleStep1Continue();
        break;
      case step2:
        _handleStep2Continue();
        break;
      case step3:
        _handleStep3Continue();
        break;
      case step4:
        _handleStep4Continue();
        break;
      case step5:
        _handleStep5Continue();
        break;
      case step6:
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
      Get.toNamed(Routes.SIGNUP_STEP2);
    }
  }

  void _handleStep2Continue() {
    validateStep2();
    if (isStep2Valid.value) {
      Get.toNamed(Routes.SIGNUP_STEP3);
    }
  }

  void _handleStep3Continue() {
    validateStep3();
    if (isStep3Valid.value) {
      // Navigate to step 4 (password step)
      Get.toNamed(Routes.SIGNUP_STEP4);
    }
  }

  Future<void> _handleStep4Continue() async {
    validateStep4();
    if (!isStep4Valid.value) {
      return;
    }

    // Collect data from steps 1-3
    final signupData = SignupRequestModel(
      firstname: firstNameController.text.trim(),
      lastname: lastNameController.text.trim(),
      email: emailController.text.trim(),
      mobile: '${countryCode.value}${mobileNumberController.text.trim()}',
      password: passwordController.text,
      passwordConfirmation: passwordController.text,
    );

    isLoading.value = true;

    // Clear previous errors
    firstNameError.value = '';
    lastNameError.value = '';
    emailError.value = '';
    mobileNumberError.value = '';
    passwordError.value = '';

    try {
      // Call signup API
      final response = await _apiService.post(
        ApiConstants.signup,
        signupData.toJson(),
        includeCsrf: true,
      );

      // Parse response
      final signupResponse = SignupResponseModel.fromJson(response);

      if (signupResponse.success) {
        // Show success message
        Get.snackbar(
          'Success',
          signupResponse.message,
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to step 5 (OTP verification) after successful signup
        Get.toNamed(Routes.SIGNUP_STEP5);
      } else {
        // Handle unexpected response
        Get.snackbar(
          'Error',
          signupResponse.message.isNotEmpty
              ? signupResponse.message
              : 'Failed to create account. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on ApiException catch (e) {
      // Handle API errors
      if (e.errorModel != null) {
        final errorModel = e.errorModel!;

        // Set field-specific errors
        final firstNameErr = errorModel.getFieldError('firstname');
        if (firstNameErr != null) {
          firstNameError.value = firstNameErr;
        }

        final lastNameErr = errorModel.getFieldError('lastname');
        if (lastNameErr != null) {
          lastNameError.value = lastNameErr;
        }

        final emailErr = errorModel.getFieldError('email');
        if (emailErr != null) {
          emailError.value = emailErr;
        }

        final mobileErr = errorModel.getFieldError('mobile');
        if (mobileErr != null) {
          mobileNumberError.value = mobileErr;
        }

        final passwordErr = errorModel.getFieldError('password');
        if (passwordErr != null) {
          passwordError.value = passwordErr;
        }

        // Show error message
        Get.snackbar(
          'Validation Error',
          errorModel.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Generic error
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

  Future<void> _handleStep5Continue() async {
    validateStep5();
    if (!isStep5Valid.value) {
      return;
    }

    isLoading.value = true;
    otpError.value = '';

    try {
      // Step 1: Verify OTP
      final verifyOtpRequest = VerifyOtpRequestModel(
        email: emailController.text.trim(),
        otp: otpController.text.trim(),
      );

      final verifyOtpResponse = await _apiService.post(
        ApiConstants.verifyOtp,
        verifyOtpRequest.toJson(),
        includeCsrf: true,
      );

      final verifyOtpResult = VerifyOtpResponseModel.fromJson(
        verifyOtpResponse,
      );

      if (!verifyOtpResult.success) {
        // OTP verification failed
        otpError.value = verifyOtpResult.message;
        Get.snackbar(
          'Error',
          verifyOtpResult.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Step 2: OTP verified successfully, now create account
      final createAccountRequest = CreateAccountRequestModel(
        email: emailController.text.trim(),
      );

      final createAccountResponse = await _apiService.post(
        ApiConstants.createAccount,
        createAccountRequest.toJson(),
        includeCsrf: true,
      );

      final createAccountResult = CreateAccountResponseModel.fromJson(
        createAccountResponse,
      );

      if (createAccountResult.success) {
        // Account created successfully
        Get.snackbar(
          'Success',
          createAccountResult.message,
          snackPosition: SnackPosition.BOTTOM,
        );

        // TODO: Save user data and token to storage
        // if (createAccountResult.data?.token != null) {
        //   await storageService.saveToken(createAccountResult.data!.token!);
        // }
        // if (createAccountResult.data?.user != null) {
        //   await storageService.saveUser(createAccountResult.data!.user!);
        // }

        // Navigate to step 6 after successful account creation
        Get.toNamed(Routes.SIGNUP_STEP6);
      } else {
        // Account creation failed
        Get.snackbar(
          'Error',
          createAccountResult.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on ApiException catch (e) {
      // Handle API errors
      if (e.errorModel != null) {
        final errorModel = e.errorModel!;

        // Check if it's an OTP error
        final otpErr = errorModel.getFieldError('otp');
        if (otpErr != null) {
          otpError.value = otpErr;
        }

        // Show error message
        Get.snackbar(
          'Error',
          errorModel.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Generic error
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

  void _handleStep6Continue() {
    validateStep6();
    if (isStep6Valid.value) {
      // Navigate to Appeal Preferences (step 7)
      Get.toNamed(Routes.APPEAL_PREFERENCES);
    }
  }

  // Update step when navigating to donation preferences
  void updateStepTo8() {
    Get.toNamed(Routes.DONATION_PREFERENCES);
  }

  // Update step when navigating to specify amount
  void updateStepTo9() {
    Get.toNamed(Routes.SPECIFY_AMOUNT);
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

  // Get step validation status
  bool isStepValid(int step) {
    switch (step) {
      case step1:
        return isStep1Valid.value;
      case step2:
        return isStep2Valid.value;
      case step3:
        return isStep3Valid.value;
      case step4:
        return isStep4Valid.value;
      case step5:
        return isStep5Valid.value;
      case step6:
        return isStep6Valid.value;
      default:
        return false;
    }
  }

  // Navigate to previous step
  void onBack() {
    Get.back();
  }
}
