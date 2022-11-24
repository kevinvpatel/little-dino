import 'package:get/get.dart';

import '../controllers/dashboard_quiz_caterogies_controller.dart';

class DashboardQuizCaterogiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardQuizCaterogiesController>(
      () => DashboardQuizCaterogiesController(),
    );
  }
}
