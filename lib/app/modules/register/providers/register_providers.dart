import 'dart:convert';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/login/views/login_view.dart';
import 'package:http/http.dart' as http;

class RegisterProvider {
  Future registerProvider(
      {required String first_name,
      required String last_name,
      required String email,
      required String password,
      required String confirm_password,
      }) async {

    try{
      var headers = {
        'auth-key' : 'simplerestapi'
      };
      var request = http.MultipartRequest('POST', Uri.parse('http://tubfl.com/littledino/public/api/v1/add/register'));
      request.fields.addAll(
          {
            'first_name': "$first_name",
            'last_name': "$last_name",
            'email': "$email",
            'dob': '2001-2-2',
            'gender': 'female',
            'password': "$password",
            'confirm_password': "$confirm_password",
          }
      );
      request.files.add(await http.MultipartFile.fromString('profile', 'http://tubfl.com/littledino/public/uploads/user/2022/10/user_1665640260_50x50.png',filename: ''));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if(response.statusCode == 200){
        final result = String.fromCharCodes(await response.stream.toBytes());
        Map mapresults = json.decode(result);
        FlutterWidgets.alertmesage(title: '',message: "You are Register Successfully",marginFormBottom: 20,fontsize: 20);
        Get.to(LoginView());
      }else{
        final result = String.fromCharCodes(await response.stream.toBytes());
        Map mapresults = json.decode(result);
        FlutterWidgets.alertmesage(title: 'Something is Wrong',message: "${mapresults['data']['email'] ?? mapresults['data']['password']}",marginFormBottom: 20,fontsize: 20)  ;
      }
    }catch(error){
      print("Error- ---------->${error}");
    }
  }
}
