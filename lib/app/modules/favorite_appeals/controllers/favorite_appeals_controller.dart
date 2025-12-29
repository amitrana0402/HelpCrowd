import 'package:get/get.dart';
import '../../../data/models/appeal_model.dart';

class FavoriteAppealsController extends GetxController {
  // List of appeals
  final appeals = <AppealModel>[
    AppealModel(
      id: '1',
      title: 'WARMTH FOR WINTER',
      imageUrl: 'https://via.placeholder.com/80?text=Warmth',
      isSelected: true,
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
      isSelected: false,
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
      isSelected: false,
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
      isSelected: false,
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
      isSelected: false,
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
      isSelected: false,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
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

  // Get selected appeals count
  int get selectedCount {
    return appeals.where((appeal) => appeal.isSelected).length;
  }

  // Follow selected appeals
  void onFollowSelected() {
    // TODO: Implement follow functionality
    Get.back();
  }
}

