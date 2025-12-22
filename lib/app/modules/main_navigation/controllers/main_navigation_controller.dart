import 'package:get/get.dart';
import '../../home/bindings/home_binding.dart';
import '../../transactions/bindings/transactions_binding.dart';
import '../../profile/bindings/profile_binding.dart';
import '../../notifications/bindings/notifications_binding.dart';
import '../../settings/bindings/settings_binding.dart';

class MainNavigationController extends GetxController {
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize all tab controllers using their bindings
    HomeBinding().dependencies();
    TransactionsBinding().dependencies();
    ProfileBinding().dependencies();
    NotificationsBinding().dependencies();
    SettingsBinding().dependencies();
  }

  void changeTab(int index) {
    if (index != currentIndex.value) {
      currentIndex.value = index;
    }
  }
}
