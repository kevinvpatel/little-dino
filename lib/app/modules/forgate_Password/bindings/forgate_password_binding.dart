import 'package:get/get.dart';

import '../controllers/forgate_password_controller.dart';

class ForgatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgatePasswordController>(
      () => ForgatePasswordController(),
    );
  }
}
