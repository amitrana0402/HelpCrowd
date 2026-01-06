import 'package:get/get.dart';
import '../../../data/models/reward_model.dart';

class RewardsController extends GetxController {
  final rewards = <RewardModel>[
    RewardModel(
      id: '1',
      title: 'HAPPY MONDAYS',
      subtitle: '',
      type: RewardType.starbucks,
      backgroundColor: '#1E3A2E', // Dark green
      imageUrl: 'assets/images/starbucks_reward.png',
    ),
    RewardModel(
      id: '2',
      title: 'BIG MAC',
      subtitle: 'EXTRA VALUE MEAL',
      price: '\$4.99',
      finePrint:
          'Price and participation may vary. ©2013 The Coca-Cola Company. \'Coca-Cola\' is a registered trademark of the Coca-Cola Company. ©2013 McDonald\'s.',
      type: RewardType.mcdonalds,
      backgroundColor: '#DC143C', // Red
      imageUrl: 'assets/images/mcdonalds_reward.png',
    ),
    RewardModel(
      id: '3',
      title: 'Even sweeter combo deals when you buy an \$11 or \$14 ticket at EVENT Cinemas',
      subtitle: '',
      logoText: 'EVENT',
      type: RewardType.eventCinemas,
      backgroundColor: '#8B0000', // Dark red
      imageUrl: 'assets/images/event_cinemas_reward.png',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onBackTap() {
    Get.back();
  }

  void onRewardTap(RewardModel reward) {
    // TODO: Navigate to reward detail or open reward
  }
}

