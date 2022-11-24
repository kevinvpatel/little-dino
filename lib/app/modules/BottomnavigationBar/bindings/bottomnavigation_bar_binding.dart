import 'package:get/get.dart';

import '../controllers/bottomnavigation_bar_controller.dart';

class BottomnavigationBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomnavigationBarController>(
      () => BottomnavigationBarController(),
    );
  }
}
