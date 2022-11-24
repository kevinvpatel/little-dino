import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/forgate_Password/controllers/forgate_password_controller.dart';

class ResetPasswordScreen extends GetView<ForgatePasswordController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().setSp(24);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ForgatePasswordController controller = Get.put(ForgatePasswordController());

    Widget textFields({required String hint, required TextEditingController controller}){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.sp),
        child: FlutterWidgets.textField(
        width: width*0.79,
        fontsize: 17.sp,
        height: 40.sp,
        controller: controller,
        keyboardType: TextInputType.visiblePassword,
        hintText: hint,
        suffixImage: Constants.PASSWORD_LOGO),
      );
    }

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
                  print("Count value ----------->${controller.count.value}");
                  await controller.pagecontroller.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn).then((value) => controller.decrement());
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
                child: SvgPicture.asset("assets/forgatePassword/colud_right.svg",width: 100.sp),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset("assets/forgatePassword/colud_left.svg",width: 120.sp),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 80.sp),
                  SvgPicture.asset("assets/forgatePassword/new_password.svg",width: 150.sp,),
                  SvgPicture.asset("assets/forgatePassword/colud_right_big.svg")
                ],
              ),
              SizedBox(height: 20.sp),
              Text("RESET PASSWORD",style: TextStyle(color: ConstantsColors.pinckColor.withOpacity(0.8) ,fontSize: 25.sp,fontWeight: FontWeight.w700)),
              SizedBox(height: 10.sp),
              Text("Set The New Password For Your Acount So",style: TextStyle(fontSize: 15.sp,color: ConstantsColors.grayColor,fontWeight: FontWeight.w600)),
              Text("You Can Login And Access All The Features.",style: TextStyle(fontSize: 15.sp,color:ConstantsColors.grayColor,fontWeight: FontWeight.w600)),
              SizedBox(height: 15.sp),
              textFields(hint: 'New Password', controller: controller.newPassword),
              SizedBox(height: 10.sp),
              textFields(hint: 'Confirm Password', controller: controller.confirmPassword),
            ],
          ),
        ),
      ),
    );
  }
}