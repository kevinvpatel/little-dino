    import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/forgate_Password/controllers/forgate_password_controller.dart';
import 'package:little_dino_app/app/modules/login/views/login_view.dart';

class ForgetPasswordScreen extends GetView<ForgatePasswordController>{
  @override
  Widget build(BuildContext context) {
    ScreenUtil().setSp(24);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: ConstantsColors.whitecolor,
        resizeToAvoidBottomInset: true, 
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            color: ConstantsColors.backgroundcolor,
            child: Column(
              children: [
                SizedBox(height: 40.sp),
                InkWell(
                  onTap: () async {
                    controller.count.value = 0;
                    Get.to(LoginView());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/onboarding/onboarding_2/back_arrow.svg",color: Color.fromRGBO(141, 182, 0, 1)),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset("assets/forgatePassword/colud_right.svg", width: width * 0.25),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset("assets/forgatePassword/colud_left.svg", width: width * 0.32),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 80.sp),
                    SvgPicture.asset("assets/forgatePassword/formate.svg", width: width * 0.35),
                    SvgPicture.asset("assets/forgatePassword/colud_right_big.svg")
                  ],
                ),
                SizedBox(height: 20.sp),
                Text("FORGET PASSWORD",style: TextStyle(color: ConstantsColors.pinckColor.withOpacity(0.8) ,fontSize: 25.sp,fontWeight: FontWeight.w700)),
                SizedBox(height: 10.sp),
                Text("Just Enter Your Email And We'll Send",style: TextStyle(fontSize: 15.sp,color: Colors.grey,fontWeight: FontWeight.w600)),
                Text("Verification Code",style: TextStyle(fontSize: 15.sp,color: ConstantsColors.grayColor,fontWeight: FontWeight.w600)),
                SizedBox(height: 15.sp),
               Container(
                 padding: EdgeInsets.symmetric(horizontal: 20.sp),
                 child: FlutterWidgets.textField(
                     width: 300.sp,
                     height: 40.sp,
                     fontsize: 17.sp,
                     controller: controller.email,
                     keyboardType: TextInputType.emailAddress,
                     hintText: 'Enter Email Address',
                     suffixImage: Constants.EMAIL_LOGO),
               )
              ],
            ),
          ),
        ),
    );
  }
}