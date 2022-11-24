import 'package:get/get.dart';

import '../controllers/dashboard_recet_controller.dart';

class DashboardRecetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardRecetController>(
      () => DashboardRecetController(),
    );
  }
}
