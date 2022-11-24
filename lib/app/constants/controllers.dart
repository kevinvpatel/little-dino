import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';


class FlutterWidgets{



  static button({
    required double width,
    required Color backgroundColor,
    required Color borderColor,
    required Widget content,
    required double height,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: content),
    );
  }



  static textField(
      {required double width,
        required String hintText,
        required String suffixImage,
        required double height,
        required double fontsize,
        TextInputType? keyboardType,
        bool isPassword = false,
        required TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 2)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: height,
            width: width-30,
            child: TextField(
              obscureText: isPassword,
              style: TextStyle(
                  fontSize: fontsize,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
                  controller: controller,
                  keyboardType: keyboardType ?? TextInputType.text,
                  decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: fontsize, fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.only(left: 25, right: 10,top: 0,bottom: 10),
                  border: InputBorder.none),
            ),
          ),
          SvgPicture.asset(suffixImage, height: 34),
          SizedBox(width: 15)
        ],
      ),
    );
  }


  static backtoHomeScreen({required double width ,required Function() fun}){
    return InkWell(
      onTap: fun,
      child: SvgPicture.asset(
        Constants.HOME,
        color: ConstantsColors.whitecolor,
        fit: BoxFit.cover,
        width: width,
      ),
    );
  }


  static noDataFound({required double headerFontSize,required double descriptionFontSize,required double space,required double width,required double height}){
    return Container(
      width: width,
      height: height,
      child: Column(
        children: [
          Spacer(),
          Text("Aaah! Little Dino Is Lost",style: TextStyle(color: ConstantsColors.fontColor,fontSize: headerFontSize,fontWeight: FontWeight.w800)),
          SizedBox(height: space),
          Text("Oops! Looks like the page is Gone ...",style: TextStyle(color: ConstantsColors.grayColor,fontSize: descriptionFontSize,fontWeight: FontWeight.w500)),
          Spacer(),
          SvgPicture.asset("assets/no_data_found.svg",alignment: Alignment.bottomCenter)
        ],
      ),
    );
  }

  static disconnected(){
    return Center(
      child: CircularProgressIndicator(color: ConstantsColors.orangeColor),
    );
  }


  static alertmesage({required title,required message,required fontsize , required marginFormBottom}){
    return Get.snackbar(
              "",
              "",
               titleText: Text(title,style: TextStyle(color: ConstantsColors.whitecolor,fontSize: fontsize-3,fontWeight: FontWeight.w600)),
               messageText: Text("$message",style: TextStyle(color: ConstantsColors.whitecolor,fontSize: fontsize-7)),
               snackPosition: SnackPosition.BOTTOM,
               colorText: ConstantsColors.whitecolor,
               backgroundColor: ConstantsColors.orangeColor,
                margin: EdgeInsets.only(bottom: marginFormBottom,left: marginFormBottom,right: marginFormBottom)
    );
  }
}