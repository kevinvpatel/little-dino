import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/login/User.dart';
import 'package:little_dino_app/app/modules/login/controllers/login_controller.dart';
import 'package:little_dino_app/app/modules/login/providers/sigb_In_UsingEmil.dart';

class LoginProviders {
  UserData? user;
  Future loginByAapi({required String email, required String pass}) async {
    try {
      String url = 'http://tubfl.com/littledino/public/api/v1/login';
      http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            'auth-key': 'simplerestapi'
          },
          body: {
            'email': email,
            'password': pass
          });
      var result = jsonDecode(response.body);
      if(response.statusCode == 200){
        OnlyEmailSign_In().getemailData(email: email,isfromProfile: false);
      }
      else{
        FlutterWidgets.alertmesage(title: "Something is Wrong", message: "${result['message']}", fontsize: 20, marginFormBottom: 20);
        Get.back();
      }
    } catch (error) {
      print("Error is ------------------->$error");
    }
  }
}
