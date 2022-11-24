import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';

class DashboardCategoryController extends GetxController {
  //TODO: Implement DashboardCategoryController
  final count = 0.obs;
  RxString cetegories_uniqId = ''.obs;

  // Future<Category?> getData() async {
  //   Category? category = await CategoryProvider().getCategory();
  //   return category;
  // }


  AnalyticsController analyticsController = Get.put(AnalyticsController());


  @override
  void onInit() {
    super.onInit();
    analyticsController.androidButtonEvent(screenName: 'CategoryDashboardScreen_Android', screenClass: 'CategoryDashboardScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }




  @override
  void onClose() {}
  void increment() => count.value++;
}
