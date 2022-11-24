import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/level/quizlevel_model.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/views/levelscreens_quiz_screen_view.dart';
import '../controllers/dashboard_level_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class DashboardLevelView extends GetView<DashboardLevelController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil().setSp(24);
    DashboardLevelController controller = Get.put(DashboardLevelController());
    BottomnavigationBarController bottomnavigationBarController =  Get.put(BottomnavigationBarController());

    String? title = Get.arguments != null ?Get.arguments['title'] : '';
    String? quiz_uinqId = Get.arguments != null ?Get.arguments['Quiz_uinqId']:'';
    String? categories_id = Get.arguments != null ? Get.arguments['Categories_id']:'';
    print("Categories_id ---------------------------------------->$categories_id");
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Templates.detailsScreens(
      title: "${title!= ''?title:'Level'}",
      context: context,
      backarrowISDisplay: true,
      ontapback: (){
        Get.back();
      },
      svgImagePath: Constants.HOME,
      onTap: (){
        bottomnavigationBarController.selectedPage.value = 0;
        bottomnavigationBarController.advancedDrawerController.hideDrawer();
        Get.to(BottomnavigationBarView());
      },
      cont: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Level :04/15",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            SizedBox(height: 10.sp),
            FutureBuilder<Quizlevel>(
                future: controller.getdata(),
                builder:
                    (context, AsyncSnapshot<Quizlevel> snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.done) {
                    if (snapshot.hasData) {
                      var datas = snapshot.data!.data!;
                      return GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: 15,
                        physics: BouncingScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          Color clr = controller.colors[controller.colorindex[index]];
                          return InkWell(
                            onTap:() => Get.to(LevelscreensQuizScreenView()),
                            child: Container(
                              height: 100.sp,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.sp),
                              decoration: BoxDecoration(
                                  color: clr.withOpacity(0.2),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomLeft:
                                      Radius.circular(20),
                                      bottomRight:
                                      Radius.circular(20))),
                              child: Stack(
                                children: [
                                  Center(
                                      child: datas.length > index
                                          ? CachedNetworkImage(
                                          imageUrl: datas[index].image!,
                                          // color: clr,
                                          width: 60.sp,fit: BoxFit.cover)
                                          : SvgPicture.asset(
                                          controller.lockImages[controller.colorindex[index]],
                                          width: 70.sp,fit: BoxFit.cover)),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      SizedBox(height: 10.sp),
                                      datas.length > index
                                          ? Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "10/15",
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                        ],
                                      )
                                          : SizedBox.shrink(),
                                      SizedBox(height: 5.sp),
                                      datas.length > index
                                          ? LinearPercentIndicator(
                                        width: 92.sp,
                                        padding: EdgeInsets.zero,
                                        animation: true,
                                        lineHeight: 12.sp,
                                        animationDuration: 1000,
                                        percent: 0.2,
                                        alignment: MainAxisAlignment.center,
                                        clipLinearGradient: true,
                                        backgroundColor: ConstantsColors.whitecolor,
                                        center: Text("30.0%",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10.sp,color: Colors.blueGrey)),
                                        barRadius: Radius.circular(10),
                                        progressColor: clr,
                                        animateFromLastPercent: true,
                                        addAutomaticKeepAlive: true ,
                                      ):
                                      SizedBox.shrink(),
                                      SizedBox(height: 10.sp),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(
                        child: Text("Connection Disconnect"));
                  }
                }),
          ],
        ),
      ),
      )
    );
  }
}
