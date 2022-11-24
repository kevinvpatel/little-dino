import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';

class FinishScreen extends GetView{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil().setSp(24);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    BottomnavigationBarController bottomnavigationBarController = Get.put(BottomnavigationBarController());
    return Scaffold(
      backgroundColor: ConstantsColors.whitecolor,
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(left: 20.sp,right: 20.sp,bottom: 20.sp),
        color: ConstantsColors.backgroundcolor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(height: 60.sp,),
            SvgPicture.asset("assets/FinishScreen.svg",width: 300.sp,fit: BoxFit.cover ),
            SizedBox(height: 60.sp),
            Text("Finish Learning",style: TextStyle(fontSize: 29.sp,color: ConstantsColors.fontColor,fontWeight: FontWeight.w600)),
            SizedBox(height: 13.sp),
            Text("Lorem Ipsum is simply dummy text of the",style: TextStyle(color: ConstantsColors.grayColor,fontSize: 20.sp,fontWeight: FontWeight.w500)),
            SizedBox(height: 3.sp),
            Text("printing and typesetting industry.",style: TextStyle(color: ConstantsColors.grayColor,fontSize: 20.sp,fontWeight: FontWeight.w500)),
            Spacer(),
            FlutterWidgets.button(
                width: width,
                height: 45.sp,
                backgroundColor: Colors.lightBlueAccent.withOpacity(0.7),
                borderColor: ConstantsColors.buttonColors,
                content: Text('Attempt Quiz',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600)),
                onTap: () {
                  bottomnavigationBarController.selectedPage.value = 2;
                  Get.to(BottomnavigationBarView());
                }),
            SizedBox(height: 10.sp),
            FlutterWidgets.button(
                width: width,
                height: 45.sp,
                backgroundColor: Color.fromRGBO(141, 182, 0, 1),
                borderColor: Color.fromRGBO(104, 134, 0, 1),
                content: Text('Learn More',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600)),
                onTap: () {
                  bottomnavigationBarController.selectedPage.value = 1;
                  Get.to(BottomnavigationBarView());
                }),
          ],
        ),
      ),
    );
  }
  
}