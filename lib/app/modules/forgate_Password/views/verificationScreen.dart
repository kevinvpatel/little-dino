import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/modules/forgate_Password/controllers/forgate_password_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class verificationScreen extends GetView<ForgatePasswordController>{
  @override
  Widget build(BuildContext context) {
    ScreenUtil().setSp(24);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ConstantsColors.whitecolor,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        height: height,
        color: ConstantsColors.backgroundcolor,
        child: Column(
          children: [
            SizedBox(height: 40.sp),
            InkWell(
              onTap: () async {
                await controller.pagecontroller.previousPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn).then((value) => controller.decrement());
                print("Count value ----------->${controller.count.value}");
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/onboarding/onboarding_2/back_arrow.svg",color: ConstantsColors.green),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset("assets/forgatePassword/colud_right.svg",width: width * 0.25),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset("assets/forgatePassword/colud_left.svg",width: width * 0.32),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 80.sp),
                SvgPicture.asset("assets/forgatePassword/verification.svg",width: width * 0.35),
                SvgPicture.asset("assets/forgatePassword/colud_right_big.svg")
              ],
            ),
            SizedBox(height: 20.sp),
            Text("ENTER 6 DIGIT CODE",style: TextStyle(color: ConstantsColors.pinckColor.withOpacity(0.8) ,fontSize: 25.sp,fontWeight: FontWeight.w700)),
            SizedBox(height: 10.sp),
            Text("Enter The Verification Code We",style: TextStyle(fontSize: 15.sp,color: ConstantsColors.grayColor,fontWeight: FontWeight.w500)),
            Text("just Sent You On Your Email Address",style: TextStyle(fontSize: 15.sp,color: ConstantsColors.grayColor,fontWeight: FontWeight.w500)),
            SizedBox(height: 15.sp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.sp),
              child: PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    color: ConstantsColors.grayColor.withOpacity(0.2),
                    spreadRadius: 2,
                    offset: Offset(0,3)
                  )
                ],
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  fieldOuterPadding: EdgeInsets.zero,
                  fieldHeight:40.sp,
                  fieldWidth: 40.sp,
                  selectedFillColor: ConstantsColors.whitecolor,
                  inactiveFillColor: ConstantsColors.whitecolor,
                  inactiveColor: ConstantsColors.whitecolor,
                  selectedColor : ConstantsColors.grayColor,
                  activeColor: ConstantsColors.whitecolor,
                  activeFillColor: ConstantsColors.whitecolor,
                ),
                appContext: context,
                enableActiveFill: true,
                enablePinAutofill: true,
                scrollPadding: EdgeInsets.zero,
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                cursorColor: ConstantsColors.fontColor,
                // controller: controller.otpController,
                onCompleted: (otp) {
                  print("Completed -> $otp");
                  controller.otp.value = otp;
                },
                onChanged: (otp) {
                  print("otp -------------> $otp");
                  controller.otp.value = otp;
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),
            ),
            Text("Resend Code",style: TextStyle(fontSize: 15.sp,color: ConstantsColors.green,fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}