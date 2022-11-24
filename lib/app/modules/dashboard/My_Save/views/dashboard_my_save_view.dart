import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/mySave_model.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/saved_categories_detail_model.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/views/save_categories.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';


import '../../../../constants/local_veriables.dart';
import '../controllers/dashboard_my_save_controller.dart';

class DashboardMySaveView extends GetView<DashboardMySaveController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil().setSp(24);
    DashboardMySaveController controller = Get.put(DashboardMySaveController());
    BottomnavigationBarController bottomnavigationBarController = BottomnavigationBarController();
    // controller.onInit();
    //
    // addQuizData(details) async {
    //   final _quizdetailBox = Hive.box("QuizData");
    //   Map<String,dynamic> mapData = {
    //     "Id": details.id,
    //     "uniqid":  details.uniqid,
    //     "name":  details.name,
    //     "color":  details.color,
    //     "vactor_color":  details.vactor_color,
    //     "image":  details.image,
    //     "totalItem": details.totalItem
    //   };
    //   _quizdetailBox.put(details.uniqid, mapData);
    //   print("_quizdetailBox.put(details.uniqid, mapData); ------------->;${_quizdetailBox.get(details.uniqid)}");
    // }
    //
    // Widget userLoginData(){
    //   return Expanded(
    //     child: Obx(() => StreamBuilder<List<MySave>>(
    //       stream: controller.getdata(title: controller.count.value == 0?'Category':'Quiz'),
    //       builder: (context,AsyncSnapshot<List<MySave>> snapshot) {
    //         if(snapshot.connectionState == ConnectionState.active){
    //           if(snapshot.hasData){
    //             var datas = snapshot.data![0].data;
    //             return GridView.builder(
    //               itemCount: snapshot.data![0].data!.length,
    //               physics: BouncingScrollPhysics(),
    //               padding: EdgeInsets.zero,
    //               shrinkWrap: true,
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 20,childAspectRatio: 0.8),
    //               itemBuilder: (context, index) {
    //                 var detail = datas![index];
    //                 Color clr = HexColor(detail.color.toString());
    //                 return InkWell(
    //                   onTap: (){
    //                     if(controller.count.value == 0){
    //                       LocalVariables.selectedCategory_title = detail.name!;
    //                       LocalVariables.selectedCategory_uniqueId = detail.uniqid!;
    //                       Map<String,dynamic> mapdata = {
    //                         'Id':detail.Id,
    //                         'color':detail.color,
    //                         'image':detail.image,
    //                         'name':detail.name,
    //                         'totalItem':detail.totalItem,
    //                         'uniqid':detail.uniqid,
    //                         'vactor_color':detail.vactor_color,
    //                       };
    //                       FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent').doc(detail.uniqid).set(mapdata);
    //                       Get.to(DashboardDetailsFirstDetailPageView());
    //                     }
    //                     else{
    //                       LocalVariables.selectedquiz = detail.name!;
    //                       LocalVariables.selectedquiz_uniqueId = detail.uniqid!;
    //                       LocalVariables.selectedquiz_Id = detail.Id!;
    //                       Get.to(DashboardQuizCaterogiesView());
    //                     }
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                         color: clr.withOpacity(0.4),
    //                         borderRadius: BorderRadius.only(
    //                           topRight: Radius.circular(20.sp),
    //                           bottomLeft: Radius.circular(20.sp),
    //                           bottomRight: Radius.circular(20.sp),
    //                         )
    //                     ),
    //                     child: Stack(
    //                       children: [
    //                         Center(child: Center(child:CachedNetworkImage(
    //                             imageUrl: detail.image!,
    //                             width: 100.sp,
    //                             fit: BoxFit.cover,
    //                             )
    //                           )
    //                         ),
    //                         Align(
    //                           alignment: Alignment.topRight,
    //                           child: InkWell(
    //                             onTap: (){
    //                               FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection(controller.count.value == 0 ?'Category':'Quiz').doc(detail.uniqid).delete();
    //                             },
    //                             child: Container(
    //                               width: 40.sp,
    //                               height: 40.sp,
    //                               decoration: BoxDecoration(
    //                                   color: Colors.pink.withOpacity(0.15),
    //                                   borderRadius: BorderRadius.only(
    //                                     topRight: Radius.circular(20),
    //                                     bottomLeft: Radius.circular(20),
    //                                   )
    //                               ),
    //                               child: Icon(CupertinoIcons.bookmark_fill,color: Colors.pink,size: 23.sp),
    //                             ),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.all(10.sp),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Spacer(),
    //                               Text(detail.name.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18.sp)),
    //                               SizedBox(height: 3.sp),
    //                               Text("Total : ${detail.totalItem}",style: TextStyle(fontSize: 15.sp))
    //                             ],
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             );
    //           }
    //           else{
    //             return  Center(
    //               child: Text("No Data"),
    //             );
    //           }
    //         }
    //         else{
    //           return  Center(
    //             child: CircularProgressIndicator(
    //                 color: Colors.orange),
    //           );
    //         }
    //       },
    //     )),
    //   );
    // }
    //
    // Widget userUnLoginData(){
    //   return Expanded(
    //     child: Obx(() => FutureBuilder<MySave?>(
    //       future: controller.dataFromHive(title: controller.count.value == 0 ? 'Categories' : 'Quiz' ),
    //       builder: (context,AsyncSnapshot<MySave?> snapshot) {
    //         if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
    //           if(snapshot.hasData){
    //             var datas = snapshot.data!.data;
    //             return GridView.builder(
    //               itemCount: datas!.length,
    //               physics: BouncingScrollPhysics(),
    //               padding: EdgeInsets.zero,
    //               shrinkWrap: true,
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 20,mainAxisSpacing: 20,childAspectRatio: 0.8),
    //               itemBuilder: (context, index) {
    //                 var detail = datas[index];
    //                 Color clr = HexColor(detail.color.toString());
    //                 return InkWell(
    //                   onTap: (){
    //                     if(controller.count.value == 0){
    //                       final _myBox = Hive.box('Recent');
    //                       LocalVariables.selectedCategory_title = detail.name!;
    //                       LocalVariables.selectedCategory_uniqueId = detail.uniqid!;
    //                       Map<String,dynamic> mapdata = {
    //                         'Id':detail.Id,
    //                         'color':detail.color,
    //                         'image':detail.image,
    //                         'name':detail.name,
    //                         'totalItem':detail.totalItem,
    //                         'uniqid':detail.uniqid,
    //                         'vactor_color':detail.vactor_color,
    //                       };
    //                       _myBox.put(detail.uniqid, mapdata);
    //                       final _initializeCategiresCard = Hive.box('initializeCategiresCard');
    //                       _initializeCategiresCard.get(detail.uniqid) == null?Get.to(DashboardDetailsAlphabetsView(),arguments: {'from':DashboardMySaveView()}):Get.to(DashboardDetailsFirstDetailPageView(),arguments: {'from':DashboardMySaveView()});
    //                     }
    //                     else{
    //                       LocalVariables.selectedquiz_uniqueId = detail.uniqid!;
    //                       LocalVariables.selectedquiz = detail.name!;
    //                       LocalVariables.selectedquiz_Id = detail.Id!;
    //                       LocalVariables.userId == "Users"?addQuizData(detail):'';
    //                       // print("LocalVariables.selectedquiz --------------->${LocalVariables.selectedquiz}");
    //                       Get.to(DashboardQuizCaterogiesView());
    //                     }
    //                   },
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                         color: clr.withOpacity(0.4),
    //                         borderRadius: BorderRadius.only(
    //                           topRight: Radius.circular(20.sp),
    //                           bottomLeft: Radius.circular(20.sp),
    //                           bottomRight: Radius.circular(20.sp),
    //                         )
    //                     ),
    //                     child: Stack(
    //                       children: [
    //                         Center(child:CachedNetworkImage(
    //                           imageUrl: detail.image!,
    //                           width: 100.sp,
    //                           fit: BoxFit.cover,
    //                           )
    //                         ),
    //                         Align(
    //                           alignment: Alignment.topRight,
    //                           child: InkWell(
    //                             onTap: (){
    //                               final _myBox = controller.count.value == 0?Hive.box('Categories'):Hive.box('Quiz');
    //                               _myBox.delete(detail.uniqid);
    //                             },
    //                             child: Container(
    //                               width: 40.sp,
    //                               height: 40.sp,
    //                               decoration: BoxDecoration(
    //                                   color: Colors.pink.withOpacity(0.15),
    //                                   borderRadius: BorderRadius.only(
    //                                     topRight: Radius.circular(20),
    //                                     bottomLeft: Radius.circular(20),
    //                                   )
    //                               ),
    //                               child: Icon(CupertinoIcons.bookmark_fill,color: Colors.pink,size: 23.sp),
    //                             ),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.all(10.sp),
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Spacer(),
    //                               Text(detail.name.toString(),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18.sp)),
    //                               SizedBox(height: 3.sp),
    //                               Text("Total : ${detail.totalItem}",style: TextStyle(fontSize: 15.sp))
    //                             ],
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 );
    //               },
    //             );
    //           }
    //           else{
    //             return  Center(
    //               child: Text("No Data"),
    //             );
    //           }
    //         }
    //         else{
    //           return  Center(
    //             child: CircularProgressIndicator(
    //                 color: Colors.orange),
    //           );
    //         }
    //       },
    //     )),
    //   );
    // }

    // controller.fcmList = [];
    TextStyle header = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: ConstantsColors.fontColor);
    TextStyle desc = TextStyle(fontSize: 15.sp, color: ConstantsColors.fontColor,fontWeight: FontWeight.w600);
    LocalVariables.fromScreen = '';


    Widget designdata({required data}) {
      return Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.6.sp,
          ),
          itemBuilder: (context, index) {
            var detail = data[index];
            return InkWell(
              onTap: () async {
                Map<String,dynamic> mapData = {
                  "Id": detail.Id,
                  "uniqid":  detail.uniqid,
                  "name":  detail.name,
                  "color":  detail.color,
                  "vactor_color":  detail.vactor_color,
                  "image":  detail.image,
                  "totalItem": detail.totalItem,
                  "totalSaved" : controller.totoalSaved
                };
                LocalVariables.savedCategories = mapData;
                Get.to(DashboardSaveCategories());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor("${detail.color ?? detail.vactor_color}"),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15.sp),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: SvgPicture.asset("assets/vector.svg", color: HexColor(detail.vactor_color.toString()), width: 130.sp),
                        ),
                        Center(
                            child: CachedNetworkImage(
                                imageUrl: detail.image!,
                                width: 120.sp,
                                fit: BoxFit.cover)
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(left: 18.sp,bottom: 10.sp,right: 10.sp),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(detail.name!,style: header),
                          Text('Total:${detail.totalItem}',style: desc)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return WillPopScope(
      onWillPop: () {
        bottomnavigationBarController.selectedPage.value = 0;
        bottomnavigationBarController.advancedDrawerController.hideDrawer();
        Get.to(BottomnavigationBarView());
        return Future.value(true);
      },
      child: Templates.detailsScreens(
        title: "Saved",
        context: context,
        backarrowISDisplay: true,
        ontapback: () {
          bottomnavigationBarController.selectedPage.value = 0;
          bottomnavigationBarController.advancedDrawerController.hideDrawer();
          Get.to(BottomnavigationBarView());
        },
        svgImagePath: Constants.HOME,
        onTap: () {
          bottomnavigationBarController.selectedPage.value = 0;
          bottomnavigationBarController.advancedDrawerController.hideDrawer();
          Get.to(BottomnavigationBarView());
        },
        cont: Container(
            padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
            child: LocalVariables.userId == "Users"?
              Column(
                children: [
                 FutureBuilder<MySave?>(
                    future: controller.savedDatafromHive(),
                    builder: (context,
                        AsyncSnapshot<MySave?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          var datas = snapshot.data!.data;
                          return designdata(data: datas);
                        } else {
                          return FlutterWidgets.noDataFound(
                              headerFontSize: 25.sp,
                              descriptionFontSize: 20.sp,
                              space: 3.sp,
                              width: width,
                              height: height);
                        }
                      } else {
                        return FlutterWidgets.disconnected();
                      }
                    },
                  )
                ],
              ) : Column(
              children: [
                Container(
                  height: 0,
                  child: StreamBuilder<MySave?>(
                      stream: controller.DetailsFCM(),
                      builder:(context,AsyncSnapshot<MySave?> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active) {
                          if(snapshot.hasData) {
                            var data = snapshot.data!.data;
                            return ListView.builder(
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  return StreamBuilder(
                                      stream: controller.savedDataFCM(categoriesUniquesId: data[index].uniqid!),
                                      builder:(context, snapshot) => SizedBox.shrink(),
                                  );
                                }
                            );
                          }
                          else {
                            return FlutterWidgets.noDataFound(headerFontSize: 25.sp, descriptionFontSize: 20.sp, space: 3.sp, width: width, height: height);
                          }
                        }
                        else {
                          return SizedBox();
                        }
                      }
                  ),
                ),
                StreamBuilder<MySave?>(
                  stream: controller.DetailsFCM(),
                    builder:(context,AsyncSnapshot<MySave?> snapshot) {
                      if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData) {
                            var data = snapshot.data!.data;
                              return designdata(data: data);
                          } else{
                            return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                          }
                      }
                      else{
                        return SizedBox();
                      }
                    }
                ),
              ],
            ))
      ),
    );

  }
}
