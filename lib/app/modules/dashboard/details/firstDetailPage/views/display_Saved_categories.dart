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
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/controllers/dashboard_details_alphabets_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/views/dashboard_details_alphabets_view.dart';
import 'package:little_dino_app/app/modules/dashboard/details/details_model.dart';
import 'package:little_dino_app/app/modules/dashboard/details/initializeCategiresCard.dart';

import '../controllers/dashboard_details_first_detail_page_controller.dart';

class DisplaySvaedCategories
    extends GetView<DashboardDetailsFirstDetailPageController> {
  @override
  Widget build(BuildContext context) {
    BottomnavigationBarController bottomnavigationBarController = Get.put(BottomnavigationBarController());
    DashboardDetailsFirstDetailPageController controller = Get.put(DashboardDetailsFirstDetailPageController());
    DashboardDetailsAlphabetsController detailsAlphabetsController = Get.put(DashboardDetailsAlphabetsController());

    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    ScreenUtil().setSp(24);
    controller.issetctedOrNot.value = true;
    if(LocalVariables.userId != "Users"){
      StreamBuilder(
        stream: detailsAlphabetsController.manageSavedFCMbyHive(),
        builder:(context, snapshot) {
          return SizedBox();
        },
      );
    }
    // detailsAlphabetsController.setalphabets(id: LocalVariables.selectedCategory_uniqueId);

    Widget futureDatas(){
      return Container(
          width: width,
          height: height*0.55,
          margin: EdgeInsets.symmetric(vertical: 30.sp),
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          decoration: BoxDecoration(
            color: HexColor(LocalVariables.displaySvaedcategories['color']),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
                topRight: Radius.circular(25)
            ),
          ),
          child: Stack(
            children: [
              LocalVariables.displaySvaedcategories['vactor_color'] != '' ?Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10.sp),
                child: SvgPicture.asset("assets/vector.svg",color: HexColor(LocalVariables.displaySvaedcategories['vactor_color']),width: 180.sp),
              ):SizedBox.shrink(),
              Center(
                child: CachedNetworkImage(
                  imageUrl: LocalVariables.displaySvaedcategories['image'],
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
                      LocalVariables.displaySvaedcategories['title'] != '' ?InkWell(
                        onTap: () {
                          controller.increment();
                        },
                        child: Text(LocalVariables.displaySvaedcategories['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: HexColor(LocalVariables.displaySvaedcategories['title_color'] != ''?LocalVariables.displaySvaedcategories['title_color']:LocalVariables.displaySvaedcategories['color']),
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
                                  'id' : LocalVariables.displaySvaedcategories['id'],
                                  'uniqid' : LocalVariables.displaySvaedcategories['uniqid'],
                                  'categoryId' : LocalVariables.displaySvaedcategories['categoryId'],
                                  'categoryuniqId' : LocalVariables.selectedCategory_uniqueId,
                                  'title' : LocalVariables.displaySvaedcategories['title'],
                                  'name' : LocalVariables.displaySvaedcategories['name'],
                                  'color' : LocalVariables.displaySvaedcategories['color'],
                                  'image' : LocalVariables.displaySvaedcategories['image'],
                                  'title_color' : LocalVariables.displaySvaedcategories['audio_string'],
                                  'audio_string' : LocalVariables.displaySvaedcategories['description'],
                                  'description' : LocalVariables.displaySvaedcategories['vactor_color']  ,
                                  'vactor_color' : LocalVariables.displaySvaedcategories['title_color'],
                                  'example' : LocalVariables.displaySvaedcategories['example'],
                                  'index' : LocalVariables.displaySvaedcategories['index']
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
                                    _savedCategoriesBox.put(LocalVariables.displaySvaedcategories['uniqid'], mapdata):
                                    _savedCategoriesBox.delete(LocalVariables.displaySvaedcategories['uniqid']);
                                  });
                                }
                                else{
                                  Hive.openBox("StorSavedDetailsFromFCM").then((value) {
                                    final _myBox = Hive.box("StorSavedDetailsFromFCM");
                                    controller.issetctedOrNot.value == false? _myBox.delete(LocalVariables.displaySvaedcategories['uniqid']):_myBox.put(LocalVariables.displaySvaedcategories['uniqid'],mapdata);
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
                                      .doc(LocalVariables.displaySvaedcategories['uniqid'])
                                      .set(mapdata)
                                      : FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(LocalVariables.userId)
                                      .collection('savedCategories')
                                      .doc(LocalVariables.displaySvaedcategories['uniqid'])
                                      .delete();
                                }
                              }),
                        );
                      })
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: Text(LocalVariables.displaySvaedcategories['name']!,
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
                    detailsAlphabetsController.play(LocalVariables.displaySvaedcategories['audio_string']);
                    detailsAlphabetsController.player.value.play();
                  },
                  child: Obx(() => Container(
                    width: 40.sp,
                    height: 40.sp,
                    margin: EdgeInsets.only(bottom: 15.sp),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: LocalVariables.displaySvaedcategories['vactor_color'] != ''?HexColor(LocalVariables.displaySvaedcategories['vactor_color']) : HexColor( LocalVariables.displaySvaedcategories['color'])
                    ),
                    child: detailsAlphabetsController.playerState.value == 'loading'
                        ? CircularProgressIndicator(color: Colors.white)
                        : SvgPicture.asset("assets/detail_bottomnavigationbar/volume.svg", color: Colors.white, fit: BoxFit.cover),
                  )),
                ),
              ),
            ],
          ),
      );
    }

    return Templates.detailsScreens(
        title: LocalVariables.selectedCategory_title,
        context: context,
        onTap: (){
          bottomnavigationBarController.selectedPage.value = 0;
          bottomnavigationBarController.advancedDrawerController.hideDrawer();
          Get.to(BottomnavigationBarView());
        },
        backarrowISDisplay: true,
        svgImagePath:Constants.HOME,
        ontapback: (){
          Get.to(DashboardMySaveView());
        },
        cont: Container(
          width: width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 20.sp),
                child: Column(
                  children: [
                LocalVariables.displaySvaedcategories != {} ?
                    Container(
                      height: height*0.8,
                      width: width,
                      child: Column(
                        children: [
                          futureDatas(),
                          Spacer(),
                          FlutterWidgets.button(
                              onTap: (){
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
                                LocalVariables.initalizeCard = int.parse(LocalVariables.displaySvaedcategories['index']);
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
                    ) :
                    SizedBox.shrink()
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
