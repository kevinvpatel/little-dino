import 'package:get/get.dart';

import '../controllers/levelscreens_quiz_screen_controller.dart';

class LevelscreensQuizScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LevelscreensQuizScreenController>(
      () => LevelscreensQuizScreenController(),
    );
  }
}
