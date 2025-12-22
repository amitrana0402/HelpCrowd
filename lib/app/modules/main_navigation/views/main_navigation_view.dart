import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_navigation_controller.dart';
import '../../home/views/home_view.dart';
import '../../transactions/views/transactions_view.dart';
import '../../profile/views/profile_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../settings/views/settings_view.dart';
import '../../../widgets/bottom_nav_bar.dart';

class MainNavigationView extends GetView<MainNavigationController> {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeView(),
            TransactionsView(),
            ProfileView(),
            NotificationsView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }
}
