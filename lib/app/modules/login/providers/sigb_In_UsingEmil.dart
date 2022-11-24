import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/global_variable.dart';
import 'package:little_dino_app/app/modules/login/User.dart';
import 'package:little_dino_app/app/modules/login/controllers/login_controller.dart';



class OnlyEmailSign_In{

  Future getemailData({required String email,required bool isfromProfile}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    LoginController loginControler = LoginController();
    UserData? user;
    bool flage = false;
    Map<String,dynamic> data = {};

    try{
      final _myBox = Hive.box('users_Info');
      if(Response().statusCode == null){
        googleSignIn.disconnect();
      }
      http.Response response = await http.get(
          Uri.parse('http://tubfl.com/littledino/public/api/v1/users'),
          headers: { 'auth-key' : 'simplerestapi'}
      );
      user = UserData.fromJson(json.decode(response.body));
      user.data!.forEach((element) {
        print('element.email -> ${element.email}');
        print('element.firstName -> ${element.firstName}');
        print("${element.email == email}");
        if(element.email == email) {
          flage = true;
          data = element.toJson();
          _myBox.put(1, element.toJson());
          LocalVariables.getDataFrom_hive();
        }
      });
      if(isfromProfile == false && flage == true){
        FirebaseFirestore.instance.collection('users').doc(data['uniqid']).set(data);
        FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Category_Saved');
        FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Quiz_Saved');
        FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent');
        FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('savedCategories');
        Get.to(BottomnavigationBarView());
      }
      else if(isfromProfile == false && flage == false){
        loginControler.logOut();
        Get.snackbar("You cann't Login", "Email is not Valide , Register Now!");
      }
    }catch(error){
      print("Error during Login Time ------------------>$error");
      googleSignIn.disconnect();
    }
  }

}