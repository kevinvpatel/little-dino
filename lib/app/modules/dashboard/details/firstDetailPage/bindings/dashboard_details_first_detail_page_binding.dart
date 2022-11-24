import 'package:get/get.dart';

import '../controllers/dashboard_details_first_detail_page_controller.dart';

class DashboardDetailsFirstDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardDetailsFirstDetailPageController>(
      () => DashboardDetailsFirstDetailPageController(),
    );
  }
}
