import 'package:get/get.dart';

import '../controllers/dashboard_privacy_policy_controller.dart';

class DashboardPrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardPrivacyPolicyController>(
      () => DashboardPrivacyPolicyController(),
    );
  }
}
