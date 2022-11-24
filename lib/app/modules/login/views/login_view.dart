import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/login/providers/sigb_In_UsingEmil.dart';
import 'package:little_dino_app/app/modules/register/views/register_view.dart';
import '../controllers/login_controller.dart';
import 'package:little_dino_app/app/modules/forgate_Password/views/forgate_password_main_view.dart';
import 'package:http/http.dart' as http;

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil().setWidth(540);
    ScreenUtil().setHeight(200);
    ScreenUtil().setSp(24);

    LoginController controller = Get.put(LoginController());



    return WillPopScope(
      onWillPop: () {
        controller.isLoaded.value = false;
        Get.to(LoginView());
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.orangeAccent.withOpacity(0.2),
          height: height,
          width: width,
          // padding: EdgeInsets.only(top: 60.sp),
          child: Obx(() => Stack(
              children: [
          Column(
          children: [
          SizedBox(height: 65.sp),
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(Constants.RIGHT_TOP_COLUD,width: 60.sp),
            ),
            SizedBox(height: 40.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(Constants.LEFT_TOP_COLUD,width: 100.sp),
                SvgPicture.asset(Constants.RIGHT_COLUD),
              ],
            )
            ],
          ),
          Container(
            height: height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 50.sp),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(Constants.LITTLE_DINO_LOGO,width: 123.sp),
                        Container(
                          width: width,
                          child: Text(
                            '     Login',
                            style: TextStyle(
                                color: ConstantsColors.orangeColor,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 30.sp),
                        FlutterWidgets.textField(
                            width: width*0.78,
                            fontsize: 17.sp,
                            height: 40.sp,
                            controller: controller.email,
                            hintText: 'Enter Email Address',
                            suffixImage: Constants.EMAIL_LOGO),
                        SizedBox(height: 10.sp) ,
                        FlutterWidgets.textField(
                            width: width*0.78,
                            fontsize: 17.sp,
                            height: 40.sp,
                            controller: controller.pass,
                            hintText: 'Enter Password',
                            isPassword: true,
                            suffixImage: Constants.PASSWORD_LOGO),
                        SizedBox(height: 13.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => Get.to(ForgatePasswordMainView()),
                              child: Text(
                                'Forgot Password?  ',
                                style: TextStyle(
                                    color: ConstantsColors.green,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 13.sp),
                        FlutterWidgets.button(
                            width: width,
                            height: 40.sp,
                            backgroundColor: Colors.lightBlueAccent.withOpacity(0.7),
                            borderColor: ConstantsColors.buttonColors,
                            content: Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w600)),
                            onTap: () async {
                              if(controller.email.text == ''){
                                FlutterWidgets.alertmesage(title: "Something was Wrong", message: "Please Enter Registered Email Id",fontsize: 20.sp,marginFormBottom: 20.sp);
                              }
                              else if(controller.pass.text == ''){
                                FlutterWidgets.alertmesage(title: "Something was Wrong", message: "Please Enter Right Password",fontsize: 20.sp,marginFormBottom: 20.sp);
                              }
                              else if (!GetUtils.isEmail(controller.email.text)) {
                                FlutterWidgets.alertmesage(title: "Something was Wrong", message: "Provide Email is Invalid Please Enter Valid Email Id in Proper Formate",fontsize: 20.sp,marginFormBottom: 20.sp);
                              }
                              else if(GetUtils.isLengthLessOrEqual(controller.pass.text, 8))
                              {
                                FlutterWidgets.alertmesage(title: "Password length is short", message: "Password length should be between 8 to 12",fontsize: 20.sp,marginFormBottom: 20.sp);
                              }
                              else {
                                try {
                                  String url = 'http://tubfl.com/littledino/public/api/v1/login';
                                  http.Response response = await http.post(
                                      Uri.parse(url),
                                      headers: {
                                        'auth-key': 'simplerestapi'
                                      },
                                      body: {
                                        'email': controller.email.text,
                                        'password': controller.pass.text
                                      });
                                  var result = jsonDecode(response.body);
                                  print("Result is -------------->$result");
                                  if(response.statusCode == 200){
                                    controller.isLoaded.value = true;
                                    OnlyEmailSign_In().getemailData(email: controller.email.text,isfromProfile: false);
                                  }
                                  else{
                                    controller.isLoaded.value = false;
                                    FlutterWidgets.alertmesage(title: "Something is Worng", message: "${result['message']}", fontsize: 20.sp, marginFormBottom: 20.sp);
                                  }
                                } catch (error) {
                                  print("Error is ------------------->$error");
                                }
                              }
                            }),
                        SizedBox(height: 10.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have An Account?',
                              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,color: ConstantsColors.fontColor),
                            ),
                            InkWell(
                              onTap: () => Get.to(RegisterView()),
                              child: Text(
                                '  Register',
                                style: TextStyle(
                                    color: ConstantsColors.pinckColor,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 13.sp),
                        SvgPicture.asset(Constants.OR_LOGO, width: width * 0.5.sp),
                        SizedBox(height: 13.sp),
                        FlutterWidgets.button(
                            width: width,
                            height: 45.sp,
                            backgroundColor: Colors.transparent,
                            borderColor: ConstantsColors.blackColor,
                            content: SvgPicture.asset(Constants.APPLE_LOGO, height: 25.sp),
                            onTap: () {}
                        ),
                        SizedBox(height: 10.sp),
                        FlutterWidgets.button(
                            width: width,
                            height: 45.sp,
                            backgroundColor: Colors.transparent,
                            borderColor: ConstantsColors.redColor,
                            content: SvgPicture.asset(Constants.GOOGLE_LOGO, height: 25.sp),
                            onTap: () => controller.signinInWithGoogle()
                        ),
                        SizedBox(height: 10.sp),
                        FlutterWidgets.button(
                            width: width,
                            height: 45.sp,
                            backgroundColor: Colors.transparent,
                            borderColor: Colors.blue,
                            content: SvgPicture.asset(Constants.FACEBOOK_LOGO, height: 25.sp),
                            onTap: () => controller.signInWithFacebook()
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.sp),
                  InkWell(
                    onTap: (){
                      final _myBox = Hive.box('users_Info');
                      final datas = _myBox.get(2);
                      print('_myBox.get -> ${_myBox.get(2)}');
                      _myBox.get(2) != null
                          ? _myBox.put(2 ,{
                            'uniqid':'Users',
                            'role':'Users',
                            'last_name':datas['last_name'],
                            'first_name':datas['first_name'],
                            'gender':datas['uniqid'],
                            'dob':datas['dob'],
                            'email':datas['email'],
                            'profile':datas['profile']
                          })
                          : _myBox.put(2 ,{
                            'uniqid':"Users",
                            'role':"Users",
                            'last_name':"Users",
                            'first_name':"Users",
                            'gender':"Users",
                            'dob':"Users",
                            'email':"Users",
                            'profile':"Users"
                          });
                      Get.to(BottomnavigationBarView());
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset("assets/login/bottom_full_Cloud.svg",color: ConstantsColors.whitecolor,width: 140.sp),
                        Container(
                          margin: EdgeInsets.only(left: 10.sp),
                          child: SvgPicture.asset(Constants.SKIP_BUTTON, height: 23.sp),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.sp),
                ],
              ),
            ),
          ),
            controller.isLoaded.value == true ? Container(
                width: width,
                height: height,
                color: Colors.black.withOpacity(0.4),
                child:AlertDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: Center(child: CircularProgressIndicator(color: ConstantsColors.orangeColor,strokeWidth: 5),
                )
              )
            ) : SizedBox.shrink(),
          ],
        )
      ),
     ),
    ),
   );
  }
}