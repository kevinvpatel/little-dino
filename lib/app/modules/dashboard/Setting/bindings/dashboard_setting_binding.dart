import 'package:get/get.dart';

import '../controllers/dashboard_setting_controller.dart';

class DashboardSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardSettingController>(
      () => DashboardSettingController(),
    );
  }
}
