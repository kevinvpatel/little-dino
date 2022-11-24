import 'package:get/get.dart';

import '../controllers/dashboard_about_us_controller.dart';

class DashboardAboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardAboutUsController>(
      () => DashboardAboutUsController(),
    );
  }
}
