import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/level/providers/quizlevel_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/level/quizlevel_model.dart';


class DashboardLevelController extends GetxController {
  //TODO: Implement DashboardLevelController

  final count = 0.obs;
  Future<Quizlevel> getdata() async {
    Quizlevel quizlevel = await  QuizlevelProvider().getQuizlevel();
    return quizlevel;
  }

  List colors = [
    Color.fromRGBO(249, 178, 51, 1),
    Color.fromRGBO(95, 207, 255, 1),
    Color.fromRGBO(141, 182, 0, 1),
    Color.fromRGBO(249, 100, 138, 1)
  ];
  List lockImages = [
    "assets/level/orangelock.svg",
    "assets/level/bluelock.svg",
    "assets/level/greenlock.svg",
    "assets/level/pincklock.svg"
  ];

  List colorindex = [0,1,2,3,2,0,1,3,0,1,2,3,2,1,0];


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
