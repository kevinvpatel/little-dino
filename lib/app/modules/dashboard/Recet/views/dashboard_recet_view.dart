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
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/controllers/dashboard_home_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/mySave_model.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/views/dashboard_details_alphabets_view.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/views/dashboard_details_first_detail_page_view.dart';
import '../controllers/dashboard_recet_controller.dart';

class DashboardRecetView extends GetView<DashboardRecetController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    DashboardRecetController controller = Get.put(DashboardRecetController());

    DashboardHomeController dashboardHomeController = Get.put(DashboardHomeController());
    BottomnavigationBarController bottomnavigationBarController = BottomnavigationBarController();
    TextStyle header = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: ConstantsColors.fontColor,overflow: TextOverflow.ellipsis);
    TextStyle desc = TextStyle(fontSize: 15.sp, color: ConstantsColors.fontColor,fontWeight: FontWeight.w600);

    Widget UserLogin_recent(){
      return StreamBuilder<List<MySave>>(
          stream: dashboardHomeController.recentData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<MySave>> snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              if (snapshot.hasData) {
                var data = snapshot.data![0].data;
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data![0].data!.length,
                  padding: EdgeInsets.only(bottom: 65),
                  physics: BouncingScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.6.sp),
                  itemBuilder: (context, index) {
                    var detail = data![index];
                    return StreamBuilder(
                      stream: dashboardHomeController.isSaved(uniquId: detail.uniqid!, index: index),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData){
                            return  InkWell(
                              onTap: () {
                                final _myBox = Hive.box('Recent');
                                LocalVariables.selectedCategory_title = detail.name!;
                                LocalVariables.selectedCategory_uniqueId = detail.uniqid!;
                                Map<String,dynamic> mapData = {
                                  "Id": detail.Id,
                                  "uniqid":  detail.uniqid,
                                  "name":  detail.name,
                                  "color":  detail.color,
                                  "vactor_color":  detail.vactor_color,
                                  "image":  detail.image,
                                  "totalItem": detail.totalItem,
                                };
                                LocalVariables.userId == "Users"?
                                _myBox.put(detail.uniqid, mapData):
                                FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent').doc(detail.uniqid).set(mapData);
                                FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('TillCardSwip').doc(detail.uniqid).get().then((value) {
                                  value.data() != null ?Get.to(DashboardDetailsFirstDetailPageView(),arguments: {'from':DashboardRecetView()}) : Get.to(DashboardDetailsAlphabetsView(),arguments: {'from':DashboardRecetView()});
                                });
                              },
                              child: Container(
                                width: 130.sp,
                                padding: EdgeInsets.only(bottom: 10.sp),
                                decoration: BoxDecoration(
                                    color: HexColor(detail.color!),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20)
                                    )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15.sp),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 10.sp),
                                          child: SvgPicture.asset("assets/vector.svg",color: HexColor(detail.vactor_color!),width: 110.sp,height: 130.sp,fit: BoxFit.cover),
                                         ),
                                        Center(
                                            child: CachedNetworkImage(
                                                imageUrl: detail.image!,
                                                width: 110.sp,
                                                fit: BoxFit.cover)
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.sp),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(detail.name!,
                                            style:header,maxLines: 1,),
                                          Text(
                                            "Total:${detail.totalItem}",
                                            style: desc,
                                          )
                                        ],
                                      ),
                                    ),
                                    // Align(
                                    //   alignment: Alignment.topRight,
                                    //   child: Obx(() => CupertinoButton(
                                    //     onPressed: () async {
                                    //       controller.savedRecents[index] = controller.savedRecents[index] == true ? false : true;
                                    //       Map<String,dynamic> mapData = {
                                    //         "Id": detail.Id,
                                    //         "uniqid":  detail.uniqid,
                                    //         "name":  detail.name,
                                    //         "color":  detail.color,
                                    //         "vactor_color":  detail.vactor_color,
                                    //         "image":  detail.image,
                                    //         "totalItem": detail.totalItem,
                                    //       };
                                    //       final _CategoriesBox = Hive.box('Categories');
                                    //       // print("controller.savedRecents[index] ------------>${controller.savedRecents[index]}");
                                    //       // print("detail.Id --------------------->${detail.uniqid}");
                                    //       controller.savedRecents[index] == true?_CategoriesBox.put(detail.uniqid, mapData):_CategoriesBox.delete(detail.uniqid);
                                    //     },
                                    //     borderRadius:
                                    //     BorderRadius.only(
                                    //         bottomLeft:
                                    //         Radius.circular(
                                    //             20),
                                    //         topRight:
                                    //         Radius.circular(
                                    //             20)),
                                    //     color: controller.savedRecents[index] != null &&
                                    //         controller.savedRecents[index]
                                    //             !=
                                    //             true
                                    //         ? Colors.transparent
                                    //         : Colors.pink
                                    //         .withOpacity(0.2),
                                    //     padding: EdgeInsets.all(0),
                                    //     minSize: 35.sp,
                                    //     child: Icon(
                                    //         controller.savedRecents[index]
                                    //             !=
                                    //             true
                                    //             ? CupertinoIcons
                                    //             .bookmark
                                    //             : CupertinoIcons
                                    //             .bookmark_fill,
                                    //         color: Colors.pink,
                                    //         size: 18.sp),
                                    //   )),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          }
                          else{
                            return  Container(
                              height: 180.sp,
                              child: SizedBox(),
                            );
                          }
                        }
                        else{
                          return  Container(
                            height: 180.sp,
                            child: SizedBox(),
                          );
                        }
                      },
                    );
                  },
                );
              }
              else {
                return Center(
                  child: CircularProgressIndicator(
                      color: Colors.orange),
                );
              }
            }
            else{
              return  Center(
                child: CircularProgressIndicator(
                    color: Colors.orange),
              );
            }
          });
    }

    Widget UserUnLogin_recent(){
      return FutureBuilder<MySave?>(
          future: dashboardHomeController.recentDataFromHive(),
          builder: (context,AsyncSnapshot<MySave?> snapshot) {
            if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
              if (snapshot.hasData) {
                var data = snapshot.data!.data;
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: data!.length,
                  padding: EdgeInsets.only(bottom: 65),
                  physics: BouncingScrollPhysics(),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.64.sp),
                  itemBuilder: (context, index) {
                    var detail = data[index];
                    return  InkWell(
                      onTap: () {
                        final _myBox = Hive.box('Recent');
                        LocalVariables.selectedCategory_title = detail.name!;
                        LocalVariables.selectedCategory_uniqueId = detail.uniqid!;
                        Map<String,dynamic> mapData = {
                          "Id": detail.Id,
                          "uniqid":  detail.uniqid,
                          "name":  detail.name,
                          "color":  detail.color,
                          "vactor_color":  detail.vactor_color,
                          "image":  detail.image,
                          "totalItem": detail.totalItem,
                        };
                        _myBox.put(detail.uniqid, mapData);
                        final _initializeCategiresCard = Hive.box('initializeCategiresCard');
                        _initializeCategiresCard.get(detail.uniqid) == null?Get.to(DashboardDetailsAlphabetsView(),arguments: {'from':DashboardRecetView()}):Get.to(DashboardDetailsFirstDetailPageView(),arguments: {'from':DashboardRecetView()});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor("${detail.color}"),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(
                                  25),
                              bottomLeft: Radius.circular(
                                  25),
                              topRight: Radius.circular(
                                  25)),
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
                            SizedBox(height: 13.sp),
                            Container(
                              height: 130.sp,
                              // color: Colors.red,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 10.sp),
                                    child: SvgPicture.asset("assets/vector.svg",color: HexColor(detail.vactor_color.toString()),width: 110.sp,fit: BoxFit.cover),
                                  ),
                                  Center(
                                      child: CachedNetworkImage(
                                          imageUrl: detail.image!,
                                          width: 110.sp,
                                          fit: BoxFit.cover)
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(left: 18.sp,right: 18.sp,bottom: 10.sp),
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
                return Center(
                  child: CircularProgressIndicator(
                      color: Colors.orange),
                );
              }
            }
            else{
              return  Center(
                child: CircularProgressIndicator(
                    color: Colors.orange),
              );
            }
          });
    }



    ScreenUtil().setSp(24);
    return Templates.detailsScreens(
      title: "Recent",
      context: context,
      backarrowISDisplay: true,
      svgImagePath:Constants.HOME,
      onTap: (){
        bottomnavigationBarController.selectedPage.value = 0;
        bottomnavigationBarController.advancedDrawerController.hideDrawer();
        Get.to(BottomnavigationBarView());
      },
      ontapback: () {
        bottomnavigationBarController.selectedPage.value = 0;
        bottomnavigationBarController.advancedDrawerController.hideDrawer();
        Get.to(BottomnavigationBarView());
      },
      cont: Container(
        padding: EdgeInsets.all(20),
        child: LocalVariables.userId == "Users" ? UserUnLogin_recent() : UserLogin_recent(),
      ),
    );
  }
}
