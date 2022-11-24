import 'package:get/get.dart';

import '../controllers/dashboard_my_save_controller.dart';

class DashboardMySaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardMySaveController>(
      () => DashboardMySaveController(),
    );
  }
}
