import 'package:get/get.dart';

import '../controllers/dashboard_details_alphabets_controller.dart';

class DashboardDetailsAlphabetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardDetailsAlphabetsController>(
      () => DashboardDetailsAlphabetsController(),
    );
  }
}
