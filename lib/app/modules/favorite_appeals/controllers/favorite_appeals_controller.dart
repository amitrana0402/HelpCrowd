import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/appeal_model.dart';
import '../../../services/api_service.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/constants/storage_keys.dart';

class FavoriteAppealsController extends GetxController {
  // Services
  final ApiService _apiService = Get.find<ApiService>();
  final GetStorage _storage = GetStorage();

  // List of appeals
  final appeals = <AppealModel>[].obs;

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAppeals();
  }

  // Load appeals from API
  Future<void> _loadAppeals() async {
    isLoading.value = true;
    try {
      // Get auth token
      final authToken = _storage.read<String>(StorageKeys.userToken);

      // Make API call
      final response = await _apiService.get(
        ApiConstants.appealPreferences,
        authToken: authToken,
        includeCsrf: true,
      );

      // Parse response
      if (response['data'] != null) {
        final List<dynamic> appealsData = response['data'] as List<dynamic>;
        appeals.value = appealsData
            .map((json) => AppealModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to load appeals: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle selection for an appeal
  void toggleAppealSelection(int appealId) {
    final index = appeals.indexWhere((appeal) => appeal.id == appealId);
    if (index != -1) {
      appeals[index] = appeals[index].copyWith(
        isFavourite: !appeals[index].isFavourite,
      );
    }
  }

  // Get selected appeals count
  int get selectedCount {
    return appeals.where((appeal) => appeal.isFavourite).length;
  }

  // Get selected favorite appeals
  List<AppealModel> get selectedFavouriteAppeals {
    return appeals.where((appeal) => appeal.isFavourite).toList();
  }

  // Follow selected appeals
  Future<void> onFollowSelected() async {
    // Get selected favorite appeal IDs
    final selectedIds = selectedFavouriteAppeals
        .map((appeal) => appeal.id)
        .toList();

    // Show loading
    isLoading.value = true;

    try {
      // Get auth token
      final authToken = _storage.read<String>(StorageKeys.userToken);

      // Prepare request body
      final requestBody = {'appeal_ids': selectedIds};

      // Make API call to save favorites
      final response = await _apiService.post(
        ApiConstants.saveAppealFavourites,
        requestBody,
        includeCsrf: true,
        authToken: authToken,
      );

      // Handle response
      if (response['message'] != null) {
        // Success - navigate back
        Get.back();
      }
    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to save favorites: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
