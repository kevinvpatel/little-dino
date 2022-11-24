import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/modules/login/views/login_view.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    OnboardingController controller = Get.put(OnboardingController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil().setSp(24);
    controller.count.value = 0 ;
    LiquidController liquidController = LiquidController();
    arrowsButtonNext({required Function() fun}){
      return InkWell(
        onTap: fun,
        child: Container(
            margin: EdgeInsets.only(top: 20.sp, left: 20.sp),
            child: SvgPicture.asset(Constants.backArrow,
                width: 40.sp,
                color: controller.color[controller.count.value])),
      );
    }
    arrowsButtonPrevious({required Function() fun}){
      return InkWell(
        onTap: fun,
        child: Container(
            margin: EdgeInsets.only(top: 20.sp, left: 20.sp),
            child: SvgPicture.asset(Constants.backArrow,
                width: 40.sp,
                color: controller.color[controller.count.value])),
      );
    }

    // return SafeArea(
    //   left: false,
    //   right: false,
    //   child: Scaffold(
    //     body: Container(
    //       // color: Colors.green,
    //       padding: EdgeInsets.zero,
    //       alignment: Alignment.center,
    //       child: PageView.builder(
    //         itemCount: 3,
    //         physics: NeverScrollableScrollPhysics(),
    //         controller: controller.pagecontroller,
    //         onPageChanged: (int) {
    //         },
    //         itemBuilder: (context, index) {
    //           return Container(
    //             width: width,
    //             height: height,
    //             child: Obx(() => Stack(
    //               children: [
    //                 Image.asset(controller.BackGroundImages[index],
    //                     width: width, height: height, fit: BoxFit.fill),
    //                 Align(
    //                     alignment: Alignment.center,
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         SizedBox(height: 10.sp),
    //                         Image.asset(controller.centerImages[index],
    //                             width: 250.sp),
    //                         SizedBox(height: 10.sp),
    //                         Text(controller.text1[index],
    //                             style: TextStyle(
    //                                 fontSize: 20.sp, color: ConstantsColors.whitecolor,fontWeight: FontWeight.w500)),
    //                         Text(
    //                           controller.text2[index],
    //                           style: TextStyle(
    //                               fontSize: 20.sp, color: ConstantsColors.whitecolor,fontWeight: FontWeight.w500),
    //                         )
    //                       ],
    //                     )),
    //                 Align(
    //                     alignment: Alignment.bottomCenter,
    //                     child: SvgPicture.asset(
    //                       controller.the_clouds[index],
    //                       width: width,
    //                       fit: BoxFit.cover,
    //                     )),
    //                controller.count.value != 0?
    //                arrowsButton(fun:controller.onpressBackButton )
    //                :SizedBox.shrink()
    //
    //               ],
    //             )),
    //           );
    //         },
    //       ),
    //     ),
    //     floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    //     floatingActionButton: Obx(() => RotatedBox(
    //         quarterTurns: 2,
    //         child: arrowsButton(fun: controller.onpressNextButton)
    //     )),
    //   )
    // );

    Widget onboardingScreenDesign(int index){
      return Container(
        width: width,
        height: height,
        color: controller.color[index],
        child: Stack(
          children: [
            //   Image.asset(controller.BackGroundImages[index],
            //       width: width, height: height, fit: BoxFit.fill),
            Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.sp),
                    Image.asset(controller.centerImages[index],
                        width: 250.sp),
                    SizedBox(height: 10.sp),
                    Text(controller.text1[index],
                        style: TextStyle(
                            fontSize: 23.sp, color: ConstantsColors.whitecolor,fontWeight: FontWeight.w500)),
                    Text(
                      controller.text2[index],
                      style: TextStyle(
                          fontSize: 23.sp, color: ConstantsColors.whitecolor,fontWeight: FontWeight.w500),
                    )
                  ],
                )),
            Positioned(
                top: 0,
                left: 0,
                child: SvgPicture.asset("assets/onboarding/top_left_cloud.svg")
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset("assets/onboarding/bottom_right_cloud.svg")
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  controller.the_clouds[index],
                  width: width,
                  fit: BoxFit.cover,
                )),


          ],
        ),
      );
    }


    return Scaffold(
      body: Obx(() => Stack(
        children: [
          LiquidSwipe(
            enableLoop: false,
            initialPage: 0,
            currentUpdateTypeCallback: (index){
              print("currentUpdateTypeCallback Index --------------->${index.index}");
            },
            liquidController: liquidController,
            slideIconWidget: Container(
              child: RotatedBox(
                  quarterTurns: 2,
                  child: arrowsButtonNext(fun: (){
                    final page = liquidController.currentPage + 1;
                    liquidController.animateToPage(
                        page: liquidController.currentPage >= 3 ? 0 :page,
                        duration: 400
                    );
                  })
              ),
            ),
            onPageChangeCallback: (index){
              controller.count.value = index;
              controller.count.value == 3 ? Get.to(LoginView()) : '';
            },
            positionSlideIcon: 1,
            pages: [
              onboardingScreenDesign(0),
              onboardingScreenDesign(1),
              onboardingScreenDesign(2),
              LoginView(),
            ],
          ),
          controller.count.value != 0  && controller.count.value != 3?Positioned(
              top: 0,
              left: 0,
              child:RotatedBox(
                  quarterTurns:4,
                  child: arrowsButtonPrevious(fun: (){
                    final page = liquidController.currentPage - 1;
                    liquidController.animateToPage(
                        page: page,
                        duration: 400
                    );
                  })
              )
      ): SizedBox.shrink(),

        ],
      )),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //     floatingActionButton: Obx(() => RotatedBox(
      //         quarterTurns: 2,
      //         child: arrowsButton(fun: controller.onpressNextButton)
      //     )),
    );
  }
}
