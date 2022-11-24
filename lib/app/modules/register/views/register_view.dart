import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/login/views/login_view.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    RegisterController controller = Get.put(RegisterController());
    ScreenUtil().setSp(24);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.orangeAccent.withOpacity(0.2),
        width: width,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 70.sp),
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
                    Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.sp),
                          SvgPicture.asset(Constants.LITTLE_DINO_LOGO,width: 120.sp),
                          Container(
                            width: width,
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: ConstantsColors.pinckColor,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: 40.sp),
                          FlutterWidgets.textField(
                              width: 300.sp,
                              height: 40.sp,
                              fontsize: 17.sp,
                              controller: controller.firstName,
                              hintText: 'First Name',
                              suffixImage: Constants.NAME_LOGO),
                          SizedBox(height: 10.sp),
                          FlutterWidgets.textField(
                            width: 300.sp,
                              height: 40.sp,
                              fontsize: 17.sp,
                              controller: controller.lastName,
                              hintText: 'Last Name',
                              suffixImage: Constants.NAME_LOGO),
                          SizedBox(height: 10.sp),
                         FlutterWidgets.textField(
                            width: 300.sp,
                              height: 40.sp,
                              fontsize: 17.sp,
                              controller: controller.email,
                              hintText: 'Enter Email Address',
                              suffixImage: Constants.EMAIL_LOGO),
                          SizedBox(height: 10.sp),
                          FlutterWidgets.textField(
                            width: 300.sp,
                              height: 40.sp,
                              fontsize: 17.sp,
                              controller: controller.password,
                              hintText: 'Enter Password',
                              isPassword: true,
                              suffixImage: Constants.PASSWORD_LOGO),
                          SizedBox(height: 10.sp),
                          FlutterWidgets.textField(
                            width: 300.sp,
                              height: 40.sp,
                              fontsize: 17.sp,
                              controller: controller.confirmPassword,
                              hintText: 'Enter Confirm Password',
                              isPassword: true,
                              suffixImage: Constants.PASSWORD_LOGO),
                          SizedBox(height: 25.sp),
                          FlutterWidgets.button(
                              width: width,
                              height: 40.sp,
                              backgroundColor: Colors.lightBlueAccent.withOpacity(0.7),
                              borderColor: Colors.blue,
                              content: Text('Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600)),
                              onTap: () async {
                                if (!GetUtils.isEmail(controller.email.text)) {
                                  FlutterWidgets.alertmesage(
                                      title: "Incorrect Email",
                                      message: "Provide Email is Invalid , please Enter Valid Email Id in proper Formate",
                                      fontsize: 20.sp,
                                      marginFormBottom: 20.sp);
                                }
                                else if (GetUtils.isLengthLessOrEqual(
                                    controller.password.text, 8)) {
                                  FlutterWidgets.alertmesage(
                                      title: "Password length is short",
                                      message: "Password length should be Between 8 to 12",
                                      fontsize: 20.sp,
                                      marginFormBottom: 20.sp);
                                }
                                else {
                                  http.Response response = await http.post(
                                      Uri.parse(
                                          'http://tubfl.com/littledino/public/api/v1/add/register'),
                                      headers: {'auth-key': 'simplerestapi'},
                                      body: {
                                        'first_name': controller.firstName.text,
                                        'last_name': controller.lastName.text,
                                        'email': controller.email.text,
                                        'dob': '2001-2-2',
                                        'gender': 'female',
                                        'password': controller.password.text,
                                        'confirm_password': controller.confirmPassword.text,
                                      }
                                  );
                                  if (response.statusCode == 200) {
                                    Get.to(LoginView());
                                  } else {
                                    final result = json.decode(response.body);
                                    Map mapdata = result['data'];
                                    FlutterWidgets.alertmesage(title: 'Something is Wrong',message: "${mapdata.values.toString().replaceAll("(", "").replaceAll(")","")}",marginFormBottom: 20.sp,fontsize: 20.sp)  ;
                                  }
                                }
                              }
                          ),
                          SizedBox(height: 8.sp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already Have An Account?',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600,color: ConstantsColors.fontColor,),
                              ),
                              InkWell(
                                onTap: () => Get.to(LoginView()),
                                child: Text(
                                  '  Login',
                                  style: TextStyle(
                                      color: ConstantsColors.pinckColor,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.sp),
                    Container(
                        width: width,
                        height: 130.sp,
                        padding : EdgeInsets.only(left: 20.sp,right: 10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset("assets/login/Bottom_girl.svg"),
                            Image.asset("assets/login/register_bottom_dinosor.png",fit: BoxFit.cover)
                          ],
                        )
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
