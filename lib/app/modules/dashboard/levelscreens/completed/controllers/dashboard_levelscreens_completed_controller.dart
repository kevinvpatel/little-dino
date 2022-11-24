import 'dart:ffi';
import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';

class DashboardLevelscreensCompletedController extends GetxController {
  //TODO: Implement DashboardLevelscreensCompletedController

  final count = 0.obs;
  late ConfettiController controllerCenter;
  bool isplaying = false;





  /// A custom Path to paint stars.
  Path drawStar({ required  size}) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }


  AnalyticsController analyticsController = Get.put(AnalyticsController());


  @override
  void onInit() {
    super.onInit();
    analyticsController.androidButtonEvent(screenName: 'QuizCompletedScreen_Android', screenClass: 'QuizCompletedScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    controllerCenter.dispose();
  }
  void increment() => count.value++;
}
