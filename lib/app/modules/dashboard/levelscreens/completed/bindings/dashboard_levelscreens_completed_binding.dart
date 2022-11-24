import 'package:get/get.dart';

import '../controllers/dashboard_levelscreens_completed_controller.dart';

class DashboardLevelscreensCompletedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardLevelscreensCompletedController>(
      () => DashboardLevelscreensCompletedController(),
    );
  }
}
