import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart' show AppPages, Routes;
import 'app/core/constants/storage_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Determine initial route based on onboarding status
  final storage = GetStorage();
  final onboardingCompleted =
      storage.read(StorageKeys.onboardingCompleted) ?? false;
  final initialRoute = !onboardingCompleted ? Routes.LANDING : Routes.INTRO;

  runApp(
    GetMaterialApp(
      title: "HelpCrowd",
      theme: AppTheme.lightTheme,
      initialRoute: Routes.SIGNUP_STEP1,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
