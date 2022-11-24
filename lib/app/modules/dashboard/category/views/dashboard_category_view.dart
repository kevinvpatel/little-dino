import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:little_dino_app/app/modules/dashboard/Home/controllers/dashboard_home_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/category/category_model.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/controllers/dashboard_details_alphabets_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/views/dashboard_details_alphabets_view.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/views/dashboard_details_first_detail_page_view.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/level/views/dashboard_level_view.dart';

import '../controllers/dashboard_category_controller.dart';

class DashboardCategoryView extends GetView<DashboardCategoryController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DashboardCategoryController controller = Get.put(DashboardCategoryController());
    DashboardHomeController dashboardHomeController = Get.put(DashboardHomeController());
    DashboardDetailsAlphabetsController dashboardDetailsAlphabetsController = Get.put(DashboardDetailsAlphabetsController());

    LocalVariables.fromScreen = '';
    ScreenUtil().setWidth(540);
    ScreenUtil().setHeight(200);
    ScreenUtil().setSp(24);
    bool? fromQuiz = Get.arguments != null ?Get.arguments['fromQuiz']:false;
    String? title = LocalVariables.selectedCategory_title;
    String? quiz_uinqId = Get.arguments != null ?Get.arguments['Quiz_uinqId'] :'';
    TextStyle header = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: ConstantsColors.fontColor,overflow: TextOverflow.ellipsis);
    TextStyle desc = TextStyle(fontSize: 15.sp, color: ConstantsColors.fontColor,fontWeight: FontWeight.w600);
    return Templates.detailsScreens(
      title: "Category",
      context: context,
      onTap: (){},
      backarrowISDisplay: false,
      svgImagePath: Constants.NOTIFICATION,
      cont: Container(
        padding: EdgeInsets.only(left: 20.sp, right: 20.sp,top: 10.sp),
        child: FutureBuilder(
          future: dashboardHomeController.catagorydetails(),
          builder: (BuildContext context,
              AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                var data = snapshot.data!.data;
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  padding: EdgeInsets.only(bottom: height * 0.1),
                  physics: BouncingScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.74.sp,
                  ),
                  itemBuilder: (context, index) {
                    var detail = data[index];
                    // LocalVariables.userId == "Users"?
                    // dashboardHomeController.categoriesSave.value[index] = Hive.box('Categories').get(detail.uniqid) != null ? true: false:'';
                    return InkWell(
                      onTap: () {
                        print('');
                        LocalVariables.fromScreen = "Category";
                        LocalVariables.selectedCategory_uniqueId = detail.uniqid;
                        LocalVariables.selectedCategory_title =  detail.name;
                        Map<String,dynamic> mapData = {
                          "Id": detail.id,
                          "uniqid":  detail.uniqid,
                          "name":  detail.name,
                          "color":  detail.color,
                          "vactor_color":  detail.vactor_color,
                          "image":  detail.image,
                          "totalItem": detail.totalItem,
                        };
                        dashboardDetailsAlphabetsController.setalphabets(id: detail.uniqid);
                        LocalVariables.savedCategories = mapData;
                        if(LocalVariables.userId == "Users"){
                          final _recentBox = Hive.box('Recent');
                          _recentBox.put(detail.uniqid, mapData);
                          final _initializeCategiresCard = Hive.box('initializeCategiresCard');
                          if(_initializeCategiresCard.get(detail.uniqid) != null) {
                            Get.to(DashboardDetailsFirstDetailPageView());
                          }
                          else {
                            LocalVariables.initalizeCard = 0;
                            Get.to(DashboardDetailsAlphabetsView());
                          }
                        }
                        else{
                          FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent').doc(detail.uniqid).set(mapData);
                          FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('TillCardSwip').doc(detail.uniqid).get().then((value) {
                            if(value.data() != null){
                              Get.to(DashboardDetailsFirstDetailPageView());
                            }
                            else {
                              LocalVariables.initalizeCard = 0;
                              Get.to(DashboardDetailsAlphabetsView());
                            }
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("${detail.color}"),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topRight: Radius.circular(25)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Align(
                            //   alignment: Alignment.topRight,
                            //   child: CupertinoButton(
                            //     onPressed: () {
                            //       dashboardHomeController.categoriesSave[index] = dashboardHomeController.categoriesSave[index] == true ? false : true;
                            //       Map<String,dynamic> mapData = {};
                            //       mapData = {
                            //         "Id": detail.id,
                            //         "uniqid":  detail.uniqid,
                            //         "name":  detail.name,
                            //         "color":  detail.color,
                            //         "vactor_color":  detail.vactor_color,
                            //         "image":  detail.image,
                            //         "totalItem": detail.totalItem
                            //       };
                            //       if(LocalVariables.userId == "Users"){
                            //         final _myBox = Hive.box('Categories');
                            //         dashboardHomeController.categoriesSave[index] == true?_myBox.put(detail.uniqid, mapData):_myBox.delete(detail.uniqid);
                            //       }
                            //       else{
                            //         dashboardHomeController.categoriesSave[index] == true?
                            //         FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Category').doc(detail.uniqid).set(mapData):
                            //         FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Category').doc(detail.uniqid).delete();
                            //         dashboardHomeController.update();
                            //       }
                            //     },
                            //     padding: EdgeInsets.zero,
                            //     disabledColor:
                            //     Colors.transparent,
                            //     borderRadius: BorderRadius
                            //         .only(
                            //         bottomLeft:
                            //         Radius.circular(25),
                            //         topRight:
                            //         Radius.circular(25)),
                            //     color: dashboardHomeController.categoriesSave.value[index] != null &&
                            //         dashboardHomeController.categoriesSave.value[index]  !=  true
                            //         ? Colors.transparent
                            //         : Colors.pink
                            //         .withOpacity(0.2),
                            //     child: Icon(
                            //         dashboardHomeController.categoriesSave.value[index] ==
                            //             true
                            //             ? CupertinoIcons
                            //             .bookmark_fill
                            //             : CupertinoIcons
                            //             .bookmark,
                            //         size: 20.w,
                            //         color: Colors.pink),
                            //   ),
                            // ),
                            Container(
                              height: 120.sp,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 10.sp),
                                    child: SvgPicture.asset("assets/vector.svg",color: HexColor(detail.vactor_color.toString()),width: 110.sp,fit: BoxFit.cover),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 10.sp),
                                    child: CachedNetworkImage(
                                        imageUrl: detail.image!,
                                        width: 100.sp,
                                        fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(left: 12.sp,right: 12.sp,bottom: 12.sp),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      detail.name!,
                                      style: header,maxLines: 1),
                                  Text('Total:${detail.totalItem}',
                                      style: desc)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              else {
                return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
              }
            }
            else {
              return FlutterWidgets.disconnected();
            }
          },
        ),
      ),
    );

  }
}
