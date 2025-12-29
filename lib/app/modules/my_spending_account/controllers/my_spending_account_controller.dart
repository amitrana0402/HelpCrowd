import 'package:get/get.dart';

class MySpendingAccountController extends GetxController {
  // Account details
  final accountNumber = '**** **** **** 1234'.obs;
  final bankName = 'Commonwealth Bank CBA'.obs;
  final bankLogoColor = 0xFFFFD700; // Yellow color for bank logo

  @override
  void onInit() {
    super.onInit();
  }

  void onBackTap() {
    Get.back();
  }

  void onEditAccountTap() {
    // TODO: Navigate to edit account screen
  }
}

