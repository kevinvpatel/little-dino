import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';

class Templates {
   static Widget detailsScreens({required bool backarrowISDisplay,required context,required String title,required Container cont,required String svgImagePath,required Function() onTap,Widget? floattingButton,FloatingActionButtonLocation? floattinButtonLocation,Function()? ontapback}){
     double width  = MediaQuery.of(context).size.width;
     double height = MediaQuery.of(context).size.height;
     ScreenUtil().setSp(24);
      return SafeArea(
         top: false,
         bottom: true,
         child: Scaffold(
           backgroundColor: Colors.white,
           body: Container(
             color: Colors.orangeAccent.withOpacity(0.2),
             child: Column(
               children: [
                 ///Appbar
                 Container(
                   padding: EdgeInsets.only(left: 18.sp, right: 18.sp, bottom: 22.sp, top: 45.sp),
                   decoration: BoxDecoration(
                       color: Colors.orangeAccent,
                       borderRadius:  BorderRadius.only(bottomRight: Radius.circular(30))),
                   child: Row(
                     children: [
                       backarrowISDisplay == true ?InkWell(
                           onTap: ontapback??(){},
                           child: SvgPicture.asset("assets/appbar/left-arrow.svg",
                               width: 30.sp, fit: BoxFit.cover)):SizedBox.shrink(),
                       SizedBox(width: 15.sp),
                       Text(title,
                           style: TextStyle(
                               fontSize: 22.sp,
                               color: ConstantsColors.whitecolor,
                               fontWeight: FontWeight.w600)),
                       Spacer(),
                       InkWell(
                         onTap: onTap,
                         child: SvgPicture.asset(
                           svgImagePath,
                           fit: BoxFit.cover,
                           color: ConstantsColors.whitecolor,
                           width: 20.sp,
                         ),
                       )
                     ],
                   ),
                 ),

                 ///Body
                 Expanded(
                   child: Container(
                     width: width,
                     color: Colors.orangeAccent,
                     child: Container(
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.only(topLeft: Radius.circular(30))
                       ),
                       child: Container(
                         width: width,
                         height: height,
                         color: ConstantsColors.backgroundcolor,
                         child: cont,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           ),
           floatingActionButtonLocation: floattinButtonLocation,
           floatingActionButton: floattingButton,
         )
     );
    }
}
