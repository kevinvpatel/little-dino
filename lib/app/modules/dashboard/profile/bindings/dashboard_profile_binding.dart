import 'package:get/get.dart';

import '../controllers/dashboard_profile_controller.dart';

class DashboardProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardProfileController>(
      () => DashboardProfileController(),
    );
  }
}
