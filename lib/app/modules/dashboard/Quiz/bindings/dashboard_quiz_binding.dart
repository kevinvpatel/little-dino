import 'package:get/get.dart';

import '../controllers/dashboard_quiz_controller.dart';

class DashboardQuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardQuizController>(
      () => DashboardQuizController(),
    );
  }
}
