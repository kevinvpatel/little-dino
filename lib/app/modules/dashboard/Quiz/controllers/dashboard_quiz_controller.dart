import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/providers/quiz_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/quiz_model.dart';

class DashboardQuizController extends GetxController {
  //TODO: Implement DashboardQuizController

  final count = 0.obs;

  AnalyticsController analyticsController = Get.put(AnalyticsController());

   @override
  void onInit() {
    super.onInit();
    analyticsController.androidButtonEvent(screenName: 'QuizDashboardScreen_Android', screenClass: 'QuizDashboardScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
