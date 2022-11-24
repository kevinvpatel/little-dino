import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/modules/forgate_Password/views/ResetPassword_screen.dart';
import 'package:little_dino_app/app/modules/forgate_Password/views/forgetPassword_screen.dart';
import 'package:little_dino_app/app/modules/forgate_Password/views/verificationScreen.dart';
import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/modules/login/views/login_view.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgatePasswordController extends GetxController {
  //TODO: Implement ForgatePasswordController

   late RxInt count;

   final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  List bodyscreens = [ForgetPasswordScreen(),verificationScreen(),ResetPasswordScreen()];
  PageController pagecontroller = PageController();
  TextEditingController email = TextEditingController();
  String uniq_Id = '';

  // TextEditingController otpController = TextEditingController();
   RxString otp = ''.obs;

  List buttonTitles = ["Send","Verify","Update"];

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<String?> getUserList() async {
    String? uniqId;
    try{
      final url = Uri.parse("http://tubfl.com/littledino/public/api/v1/users");
      final response = await http.get(url, headers: {'auth-key' : 'simplerestapi'});
      if(response.statusCode == 200) {
        Map jsonList = json.decode(response.body);
        // List<Map<String, dynamic>> lstUser = [];
        jsonList['data'].forEach((val) {
          if(val['email'] == email.text) {
            uniqId = val['uniqid'];
            uniq_Id = val['uniqid'];
          }
          // lstUser.add(val);
        });
      }
    } catch(err) {
      print('getUserList Api err -> $err');
    }
    return uniqId;
  }


   Future<Map<String, dynamic>> sendEmail() async{
     Map<String, dynamic> mapResult = {};
    try {
      print('sendEmail email.text -> ${email.text}');
      final request = http.MultipartRequest('POST', Uri.parse("http://tubfl.com/littledino/public/api/v1/sent/code"));
      request.fields.addAll({"user_id" : uniq_Id, "email" : email.text});
      request.headers.addAll({'contentType' : 'application/json', 'auth-key' : 'simplerestapi'});
      http.StreamedResponse response = await request.send();
      final result = String.fromCharCodes(await response.stream.toBytes());
      final map = json.decode(result);

      print('sendEmail response.statusCode -> ${response.statusCode}');
      print('sendEmail response.body -> ${map}');
      mapResult = map;

    } catch(err) {
      print('sendEmail Api err -> $err');
    }
   return mapResult;
  }


  Future<Map<String, dynamic>> verifyOTP() async {
    bool isSuccess = false;
    Map<String, dynamic> mapResult = {};
    try {
      print('otp.value -> ${otp.value}');
      final request = http.MultipartRequest('POST', Uri.parse('http://tubfl.com/littledino/public/api/v1/verify/token'));
      request.fields.addAll({"user_id" : uniq_Id, "token" : otp.value});
      request.headers.addAll({'contentType' : 'application/json', 'auth-key' : 'simplerestapi'});
      http.StreamedResponse response = await request.send();
      final result = String.fromCharCodes(await response.stream.toBytes());
      final map = json.decode(result);

      print('verifyOTP response.statusCode -> ${response.statusCode}');
      print('verifyOTP response.body -> ${map}');
      mapResult = map;

      if(response.statusCode == 200) {
        isSuccess = true;
      } else {
        isSuccess = false;
      }
    } catch(err) {
      print('verifyOTP Api err -> $err');
    }
    return mapResult;
  }

  Future<Map<String, dynamic>> changePassword() async {
    Map<String, dynamic> mapResult = {};
    try {
      final request = http.MultipartRequest('POST', Uri.parse('http://tubfl.com/littledino/public/api/v1/reset/password'));
      request.fields.addAll({
        'user_id' : uniq_Id,
        'email' : email.text,
        'new_password' : newPassword.text,
        'confirm_password' : confirmPassword.text,
      });
      request.headers.addAll({'contentType' : 'application/json', 'auth-key' : 'simplerestapi'});
      http.StreamedResponse response = await request.send();
      final result = String.fromCharCodes(await response.stream.toBytes());
      final map = json.decode(result);
      print('changePassword response.statusCode -> ${response.statusCode}');
      print('changePassword response.body -> ${map}');
      mapResult = map;
    } catch(e) {
      print('changePassword Api err -> $e');
    }
    return mapResult;
  }

  bottomSheet({required BuildContext context, required double width}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
          )
      ),
      builder: (context) {
        return Container(
          width: width,
          height: 330.sp,
          padding: EdgeInsets.only(left: 20,right: 10,top: 10,bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10)
              )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Update Successfully",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600,color: ConstantsColors.fontColor)),
                  Container(
                    height: 28,
                    width: 28,
                    child: CupertinoButton(
                        color: Color.fromRGBO(249, 77, 122, 1),
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(100),
                        child: Icon(Icons.close,color: ConstantsColors.whitecolor),
                        onPressed: (){
                          Get.back();
                        }
                    ),
                  )
                ],
              ),
              SizedBox(height: 5.sp),
              Divider(color: ConstantsColors.grayColor.withOpacity(0.2),thickness: 1.5),
              SvgPicture.asset("assets/forgatePassword/successfully_msg.svg"),
              SizedBox(height: 10.sp),
              Text("Your Password Update Successfully Now You",style: TextStyle(fontSize: 17.5.sp,color: ConstantsColors.lightgrayColor,fontWeight: FontWeight.w500)),
              Text("Login And Access All The Features.",style: TextStyle(fontSize: 17.5.sp,color: ConstantsColors.lightgrayColor,fontWeight: FontWeight.w500)),
              Spacer(),
              Container(
                height: 45.sp,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20.sp,right: 20.sp),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(95, 207, 255, 1),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Color.fromRGBO(29, 123, 212, 1)
                    )
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(LoginView());
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all( Color.fromRGBO(95, 207, 255, 1)),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          )
                      )
                  ),
                  child: Text("Login", style: TextStyle(color: ConstantsColors.whitecolor, fontWeight: FontWeight.w600, fontSize: 20.sp)),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  AnalyticsController analyticsController = Get.put(AnalyticsController());

  @override
  void onInit() {
    super.onInit();
    count = 0.obs;
    analyticsController.androidButtonEvent(screenName: 'ForgetPasswordScreen_Android', screenClass: 'ForgetPasswordScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() {
    print('count incremented');
    count.value++;
  }
  decrement() => count.value--;
}
