import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChangePinController extends GetxController {
  final GetStorage _storage = GetStorage();
  
  final pinDigits = <String?>[null, null, null, null].obs;
  final currentDigitIndex = 0.obs;
  final isConfirming = false.obs;
  final confirmPinDigits = <String?>[null, null, null, null].obs;
  final isConfirmMode = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onBackTap() {
    if (isConfirmMode.value) {
      // Go back to PIN entry
      isConfirmMode.value = false;
      confirmPinDigits.value = [null, null, null, null];
      currentDigitIndex.value = 0;
    } else {
      Get.back();
    }
  }

  void onNumberTap(String number) {
    if (currentDigitIndex.value < 4) {
      if (isConfirmMode.value) {
        confirmPinDigits[currentDigitIndex.value] = number;
      } else {
        pinDigits[currentDigitIndex.value] = number;
      }
      
      if (currentDigitIndex.value < 3) {
        currentDigitIndex.value++;
      } else {
        // All 4 digits entered
        if (isConfirmMode.value) {
          // Check if PINs match
          _checkPinMatch();
        } else {
          // Move to confirm mode
          _moveToConfirmMode();
        }
      }
    }
  }

  void onDeleteTap() {
    if (currentDigitIndex.value > 0) {
      if (isConfirmMode.value) {
        confirmPinDigits[currentDigitIndex.value - 1] = null;
      } else {
        pinDigits[currentDigitIndex.value - 1] = null;
      }
      currentDigitIndex.value--;
    } else if (currentDigitIndex.value == 0) {
      // Clear current digit
      if (isConfirmMode.value) {
        confirmPinDigits[0] = null;
      } else {
        pinDigits[0] = null;
      }
    }
  }

  void _moveToConfirmMode() {
    isConfirmMode.value = true;
    currentDigitIndex.value = 0;
    confirmPinDigits.value = [null, null, null, null];
  }

  void _checkPinMatch() {
    final pin1 = pinDigits.join('');
    final pin2 = confirmPinDigits.join('');
    
    if (pin1 == pin2) {
      // PINs match, save and go back
      _savePin(pin1);
      Get.back();
      Get.snackbar('Success', 'PIN changed successfully');
    } else {
      // PINs don't match, reset
      Get.snackbar('Error', 'PINs do not match. Please try again.');
      _resetPin();
    }
  }

  void _resetPin() {
    pinDigits.value = [null, null, null, null];
    confirmPinDigits.value = [null, null, null, null];
    currentDigitIndex.value = 0;
    isConfirmMode.value = false;
  }

  void _savePin(String pin) {
    // TODO: Save PIN to secure storage
    // For now, just save to GetStorage
    _storage.write('user_pin', pin);
  }

  void onConfirmTap() {
    if (isConfirmMode.value) {
      // Already in confirm mode, check if all digits entered
      if (currentDigitIndex.value == 3 && confirmPinDigits[3] != null) {
        _checkPinMatch();
      }
    } else {
      // Check if all 4 digits entered
      if (currentDigitIndex.value == 3 && pinDigits[3] != null) {
        _moveToConfirmMode();
      }
    }
  }

  bool get canConfirm {
    if (isConfirmMode.value) {
      return currentDigitIndex.value == 3 && confirmPinDigits[3] != null;
    } else {
      return currentDigitIndex.value == 3 && pinDigits[3] != null;
    }
  }

  List<String?> get currentPinDigits {
    return isConfirmMode.value ? confirmPinDigits : pinDigits;
  }

  String get instructionText {
    return isConfirmMode.value
        ? 'Confirm your 4 Digit passcode'
        : 'Set a 4 Digit passcode';
  }
}

