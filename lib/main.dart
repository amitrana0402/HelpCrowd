import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart' show AppPages, Routes;
import 'app/core/constants/storage_keys.dart';
import 'app/core/constants/api_constants.dart';
import 'app/services/api_service.dart';
import 'app/data/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize API Service
  Get.put(ApiService(), permanent: true);
  await Get.find<ApiService>().init();

  // Determine initial route based on app state
  final initialRoute = await _determineInitialRoute();

  runApp(
    GetMaterialApp(
      title: "HelpCrowd",
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

/// Determines the initial route based on onboarding status, token, and user profile
Future<String> _determineInitialRoute() async {
  final storage = GetStorage();

  // Step 1: Check if onboarding is completed
  final onboardingCompleted =
      storage.read(StorageKeys.onboardingCompleted) ?? false;

  if (!onboardingCompleted) {
    // Onboarding not done, navigate to intro page
    return Routes.INTRO;
  }

  // Step 2: Check if user has token
  final userToken = storage.read<String>(StorageKeys.userToken);

  if (userToken == null || userToken.isEmpty) {
    // No token, navigate to landing page
    return Routes.LANDING;
  }

  // Step 3: Check if token is valid using profile API
  try {
    final apiService = Get.find<ApiService>();
    final profileResponse = await apiService.get(
      ApiConstants.me,
      authToken: userToken,
      includeCsrf: true,
    );

    // Parse user profile
    final userData = profileResponse['data'] ?? profileResponse;
    final user = UserModel.fromJson(
      userData is Map<String, dynamic> ? userData : {},
    );

    // Save user data to storage for future use
    await storage.write(StorageKeys.userData, user.toJson());

    // Step 4: Check if profile has username
    if (user.username != null && user.username!.isNotEmpty) {
      // User has username, navigate to main navigation
      return Routes.MAIN_NAVIGATION;
    } else {
      // User doesn't have username, navigate to signup step 6
      return Routes.SIGNUP_STEP6;
    }
  } catch (e) {
    // Token is invalid or API call failed, navigate to landing
    // Clear invalid token and user data
    await storage.remove(StorageKeys.userToken);
    await storage.remove(StorageKeys.userData);
    return Routes.LANDING;
  }
}
