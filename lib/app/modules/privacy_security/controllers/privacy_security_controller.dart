import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:help_crowd/app/routes/app_pages.dart';
import '../../../core/constants/storage_keys.dart';

class PrivacySecurityController extends GetxController {
  final GetStorage _storage = GetStorage();

  final isPinEnabled = false.obs;
  final isFaceIdEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    isPinEnabled.value =
        _storage.read(StorageKeys.pinEnabled) ?? true; // Default ON
    isFaceIdEnabled.value =
        _storage.read(StorageKeys.faceIdEnabled) ?? false; // Default OFF
  }

  void onBackTap() {
    Get.back();
  }

  void onPinToggle(bool value) {
    isPinEnabled.value = value;
    _storage.write(StorageKeys.pinEnabled, value);
  }

  void onFaceIdToggle(bool value) {
    isFaceIdEnabled.value = value;
    _storage.write(StorageKeys.faceIdEnabled, value);
  }

  void onChangePinTap() {
    Get.toNamed(Routes.CHANGE_PIN);
  }
}
