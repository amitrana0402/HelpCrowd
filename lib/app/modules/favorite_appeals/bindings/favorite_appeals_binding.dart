import 'package:get/get.dart';
import '../controllers/favorite_appeals_controller.dart';

class FavoriteAppealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteAppealsController>(() => FavoriteAppealsController());
  }
}

