import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/controllers/dashboard_home_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/mySave_model.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/scordBoardHive_Model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/dashboard_score_board_controller.dart';



class DashboardScoreBoardView extends GetView<DashboardScoreBoardController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    ScreenUtil().setSp(24);
    DashboardScoreBoardController controller = Get.put(
        DashboardScoreBoardController());
    BottomnavigationBarController bottomnavigationBarController = BottomnavigationBarController();
    DashboardHomeController dashboardHomeController = Get.put(
        DashboardHomeController());

    final data = Hive.box('QuizData');


    Widget designScreens(
        {required clr, required image, required totalItem, required playCategory, required totalPercentage, required name}) {
      return Container(
        padding: EdgeInsets.only(
            left: 5.sp, right: 5.sp, bottom: 8.sp, top: 8.sp),
        decoration: BoxDecoration(
            color: clr.withOpacity(0.5),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: image.toString(),
              width: 70.sp,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.sp),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 230.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 200.sp,
                            child: Text(name.toString(), style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,)),
                        Spacer(),
                        Text("${playCategory}/$totalItem",
                            style: TextStyle(fontWeight: FontWeight.w600,
                                fontSize: 13.sp))
                        // Text("${answers}/$totalItem",
                        //     style: TextStyle(fontWeight: FontWeight.w600,
                        //         fontSize: 13.sp))
                      ],
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ConstantsColors.whitecolor)
                    ),
                    child: LinearPercentIndicator(
                      width: 230.sp,
                      padding: EdgeInsets.zero,
                      animation: true,
                      lineHeight: 18.sp,
                      animationDuration: 1000,
                      percent: totalPercentage != null
                          ? totalPercentage / 100
                          : 0.0,
                      alignment: MainAxisAlignment.center,
                      clipLinearGradient: true,
                      backgroundColor: ConstantsColors.whitecolor,
                      center: Text("$totalPercentage%", style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: Colors.blueGrey)),
                      barRadius: Radius.circular(10),
                      progressColor: clr,
                      animateFromLastPercent: true,
                      addAutomaticKeepAlive: true,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    //
    // return Templates.detailsScreens(
    //   title: "Score Board",
    //   context: context,
    //   backarrowISDisplay: true,
    //   ontapback: (){
    //     bottomnavigationBarController.selectedPage.value = 0;
    //     bottomnavigationBarController.advancedDrawerController.hideDrawer();
    //     Get.to(BottomnavigationBarView());
    //   },
    //   svgImagePath: Constants.HOME,
    //   onTap: (){
    //     bottomnavigationBarController.selectedPage.value = 0;
    //     bottomnavigationBarController.advancedDrawerController.hideDrawer();
    //     Get.to(BottomnavigationBarView());
    //   },
    //   cont: Container(
    //     width: width,
    //     padding: EdgeInsets.all(20),
    //     child: LocalVariables.userId == "Users" ?
    //           FutureBuilder<MySave?>(
    //           future:controller.quizdata(),
    //           builder: (context, AsyncSnapshot snapshot) {
    //             if(snapshot.connectionState == ConnectionState.done){
    //               if(snapshot.hasData){
    //                 var detail = snapshot.data!.data;
    //                 return ListView.separated(
    //                   separatorBuilder: (context, index) => SizedBox(height: 10.sp),
    //                   shrinkWrap: true,
    //                   padding: EdgeInsets.zero,
    //                   physics: BouncingScrollPhysics(),
    //                   itemCount: detail!.length,
    //                   itemBuilder: (context, index) {
    //                     var data = detail[index];
    //                     Color clr = HexColor(data.color.toString());
    //                     return FutureBuilder<FinalScores?>(
    //                         future: controller.fetchScoreusingHive(uniqId: data.uniqid) ,
    //                         builder:(context,AsyncSnapshot<FinalScores?> snapshot) {
    //                             if(snapshot.connectionState == ConnectionState.done){
    //                               if(snapshot.hasData){
    //                                 var finaldata = snapshot.data!;
    //                                 return designScreens(
    //                                   clr: clr,
    //                                   image: detail.image,
    //                                   playCategory: finaldata.playCategory,
    //                                   totalItem: finaldata.totalCategory,
    //                                   totalPercentage: finaldata.playCategory!/finaldata.totalCategory!,
    //                                   name: data.name
    //                                 );
    //                               }
    //                               else{
    //                                 return SizedBox.shrink();
    //                               }
    //                             }
    //                             else{
    //                               return SizedBox.shrink();
    //                             }
    //                         },
    //                     );
    //                   },
    //                 );
    //               }
    //               else{
    //                 return Center(
    //                   child: CircularProgressIndicator(color: Colors.orange),
    //                 );
    //               }
    //             }
    //             else{
    //               return Center(
    //                 child: CircularProgressIndicator(color: Colors.orange),
    //               );
    //             }
    //           },
    //         ) :
    //           StreamBuilder<MySave?>(
    //               stream: controller.scoardDataFromFCM(),
    //               builder:(context,AsyncSnapshot<MySave?> snapshot) {
    //                 if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
    //                   if(snapshot.hasData){
    //                     var datas = snapshot.data!.data;
    //                     return ListView.builder(
    //                       itemCount: datas!.length,
    //                       physics: BouncingScrollPhysics(),
    //                       shrinkWrap: true,
    //                       padding: EdgeInsets.zero,
    //                       itemBuilder:(context, index) {
    //                         var details = datas[index];
    //                         var clr =  HexColor(details.color.toString());
    //                         return StreamBuilder<FinalScores?>(
    //                             stream: controller.fetchScoreusingFCM(totalItem: details.totalItem,quizId: details.uniqid),
    //                             builder: (context,AsyncSnapshot<FinalScores?> snapshot) {
    //                               if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
    //                                 if(snapshot.hasData){
    //                                   var detail = snapshot.data;
    //                                   print("detail!.playCategory ------------------>${detail!.playCategory}");
    //                                   return designScreens(playCategory: detail.playCategory,totalItem: details.totalItem,totalPercentage: detail.totalPercentage,image: details.image,clr: clr,name: details.name);
    //                                 }
    //                                 else{
    //                                   return  Center(
    //                                     child: CircularProgressIndicator(
    //                                         color: Colors.orange),
    //                                   );
    //                                 }
    //                               }
    //                               else{
    //                                 return  Center(
    //                                   child: CircularProgressIndicator(
    //                                       color: Colors.orange),
    //                                 );
    //                               }
    //                             },
    //                         );
    //                         // return designScreens(playCategory: 2,totalItem: 6,totalPercentage: 30,image: details.image,clr: clr,name: details.name);
    //                       },
    //                     );
    //                   }
    //                   else{
    //                     return Center(
    //                       child: CircularProgressIndicator(
    //                           color: Colors.orange),
    //                     );
    //                   }
    //                 }
    //                 else{
    //                   return Center(
    //                     child: CircularProgressIndicator(
    //                         color: Colors.orange),
    //                   );
    //                 }
    //               },
    //             ),
    //     ),
    //   );


    return Templates.detailsScreens(
        title: "Score Board",
        context: context,
        backarrowISDisplay: true,
        ontapback: () {
          bottomnavigationBarController.selectedPage.value = 0;
          bottomnavigationBarController.advancedDrawerController
              .hideDrawer();
          Get.to(BottomnavigationBarView());
        },
        svgImagePath: Constants.HOME,
        onTap: () {
          bottomnavigationBarController.selectedPage.value = 0;
          bottomnavigationBarController.advancedDrawerController
              .hideDrawer();
          Get.to(BottomnavigationBarView());
        },
        cont:  Container(
            height: height,
            padding: EdgeInsets.only(top: 20.sp, left: 19.sp, right: 19.sp),
            child: LocalVariables.userId == "Users" ?
                FutureBuilder<MySave?>(
                  future: controller.quizdata(),
                    builder:(context,AsyncSnapshot<MySave?> snapshot) {
                    if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
                      print("snapshot.hasData -------------------->${snapshot.hasData}");
                      print("snapshot.hasError -------------------->${snapshot.hasError}");
                    if(snapshot.hasData){
                      var data = snapshot.data!.data;
                      return data!.length != 0 ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder:(context, index) {
                          var details = data[index];
                          var clr = HexColor(details.color.toString());
                          return FutureBuilder<FinalScores?>(
                            future: controller.fetchScoreusingHive(uniqId: details.uniqid!),
                            builder: (context,AsyncSnapshot<FinalScores?> snapshot) {
                              if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
                                if(snapshot.hasData){
                                  var detail = snapshot.data!;
                                  return designScreens(
                                      playCategory: detail.playCategory,
                                      totalItem: details.totalItem,
                                      totalPercentage: detail.totalPercentage,
                                      image: details.image,
                                      clr: clr,
                                      name: details.name);
                                }
                                else{
                                  return SizedBox.shrink();
                                }
                              }
                              else{
                                return FlutterWidgets.disconnected();
                              }
                            },
                          );
                        },
                      ):
                      FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height)
                      ;
                    }
                    else{
                      return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                    }
                  }
                  else{
                    return FlutterWidgets.disconnected();
                  }
                },
              )
                    : StreamBuilder<MySave?>(
                      stream: controller.scoardDataFromFCM(),
                      builder: (context, AsyncSnapshot<MySave?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done ||
                      snapshot.connectionState == ConnectionState.active) {
                          if (snapshot.hasData) {
                          var datas = snapshot.data!.data;
                          return datas!.length != 0 ? ListView.builder(
                            itemCount: datas.length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              var details = datas[index];
                              var clr = HexColor(details.color.toString());
                              return StreamBuilder<FinalScores?>(
                                stream: controller.fetchScoreusingFCM(
                                    totalItem: details.totalItem, quizId: details.uniqid),
                                builder: (context, AsyncSnapshot<FinalScores?> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done ||
                                      snapshot.connectionState ==
                                          ConnectionState.active) {
                                    if (snapshot.hasData) {
                                      var detail = snapshot.data;
                                      print("detail!.playCategory ------------------>${detail!.playCategory}");
                                      return designScreens(
                                          playCategory: detail.playCategory,
                                          totalItem: detail.questions,
                                          totalPercentage: detail.totalPercentage,
                                          image: details.image,
                                          clr: clr,
                                          name: details.name);
                                    }
                                    else {
                                      return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                                    }
                                  }
                                  else {
                                    return Container(
                                      height: height,
                                      width: width,
                                      child: Center(
                                        child: Text("Connection Dose not Connected",
                                            style: TextStyle(
                                                color: ConstantsColors.fontColor)),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ):FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                          }
                          else{
                              return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                          }
                       }
                      else{
                        return FlutterWidgets.disconnected();;
                      }
                   }
              )
        )
    );
    // return LocalVariables.userId == "Users" ?
    //         Scaffold(
    //           body: FutureBuilder<MySave?>(
    //             future: controller.quizdata(),
    //             builder:(context,AsyncSnapshot<MySave?> snapshot) {
    //               if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
    //                 if(snapshot.hasData){
    //                   var data = snapshot.data!.data;
    //                   return data!.length != 0 ? ListView.builder(
    //                     padding: EdgeInsets.zero,
    //                     itemCount: data.length,
    //                     shrinkWrap: true,
    //                     physics: BouncingScrollPhysics(),
    //                     itemBuilder:(context, index) {
    //                       var details = data[index];
    //                       var clr = HexColor(details.color.toString());
    //                       return FutureBuilder<FinalScores?>(
    //                         future: controller.fetchScoreusingHive(uniqId: details.uniqid!),
    //                         builder: (context,AsyncSnapshot<FinalScores?> snapshot) {
    //                           if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
    //                             if(snapshot.hasData){
    //                               var detail = snapshot.data!;
    //                               return designScreens(
    //                                   playCategory: detail.playCategory,
    //                                   totalItem: details.totalItem,
    //                                   totalPercentage: detail.totalPercentage,
    //                                   image: details.image,
    //                                   clr: clr,
    //                                   name: details.name);
    //                             }
    //                             else{
    //                               return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
    //                             }
    //                           }
    //                           else{
    //                             return FlutterWidgets.disconnected();
    //                           }
    //                         },
    //                       );
    //                     },
    //                   ):
    //                   FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height)
    //                   ;
    //                 }
    //                 else{
    //                   return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
    //                 }
    //               }
    //               else{
    //                 return FlutterWidgets.disconnected();
    //               }
    //             },
    //           ),
    //         ):
    //         StreamBuilder<MySave?>(
    //   stream: controller.scoardDataFromFCM(),
    //   builder: (context, AsyncSnapshot<MySave?> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done ||
    //         snapshot.connectionState == ConnectionState.active) {
    //       if (snapshot.hasData) {
    //         var datas = snapshot.data!.data;
    //         return Templates.detailsScreens(
    //             title: "Score Board",
    //             context: context,
    //             backarrowISDisplay: true,
    //             ontapback: () {
    //               bottomnavigationBarController.selectedPage.value = 0;
    //               bottomnavigationBarController.advancedDrawerController
    //                   .hideDrawer();
    //               Get.to(BottomnavigationBarView());
    //             },
    //             svgImagePath: Constants.HOME,
    //             onTap: () {
    //               bottomnavigationBarController.selectedPage.value = 0;
    //               bottomnavigationBarController.advancedDrawerController
    //                   .hideDrawer();
    //               Get.to(BottomnavigationBarView());
    //             },
    //             cont: Container(
    //               height: height,
    //               padding: EdgeInsets.only(top: 20.sp, left: 10.sp, right: 10.sp),
    //               child: datas!.length != 0 ? ListView.builder(
    //                 itemCount: datas.length,
    //                 physics: BouncingScrollPhysics(),
    //                 shrinkWrap: true,
    //                 padding: EdgeInsets.zero,
    //                 itemBuilder: (context, index) {
    //                   var details = datas[index];
    //                   var clr = HexColor(details.color.toString());
    //                   return StreamBuilder<FinalScores?>(
    //                     stream: controller.fetchScoreusingFCM(
    //                         totalItem: details.totalItem, quizId: details.uniqid),
    //                     builder: (context, AsyncSnapshot<FinalScores?> snapshot) {
    //                       if (snapshot.connectionState == ConnectionState.done ||
    //                           snapshot.connectionState ==
    //                               ConnectionState.active) {
    //                         if (snapshot.hasData) {
    //                           var detail = snapshot.data;
    //                           print(
    //                               "detail!.playCategory ------------------>${detail!
    //                                   .playCategory}");
    //                           return designScreens(
    //                               playCategory: detail.playCategory,
    //                               totalItem: details.totalItem,
    //                               totalPercentage: detail.totalPercentage,
    //                               image: details.image,
    //                               clr: clr,
    //                               name: details.name);
    //                         }
    //                         else {
    //                           return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
    //                         }
    //                       }
    //                       else {
    //                         return Container(
    //                           height: height,
    //                           width: width,
    //                           child: Center(
    //                             child: Text("Connection Dose not Connected",
    //                                 style: TextStyle(
    //                                     color: ConstantsColors.fontColor)),
    //                           ),
    //                         );
    //                       }
    //                     },
    //                   );
    //                 },
    //               ):FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height),
    //             ));
    //       }
    //       else {
    //         return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
    //       }
    //     }
    //     else {
    //       return Center(
    //         child: CircularProgressIndicator(
    //             color: Colors.orange),
    //       );
    //     }
    //   },
    // ) ;
  }
}

