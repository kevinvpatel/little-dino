import 'package:get/get.dart';

import '../controllers/dashboard_home_controller.dart';

class DashboardHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardHomeController>(
      () => DashboardHomeController(),
    );
  }
}
