import 'package:get/get.dart';

import '../controllers/dashboard_category_controller.dart';

class DashboardCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardCategoryController>(
      () => DashboardCategoryController(),
    );
  }
}
