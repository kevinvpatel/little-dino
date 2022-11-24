import 'package:get/get.dart';

import '../controllers/dashboard_score_board_controller.dart';

class DashboardScoreBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardScoreBoardController>(
      () => DashboardScoreBoardController(),
    );
  }
}
