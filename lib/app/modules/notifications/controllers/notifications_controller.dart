import 'package:get/get.dart';
import '../../../data/models/activity_model.dart';

class NotificationsController extends GetxController {
  final activities = <ActivityModel>[
    ActivityModel(
      id: '1',
      description: 'HelpCrowd Appeal published a new story',
      timestamp: '5 min ago',
      iconType: ActivityIconType.image,
      imageUrl: '', // Placeholder for person image
    ),
    ActivityModel(
      id: '2',
      description:
          'Your total round up of \$20.00 has been donated to your selected appeals',
      timestamp: '1 hour ago',
      iconType: ActivityIconType.globe,
    ),
    ActivityModel(
      id: '3',
      description: 'HelpCrowd created a new event',
      timestamp: '3 hours ago',
      iconType: ActivityIconType.australiaMap,
    ),
    ActivityModel(
      id: '4',
      description:
          'Your monthly invoice for August is now available for download',
      timestamp: '1 hour ago',
      iconType: ActivityIconType.globe,
    ),
    ActivityModel(
      id: '5',
      description: 'HelpCrowd started a new appeal',
      timestamp: '1 hour ago',
      iconType: ActivityIconType.image,
      imageUrl: '', // Placeholder for hands image
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
