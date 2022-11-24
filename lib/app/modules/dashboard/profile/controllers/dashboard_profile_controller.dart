import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/profile/Provider.dart';

class DashboardProfileController extends GetxController {
  //TODO: Implement DashboardProfileController

  final count = 0.obs;
  TextEditingController cntfirstname = TextEditingController();
  TextEditingController cntlastname = TextEditingController();
  TextEditingController cntBirthDate = TextEditingController();
  RxString firstname = ''.obs;
  RxString lastname = ''.obs;

  var selectedImagePath = ''.obs;
  RxBool isEdit = false.obs;

  void getImage({required ImageSource imagesounrce}) async {
     final pickedFile = await ImagePicker().pickImage(source: imagesounrce);
     if(pickedFile != null){
       selectedImagePath.value = pickedFile.path;
       print("pickedFile.path ---------------------------->${pickedFile.path}");
     }
     else{
       print("No Image Selected");
     }
  }


  void ontap(){
    isEdit.value = false;
    final _myBox = Hive.box('users_Info');
    // LocalVariables.profilePath
    firstname.value = cntfirstname.text;
    lastname.value = cntlastname.text;
    LocalVariables.userId != "Users" ? ProfileData().updateProfileInfo(
        profile: selectedImagePath.value != '' ? selectedImagePath.value : LocalVariables.profilePath,
        bornDate: cntBirthDate.text,
        firstName:cntfirstname.text,
        lastName:cntlastname.text,
        userId:LocalVariables.userId
    ) : _myBox.put(2, {
      'uniqid': "Users",
      'role': "Users",
      'last_name': cntlastname.text,
      'first_name': cntfirstname.text,
      'gender': "Users",
      'dob': cntBirthDate.text,
      'email': "Users",
      'profile': selectedImagePath != '' ? "$selectedImagePath" : "Users"
    });

    LocalVariables.getDataFrom_hive();
    print("_myBox.get(2) ---------------->${_myBox.get(2)}");
  }


  AnalyticsController analyticsController = Get.put(AnalyticsController());

  @override
  void onInit() {
    super.onInit();
    analyticsController.androidButtonEvent(screenName: 'ProfileScreen_Android', screenClass: 'ProfileScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
