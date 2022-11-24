import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/views/dashboard_home_view.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/views/dashboard_my_save_view.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/views/save_categories.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/controllers/dashboard_details_alphabets_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/views/dashboard_details_alphabets_view.dart';
import 'package:little_dino_app/app/modules/dashboard/details/details_model.dart';
import 'package:little_dino_app/app/modules/dashboard/details/initializeCategiresCard.dart';

import '../controllers/dashboard_details_first_detail_page_controller.dart';

class DashboardDetailsFirstDetailPageView
    extends GetView<DashboardDetailsFirstDetailPageController> {
  @override
  Widget build(BuildContext context) {
    BottomnavigationBarController bottomnavigationBarController = Get.put(BottomnavigationBarController());
    DashboardDetailsFirstDetailPageController controller = Get.put(DashboardDetailsFirstDetailPageController());
    DashboardDetailsAlphabetsController detailsAlphabetsController = Get.put(DashboardDetailsAlphabetsController());

    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    ScreenUtil().setSp(24);

    if(LocalVariables.userId != "Users"){
      StreamBuilder(
        stream: detailsAlphabetsController.manageSavedFCMbyHive(),
        builder:(context, snapshot) {
          return SizedBox();
        },
      );
    }

    // detailsAlphabetsController.setalphabets(id: LocalVariables.selectedCategory_uniqueId);

    Widget futureDatas({required int index,required detail2}){
      return Container(
          width: width,
          height: height*0.55,
          margin: EdgeInsets.symmetric(vertical: 30.sp),
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          decoration: BoxDecoration(
            color: HexColor(detail2.color!),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
                topRight: Radius.circular(25)
            ),
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10.sp),
                child: SvgPicture.asset("assets/vector.svg",color: HexColor(detail2.vactor_color!),width: 180.sp),
              ),
              Center(
                child: CachedNetworkImage(
                  imageUrl: detail2.image!,
                  fit: BoxFit.cover,
                  width: 180.sp,
                ),
              ) ,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      detail2.title != '' ?InkWell(
                        onTap: () {
                          controller.increment();
                        },
                        child: Text(detail2.title!,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: HexColor(detail2.title_color != ''?detail2.title_color!:detail2.color),
                                 fontSize: 100.sp)),
                      ):SizedBox.shrink(),
                      Obx(() {
                        return Container(
                          margin: EdgeInsets.only(top: 10.sp),
                          child: CupertinoButton(
                              child: Icon(controller.issetctedOrNot.value == true
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                                size: 30.sp,
                                color: Colors.pinkAccent,
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: () async {

                                controller.issetctedOrNot.value =! controller.issetctedOrNot.value;

                                Map<String,dynamic> mapdata = {
                                  'id' : detail2.id,
                                  'uniqid' : detail2.uniqid,
                                  'categoryId' : detail2.categoryId,
                                  'categoryuniqId' : LocalVariables.selectedCategory_uniqueId,
                                  'title' : detail2.title,
                                  'name' : detail2.name,
                                  'color' : detail2.color,
                                  'image' : detail2.image,
                                  'title_color' : detail2.audio_string,
                                  'audio_string' : detail2.description,
                                  'description' : detail2.vactor_color  ,
                                  'vactor_color' : detail2.title_color,
                                  'example' : detail2.example,
                                  'index' : index
                                };
                                Map<String, dynamic> categoriesdata = {
                                  'Id': "${LocalVariables.savedCategories['Id']}",
                                  'name': "${LocalVariables.savedCategories['name']}",
                                  'color': "${LocalVariables.savedCategories['color']}",
                                  'vactor_color': "${LocalVariables.savedCategories['vactor_color']}",
                                  'image': "${LocalVariables.savedCategories['image']}",
                                  'totalItem': "${LocalVariables.savedCategories['totalItem']}",
                                  'uniqid': "${LocalVariables.selectedCategory_uniqueId}",
                                };

                                if(LocalVariables.userId == "Users")  {
                                  await Hive.openBox("savedFrontCategories").then((value) {
                                    final savedFrontCategoriesBox = Hive.box('savedFrontCategories');
                                    savedFrontCategoriesBox.put(LocalVariables.savedCategories['uniqid'], categoriesdata);
                                  });
                                  await Hive.openBox("savedCategories").then((value) {
                                    final _savedCategoriesBox = Hive.box("savedCategories");
                                    controller.issetctedOrNot.value == true ?
                                    _savedCategoriesBox.put(detail2.uniqid, mapdata):
                                    _savedCategoriesBox.delete(detail2.uniqid);
                                  });
                                }
                                else{
                                  Hive.openBox("StorSavedDetailsFromFCM").then((value) {
                                    final _myBox = Hive.box("StorSavedDetailsFromFCM");
                                    controller.issetctedOrNot.value == false? _myBox.delete(detail2.uniqid):_myBox.put(detail2.uniqid,mapdata);
                                  });
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(LocalVariables.userId)
                                      .collection('savedFrontCategories')
                                      .doc(LocalVariables.savedCategories['uniqid'])
                                      .set(categoriesdata)
                                  ;
                                  controller.issetctedOrNot.value == true
                                      ? FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(LocalVariables.userId)
                                      .collection('savedCategories')
                                      .doc(detail2.uniqid)
                                      .set(mapdata)
                                      : FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(LocalVariables.userId)
                                      .collection('savedCategories')
                                      .doc(detail2.uniqid)
                                      .delete();
                                  await FirebaseFirestore.instance.collection("users").doc(LocalVariables.userId).collection('savedCategories').
                                  where('categoryuniqId',isEqualTo: LocalVariables.selectedCategory_uniqueId).snapshots().map((event) {
                                    try{
                                      event.docs.isEmpty ? FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(LocalVariables.userId)
                                          .collection('savedFrontCategories')
                                          .doc(LocalVariables.selectedCategory_uniqueId)
                                          .delete().then((value) => print("Delete successfully ---------->")):'';
                                    }catch(error){
                                      print("Error ---------------------->$error");}
                                  });

                                }
                          }),
                        );
                      })
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: Text(detail2.name!,
                        style: TextStyle(
                            fontSize: 35.sp,
                            color: ConstantsColors.fontColor,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 50.sp),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: (){
                    detailsAlphabetsController.play(detail2.audio_string);
                    detailsAlphabetsController.player.value.play();
                  },
                  child: Obx(() =>
                      Container(
                        width: 40.sp,
                        height: 40.sp,
                        margin: EdgeInsets.only(bottom: 15.sp),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor(detail2.vactor_color!)
                        ),
                        child: detailsAlphabetsController.playerState.value == 'loading'
                            ? CircularProgressIndicator(color: Colors.white)
                            : SvgPicture.asset("assets/detail_bottomnavigationbar/volume.svg",  color: Colors.white, fit: BoxFit.cover),
                      )
                  ),
                ),
              )
            ],
          )
      );
    }

    Widget userLoginData() {
      return StreamBuilder<InitializeCategiresCard?>(
        stream: controller.fetchDataOfTillCardSwip(),
        builder: (context,AsyncSnapshot<InitializeCategiresCard?> snapshot) {
          if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              var detail = snapshot.data!;
              int index = detail.index != '' ? detail.index! : 0;
              return Column(
                children: [
                  futureDatas(index: index,detail2: detail),
                  SizedBox(height: 15.sp),
                  ///Restart button
                  FlutterWidgets.button(
                      onTap: () {
                        LocalVariables.initalizeCard = 0;
                        LocalVariables.fromScreen = "ContinueScreen";
                        Get.to(DashboardDetailsAlphabetsView());
                      },
                      width: width,
                      height: 45.sp,
                      backgroundColor: ConstantsColors.green,
                      borderColor: Color.fromRGBO(104, 134, 0, 1),
                      content: Text("Restart",style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 19.sp))
                  ),
                  SizedBox(height: 15.sp),
                  ///Continue button
                  FlutterWidgets.button(
                      onTap: () {
                        LocalVariables.initalizeCard = detail.index;
                        LocalVariables.fromScreen = "ContinueScreen";
                        Get.to(DashboardDetailsAlphabetsView());
                      },
                      width: width,
                      height: 45.sp,
                      backgroundColor: ConstantsColors.lightblue,
                      borderColor: Color.fromRGBO(29, 123 , 212, 1),
                      content: Text("Continue",style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 19.sp))
                  ),
                ],
              );
            }
            else {
              return FlutterWidgets.disconnected();
            }
          }
          else {
            return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
          }
        },
      );
    }

    Widget userUnLoginData(){
      return FutureBuilder<InitializeCategiresCard?>(
        future: controller.fetchData(),
        builder: (context,AsyncSnapshot<InitializeCategiresCard?> snapshot) {
          if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasData){
              var detail = snapshot.data!;
              int index = detail.index != '' ? detail.index! : 0;
              return Container(
                height: height*0.8,
                width: width,
                child: Column(
                  children: [
                    FutureBuilder<Details?>(
                      future: detailsAlphabetsController.getAlphabetData(id: LocalVariables.selectedCategory_uniqueId),
                      builder: (context,AsyncSnapshot<Details?> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasData){
                            var detail2 = snapshot.data!.data![index];
                            detailsAlphabetsController.manageSavedUseingHive(detailsUniqId:detail2.uniqid!, index: detail.index!);
                            return futureDatas(index: index,detail2: detail2);
                          }
                          else{
                            return Center(child: CircularProgressIndicator(color: Colors.orange));
                          }
                        }
                        else{
                          return Center(child: CircularProgressIndicator(color: Colors.orange));
                        }
                      },
                    ),
                    Spacer(),
                    FlutterWidgets.button(
                        onTap: () {
                          LocalVariables.initalizeCard = 0;
                          LocalVariables.fromScreen = "ContinueScreen";
                          Get.to(DashboardDetailsAlphabetsView());
                        },
                        width: width,
                        height: height*0.05.sp,
                        backgroundColor: ConstantsColors.green,
                        borderColor: Color.fromRGBO(104, 134, 0, 1),
                        content: Text("Restart",style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 19.sp))
                    ),
                    SizedBox(height: 15.sp),
                    FlutterWidgets.button(
                        onTap: (){
                          LocalVariables.initalizeCard = detail.index!;
                          LocalVariables.fromScreen = "ContinueScreen";
                          Get.to(DashboardDetailsAlphabetsView());
                        },
                        width: width,
                        height: height*0.05.sp,
                        backgroundColor: ConstantsColors.lightblue,
                        borderColor: Color.fromRGBO(29, 123 , 212, 1),
                        content: Text("Continue",style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 19.sp))
                    ),
                  ],
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
    }

    return WillPopScope(
      onWillPop: () {
        if(LocalVariables.fromScreen == "Home" ) {
          bottomnavigationBarController.selectedPage = 0.obs;
          Get.to(BottomnavigationBarView());
        }
        else if (LocalVariables.fromScreen == "Category") {
          bottomnavigationBarController.selectedPage = 1.obs;
          Get.to(BottomnavigationBarView());
        }
        else if(LocalVariables.fromScreen == "mysaveDetailScreen") {
          Get.to(DashboardSaveCategories());
        }
        else {
          Get.back();
        }
        return Future.value(false);
      },
      child: Templates.detailsScreens(
        title: LocalVariables.selectedCategory_title,
        context: context,
        onTap: () {
          bottomnavigationBarController.selectedPage.value = 0;
          bottomnavigationBarController.advancedDrawerController.hideDrawer();
          Get.to(BottomnavigationBarView());
        },
        backarrowISDisplay: true,
        svgImagePath:Constants.HOME,
        ontapback: (){
          print("LocalVariables.fromScreen ---------------->${LocalVariables.fromScreen}");
          if(LocalVariables.fromScreen == "Home" ){
            bottomnavigationBarController.selectedPage = 0.obs;
            Get.to(BottomnavigationBarView());
          }
          else if (LocalVariables.fromScreen == "Category"){
            bottomnavigationBarController.selectedPage = 1.obs;
            Get.to(BottomnavigationBarView());
          }
          else if(LocalVariables.fromScreen == "mysaveDetailScreen"){
            Get.to(DashboardMySaveView());
          }
          else{
            Get.back();
          }
        },
        cont: Container(
          width: width,
          child: Column(
            children: [
             Container(
               padding: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 20.sp),
               child: Column(
                 children: [
                   LocalVariables.userId != "Users"? userLoginData() : userUnLoginData(),
                 ],
               ),
             ),
            ],
          ),
        )
      ),
    );
  }
}
