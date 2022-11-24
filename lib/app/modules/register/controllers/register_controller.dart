import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/modules/register/providers/register_providers.dart';

class RegisterController extends GetxController {
  //TODO: Implement RegisterController

  final count = 0.obs;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  void registerwithApi() => RegisterProvider().registerProvider(first_name: firstName.text,last_name:  lastName.text,email: email.text,password: password.text,confirm_password: confirmPassword.text);


  AnalyticsController analyticsController = Get.put(AnalyticsController());

  @override
  void onInit() {
    super.onInit();
    firstName.text = '';
    lastName.text = '';
    email.text = '';
    password.text = '';
    confirmPassword.text = '';
    analyticsController.androidButtonEvent(screenName: 'RegisterScreen_Android', screenClass: 'RegisterScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



}
