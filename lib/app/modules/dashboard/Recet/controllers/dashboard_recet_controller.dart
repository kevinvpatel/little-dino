import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';

class DashboardRecetController extends GetxController {
  //TODO: Implement DashboardRecetController


  AnalyticsController analyticsController = Get.put(AnalyticsController());


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    analyticsController.androidButtonEvent(screenName: 'RecentScreen_Android', screenClass: 'RecentScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
