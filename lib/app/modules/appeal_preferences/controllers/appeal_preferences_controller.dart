import 'package:get/get.dart';
import '../../../data/models/appeal_model.dart';
import '../../../routes/app_pages.dart';
import '../../signup/controllers/signup_controller.dart';

class AppealPreferencesController extends GetxController {
  // List of appeals
  final appeals = <AppealModel>[].obs;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAppeals();
  }

  // Load dummy appeals data
  void _loadAppeals() {
    appeals.value = [
      AppealModel(
        id: '1',
        title: 'WARMTH FOR WINTER',
        imageUrl: 'https://via.placeholder.com/80?text=Warmth',
        isSelected: false,
      ),
      AppealModel(
        id: '2',
        title: 'SAFE SHELTER',
        imageUrl: 'https://via.placeholder.com/80?text=Shelter',
        isSelected: false,
      ),
      AppealModel(
        id: '3',
        title: 'EMERGENCY MEDICAL AID',
        imageUrl: 'https://via.placeholder.com/80?text=Medical',
        isSelected: true,
      ),
      AppealModel(
        id: '4',
        title: 'FOOD RELIEF',
        imageUrl: 'https://via.placeholder.com/80?text=Food',
        isSelected: false,
      ),
      AppealModel(
        id: '5',
        title: 'SUPPORT FOR SURVIVORS',
        imageUrl: 'https://via.placeholder.com/80?text=Survivors',
        isSelected: true,
      ),
      AppealModel(
        id: '6',
        title: 'MENTAL HEALTH ACCESS',
        imageUrl: 'https://via.placeholder.com/80?text=Mental',
        isSelected: false,
      ),
      AppealModel(
        id: '7',
        title: 'CHILDHOOD VACCINATIONS',
        imageUrl: 'https://via.placeholder.com/80?text=Vaccine',
        isSelected: true,
      ),
      AppealModel(
        id: '8',
        title: 'MOBILE HEALTH CLINICS',
        imageUrl: 'https://via.placeholder.com/80?text=Clinic',
        isSelected: false,
      ),
      AppealModel(
        id: '9',
        title: 'WATER & SANITATION',
        imageUrl: 'https://via.placeholder.com/80?text=Water',
        isSelected: true,
      ),
      AppealModel(
        id: '10',
        title: 'EDUCATION FOR DISPLACED YOUTH',
        imageUrl: 'https://via.placeholder.com/80?text=Education',
        isSelected: false,
      ),
      AppealModel(
        id: '11',
        title: 'FIRST RESPONSE FUND',
        imageUrl: 'https://via.placeholder.com/80?text=FirstAid',
        isSelected: true,
      ),
    ];
  }

  // Toggle selection for an appeal
  void toggleAppealSelection(String appealId) {
    final index = appeals.indexWhere((appeal) => appeal.id == appealId);
    if (index != -1) {
      appeals[index] = appeals[index].copyWith(
        isSelected: !appeals[index].isSelected,
      );
    }
  }

  // Get selected appeals
  List<AppealModel> get selectedAppeals {
    return appeals.where((appeal) => appeal.isSelected).toList();
  }

  // Check if any appeal is selected
  bool get hasSelectedAppeals => selectedAppeals.isNotEmpty;

  // Skip this step
  void onSkip() {
    // Update signup step to 8
    if (Get.isRegistered<SignupController>()) {
      Get.find<SignupController>().updateStepTo8();
    }
    // Navigate to Donation Preferences (step 8)
    Get.toNamed(Routes.DONATION_PREFERENCES);
  }

  // Continue to next step
  void onContinue() {
    // Save selected appeals
    // TODO: Implement API call to save preferences
    // Update signup step to 8
    if (Get.isRegistered<SignupController>()) {
      Get.find<SignupController>().updateStepTo8();
    }
    // Navigate to Donation Preferences (step 8)
    Get.toNamed(Routes.DONATION_PREFERENCES);
  }
}
