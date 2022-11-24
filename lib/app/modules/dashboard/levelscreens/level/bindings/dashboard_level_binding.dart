import 'package:get/get.dart';

import '../controllers/dashboard_level_controller.dart';

class DashboardLevelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardLevelController>(
      () => DashboardLevelController(),
    );
  }
}
