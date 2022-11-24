import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/modules/login/views/login_view.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController

  final count = 0.obs;

  PageController pagecontroller = PageController();

  List BackGroundImages = [Constants.onboarding1,Constants.onboarding2,Constants.onboarding3,""];
  List centerImages = [Constants.onboardingCenter1,Constants.onboardingCenter2,Constants.onboardingCenter3,""];
  List the_clouds = [Constants.the_clouds1, Constants.the_clouds2, Constants.the_clouds3,Constants.the_clouds3];


  List text1 = [
    "Attractive and colourful designs ",
    "Easy And Intutitive Instruction for",
    "Learning From Simple"
  ];
  List text2 = [
    "and pictures",
    "The Young Brains",
    "",
    ""
  ];
  List color = [ConstantsColors.orangeColor, ConstantsColors.lightblue, ConstantsColors.green, Colors.transparent];
  @override

  void onInit() {
    super.onInit();
  }

  onpressNextButton(){
      pagecontroller.page == 2
          ? Get.to(LoginView())
          : pagecontroller.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn).then((value) => increment());
  }

  onpressBackButton(){
        pagecontroller.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn).then((value) => decreament());
  }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() {
    print("increment");
    count.value++;
    update();
  }

  void decreament(){
    count.value--;
    update();
  }

}
