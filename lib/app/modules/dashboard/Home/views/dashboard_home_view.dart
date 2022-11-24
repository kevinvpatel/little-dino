import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/sockets_html.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/mySave_model.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/views/dashboard_my_save_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Recet/views/dashboard_recet_view.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/views/dashboard_details_alphabets_view.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/views/dashboard_details_first_detail_page_view.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/views/dashboard_quiz_caterogies_view.dart';
import '../controllers/dashboard_home_controller.dart';



class DashboardHomeView extends GetView<DashboardHomeController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle titlestyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 26.sp,color: ConstantsColors.fontColor);
    TextStyle header = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: ConstantsColors.fontColor,overflow: TextOverflow.ellipsis);
    TextStyle desc = TextStyle(fontSize: 15.sp, color: ConstantsColors.fontColor,fontWeight: FontWeight.w600);
    DashboardHomeController controller = Get.put(DashboardHomeController());
    BottomnavigationBarController bottomnavigationBarController = Get.put(BottomnavigationBarController());
    ScreenUtil().setSp(24);
    LocalVariables.getDataFrom_hive();
    LocalVariables.fromScreen = '';
    FutureBuilder(
      future: controller.loaddata(),
      builder:(context, snapshot) => SizedBox(),
    );

    Widget userLogin_datas({required fun, required controlllervalue, required title, required buttoncolor, required buttonBorderColor, required Function() onpress}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titlestyle),
          SizedBox(height: 15.sp),
          FutureBuilder(
            future: fun,
            builder: (context,AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasData){
                  var data = snapshot.data!.data!;
                  return  Container(
                    width: width,
                    height:  title == "Quiz" ? 150.sp : 180.sp,
                    child:  ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: data.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15.sp),
                      itemBuilder: (context, index)  {
                        var detail = data[index];
                        return StreamBuilder(
                          initialData: controller.getdataFromFCV(title: title == 'Category' ? 'Category' : 'Quiz', uniqId: detail.uniqid, index: index),
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: (){
                                if(title == 'Category'){
                                  LocalVariables.selectedCategory_title = detail.name;
                                  LocalVariables.selectedCategory_uniqueId = detail.uniqid;
                                  LocalVariables.fromScreen = "Home";
                                  Map<String,dynamic> mapData = {
                                    "Id": detail.id,
                                    "uniqid":  detail.uniqid,
                                    "name":  detail.name,
                                    "color":  detail.color,
                                    "vactor_color":  detail.vactor_color,
                                    "image":  detail.image,
                                    "totalItem": detail.totalItem,
                                  };
                                  LocalVariables.savedCategories = mapData;
                                  FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent').doc(detail.uniqid).set(mapData);
                                  FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('TillCardSwip').doc(detail.uniqid).get().then((value) {
                                    if(value.data() != null) {
                                      Get.to(DashboardDetailsFirstDetailPageView());
                                    } else {
                                      LocalVariables.initalizeCard = 0;
                                      Get.to(DashboardDetailsAlphabetsView());
                                    }
                                  });
                                } else {
                                  LocalVariables.selectedquiz = detail.name;
                                  LocalVariables.quizType_uniqueId = detail.uniqid;
                                  LocalVariables.selectedquiz_Id = detail.id;
                                  Map<String,dynamic> mapdata = {
                                    "Id": detail.id,
                                    "uniqid":  detail.uniqid,
                                    "name":  detail.name,
                                    "color":  detail.color,
                                    "vactor_color":  detail.vactor_color,
                                    "image":  detail.image,
                                    "totalItem": title != "Quiz" ? detail.totalItem : detail.total
                                  };
                                  LocalVariables.savedQuiz = mapdata;
                                  Get.to(DashboardQuizCaterogiesView());
                                }
                              },
                              child: Container(
                                width: 130.sp,
                                padding: EdgeInsets.only(bottom: 10.sp),
                                decoration: BoxDecoration(
                                    color: HexColor("${detail.color}"),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8.sp),
                                    Stack(
                                      children: [
                                        title != "Quiz" ? Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 10.sp),
                                          child: SvgPicture.asset("assets/vector.svg", color: HexColor(detail.vactor_color.toString()), width: 110.sp),
                                        ) : SizedBox.shrink(),
                                        Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: 10.sp),
                                            child: CachedNetworkImage(
                                                imageUrl: detail.image,
                                                width: title != "Quiz" ? 100.sp :80.sp,
                                                fit: BoxFit.cover)),
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
                                          Text("${detail.name}",
                                              style: header,maxLines: 1),
                                          Text(
                                            "Total:${title != "Quiz" ? detail.totalItem : detail.total}",
                                            style: desc,
                                          )
                                        ],
                                      ),
                                    ),
                                    // Obx(() =>  Positioned(
                                    //     top: 0,
                                    //     right: 0,
                                    //     child: CupertinoButton(
                                    //       onPressed: () async {
                                    //         controlllervalue[index] = controlllervalue[index] == true ? false : true;
                                    //         Map<String,dynamic> mapData = {};
                                    //           mapData = {
                                    //             "Id": detail.id,
                                    //             "uniqid":  detail.uniqid,
                                    //             "name":  detail.name,
                                    //             "color":  detail.color,
                                    //             "vactor_color":  detail.vactor_color,
                                    //             "image":  detail.image,
                                    //             "totalItem": detail.totalItem,
                                    //           };
                                    //           controlllervalue[index] == true?
                                    //           FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection(title == 'Category' || title == 'Recent' ?'Category':'Quiz').doc(detail.uniqid).set(mapData):
                                    //           FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection(title == 'Category' || title == 'Recent' ?'Category':'Quiz').doc(detail.uniqid).delete();
                                    //           controller.update();
                                    //       },
                                    //       borderRadius:
                                    //       BorderRadius.only(
                                    //           bottomLeft:
                                    //           Radius.circular(
                                    //               20),
                                    //           topRight:
                                    //           Radius.circular(
                                    //               20)),
                                    //       color: controlllervalue[index] != null &&
                                    //           controlllervalue[index]
                                    //               !=
                                    //               true
                                    //           ? Colors.transparent
                                    //           : Colors.pink
                                    //           .withOpacity(0.2),
                                    //       padding: EdgeInsets.all(0),
                                    //       minSize: 35.sp,
                                    //       child: Icon(
                                    //           controlllervalue[index]
                                    //               !=
                                    //               true
                                    //               ? CupertinoIcons
                                    //               .bookmark
                                    //               : CupertinoIcons
                                    //               .bookmark_fill,
                                    //           color: Colors.pink,
                                    //           size: 18.sp),
                                    //     )
                                    // ))
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      },
                    ),
                  );
                }
                else{
                  return FlutterWidgets.disconnected();
                }
              } else {
                return FlutterWidgets.disconnected();
              }
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: FlutterWidgets.button(
                height: 40.sp,
                width: width,
                onTap: onpress,
                backgroundColor: buttoncolor,
                borderColor: buttonBorderColor,
                content: Text("View All",style: TextStyle(color: ConstantsColors.whitecolor,fontSize: 18.sp,fontWeight: FontWeight.w600))
            ),
          ),
        ],
      );
    }

    Widget userLogin_recentSection(){
      return StreamBuilder<List<MySave>>(
        stream: controller.recentData(),
          builder: (context,AsyncSnapshot<List<MySave>> snapshot) {
            if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                return snapshot.data!.first.data!.length != 0 ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Recent", style: titlestyle),
                    SizedBox(height: 15.sp),
                    StreamBuilder<MySave?>(
                      stream: controller.recentDataFromFCmFormHomePage(),
                      builder: (context,AsyncSnapshot<MySave?> snapshot) {
                        if(snapshot.connectionState == ConnectionState.active){
                          if(snapshot.hasData){
                            var data = snapshot.data!.data;
                            return Container(
                                width: width,
                                height: 180.sp,
                                child:ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: data!.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15.sp),
                                  itemBuilder: (context, index)  {
                                    var detail = data[index];
                                     return InkWell(
                                      onTap: () {
                                        LocalVariables.fromScreen = "Home";
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
                                        LocalVariables.savedCategories = mapData;
                                        FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent').doc(detail.uniqid).set(mapData);
                                        FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('TillCardSwip').doc(detail.uniqid).get().then((value) {
                                          if(value.data() != null) {
                                            Get.to(DashboardDetailsFirstDetailPageView());
                                          } else {
                                            LocalVariables.initalizeCard = 0;
                                            Get.to(DashboardDetailsAlphabetsView());
                                          }
                                        });
                                        // Get.to(DashboardDetailsAlphabetsView());
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
                                                SvgPicture.asset("assets/vector.svg", color: HexColor(detail.vactor_color!), width: 110.sp),
                                                Center(
                                                  child: CachedNetworkImage(
                                                      imageUrl: detail.image!,
                                                      width: 90.sp,
                                                      fit: BoxFit.cover),
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
                                                  Text("${detail.name}",
                                                    style: header,maxLines: 1,),
                                                  Text(
                                                    "Total:${detail.totalItem}",
                                                    style: desc,
                                                  )
                                                ],
                                              ),
                                            ),
                                            // Obx(() =>  Positioned(
                                            //     top: 0,
                                            //     right: 0,
                                            //     child: CupertinoButton(
                                            //       onPressed: () async {
                                            //         controller.savedRecents[index] = controller.savedRecents[index] == true ? false : true;
                                            //         Map<String,dynamic> mapData = {};
                                            //         mapData = {
                                            //           "Id": detail.Id,
                                            //           "uniqid":  detail.uniqid,
                                            //           "name":  detail.name,
                                            //           "color":  detail.color,
                                            //           "vactor_color":  detail.vactor_color,
                                            //           "image":  detail.image,
                                            //           "totalItem": detail.totalItem,
                                            //         };
                                            //         controller.savedRecents[index] == true?
                                            //         FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Category').doc(detail.uniqid).set(mapData).then((value) => print("Inserted Successfully")):
                                            //         FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Category').doc(detail.uniqid).delete().then((value) => print("Delet Successfully"));
                                            //       },
                                            //       borderRadius:
                                            //       BorderRadius.only(
                                            //           bottomLeft:
                                            //           Radius.circular(
                                            //               20),
                                            //           topRight:
                                            //           Radius.circular(
                                            //               20)),
                                            //       color: controller.savedRecents.value[index] != null &&
                                            //           controller.savedRecents.value[index]
                                            //               !=
                                            //               true
                                            //           ? Colors.transparent
                                            //           : Colors.pink
                                            //           .withOpacity(0.2),
                                            //       padding: EdgeInsets.all(0),
                                            //       minSize: 35.sp,
                                            //       child: Icon(
                                            //           controller.savedRecents[index]
                                            //               !=
                                            //               true
                                            //               ? CupertinoIcons
                                            //               .bookmark
                                            //               : CupertinoIcons
                                            //               .bookmark_fill,
                                            //           color: Colors.pink,
                                            //           size: 18.sp),
                                            //     )
                                            // ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                            );
                          }
                          else{
                            return  Container(
                              height: 180.sp,
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.orange),
                              ),
                            );
                          }
                        }
                        else{
                          return  Container(
                            height: 180.sp,
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.orange),
                            ),
                          );
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                      child: FlutterWidgets.button(
                          height: 40.sp,
                          width: width,
                          onTap: (){
                            Get.to(DashboardRecetView());
                          },
                          backgroundColor: ConstantsColors.lightblue,
                          borderColor: ConstantsColors.darkblueColor,
                          content: Text("View All",style: TextStyle(color: ConstantsColors.whitecolor,fontSize: 18.sp,fontWeight: FontWeight.w600))
                      ),
                    ),
                  ],
                ):SizedBox.shrink();
              }
              else{
                return SizedBox.shrink();
              }
            }
            else{
              return SizedBox.shrink();
            }
          },
      );
    }

    Widget userUnLogin_recentSection(){
      final _myBox = Hive.box('Recent');
      return _myBox.length != 0 ? Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Recent", style: titlestyle),
            SizedBox(height: 15.sp),
            Container(
              width: width,
              height: 181.sp,
              child: FutureBuilder<MySave?>(
                future: controller.recentDataFromHiveForHomePage(),
                builder: (context,AsyncSnapshot<MySave?> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
                    if(snapshot.hasData){
                      var datas = snapshot.data!.data;
                      return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: datas!.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15.sp),
                        itemBuilder: (context, index)  {
                          var detail = datas[index];
                          return InkWell(
                            onTap: (){
                              LocalVariables.fromScreen = "Home";
                              LocalVariables.selectedCategory_title = "${detail.name}";
                              LocalVariables.selectedCategory_uniqueId = "${detail.uniqid}";
                              Map<String,dynamic> mapData = {
                                "Id": detail.Id,
                                "uniqid":  detail.uniqid,
                                "name":  detail.name,
                                "color":  detail.color,
                                "vactor_color":  detail.vactor_color,
                                "image":  detail.image,
                                "totalItem": detail.totalItem,
                              };
                              LocalVariables.savedCategories = mapData;
                              _myBox.put(detail.uniqid, mapData).then((value) => print("Inser data------------->"));
                              final _initializeCategiresCard = Hive.box('initializeCategiresCard');
                              if(_initializeCategiresCard.get(detail.uniqid) != null){
                                Get.to(DashboardDetailsFirstDetailPageView());
                              }
                              else{
                                LocalVariables.initalizeCard = 0;
                                Get.to(DashboardDetailsAlphabetsView());
                              };
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
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(top: 10.sp),
                                        child: SvgPicture.asset("assets/vector.svg",color: HexColor(detail.vactor_color!),width: 110.sp),
                                      ),
                                      Center(
                                          child: CachedNetworkImage(
                                              imageUrl: detail.image!,
                                              width: 110.sp,
                                              fit: BoxFit.cover)
                                      ),
                                    ],
                                  ),
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
                        );
                    }
                    else{
                      return  Container(
                        height: 180.sp,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: Colors.orange),
                        ),
                      );
                    }
                  }
                  else{
                    return  Container(
                      height: 180.sp,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.orange),
                      ),
                    );
                  }
                },
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: FlutterWidgets.button(
                  height: 40.sp,
                  width: width,
                  onTap: (){
                    Get.to(DashboardRecetView());
                  },
                  backgroundColor: ConstantsColors.lightblue,
                  borderColor: ConstantsColors.darkblueColor,
                  content: Text("View All",style: TextStyle(color: ConstantsColors.whitecolor,fontSize: 18.sp,fontWeight: FontWeight.w600))
              ),
            ),
          ],
        ),
      ):SizedBox.shrink();
    }

    Widget userUnLogin_datas({required fun,required controlllervalue,required title,required buttoncolor,required buttonBorderColor,required Function() onpress}){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titlestyle),
          SizedBox(height: 15.sp),
          Container(
            width: width,
            height: title == "Quiz" ? 160.sp : 200.sp,
            child: FutureBuilder(
              future: fun,
              builder: (context,AsyncSnapshot snapshot) {
                // print("snapshot --------------->${snapshot.connectionState}");
                // print("snapshot.hasData --------------->${snapshot.hasData}");
                if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active) {
                  if(snapshot.hasData){
                    var data = snapshot.data!.data!;
                    return  ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemCount: data.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15.sp),
                      itemBuilder: (context, index)  {
                        var detail = data[index];
                        return index < 10 ? InkWell(
                          onTap: (){
                            final _recentBox = Hive.box('Recent');
                            if(title == 'Category'){
                              LocalVariables.fromScreen = "Home";
                              LocalVariables.selectedCategory_title = detail.name!;
                              LocalVariables.selectedCategory_uniqueId = detail.uniqid!;
                              Map<String,dynamic> mapData = {
                                "Id": detail.id,
                                "uniqid":  detail.uniqid,
                                "name":  detail.name,
                                "color":  detail.color,
                                "vactor_color":  detail.vactor_color,
                                "image":  detail.image,
                                "totalItem": detail.totalItem,
                              };
                              LocalVariables.savedCategories = mapData;
                              _recentBox.put(detail.uniqid, mapData);
                              final _initializeCategiresCard = Hive.box('initializeCategiresCard');
                              if(_initializeCategiresCard.get(detail.uniqid) != null){
                                Get.to(DashboardDetailsFirstDetailPageView());
                              }
                              else{
                                LocalVariables.initalizeCard = 0;
                                Get.to(DashboardDetailsAlphabetsView());
                              }
                            }
                            else{
                              LocalVariables.selectedquiz = detail.name!;
                              LocalVariables.quizType_uniqueId = detail.uniqid!;
                              LocalVariables.selectedquiz_Id = detail.id.toString();
                                final _quizdetailBox = Hive.box("QuizData");
                                Map<String,dynamic> mapData = {
                                  "Id": detail.id,
                                  "uniqid":  detail.uniqid,
                                  "name":  detail.name,
                                  "color":  detail.color,
                                  "vactor_color":  detail.vactor_color,
                                  "image":  detail.image,
                                  "totalItem": title != "Quiz" ?detail.totalItem : detail.total,
                                };
                                _quizdetailBox.put(detail.uniqid, mapData);
                                LocalVariables.fromCompelet = false;
                              Get.to(DashboardQuizCaterogiesView());
                            }
                          },
                          child: Container(
                            width: title != "Quiz" ? 140.sp : 150.sp,
                            padding: EdgeInsets.only(bottom: 10.sp),
                            decoration: BoxDecoration(
                                color: HexColor("${detail.color}"),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.sp),
                                Stack(
                                  children: [
                                    title != "Quiz" ?Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 10.sp),
                                      child: SvgPicture.asset("assets/vector.svg",color: HexColor(detail.vactor_color.toString()),width: 110.sp),
                                    ): SizedBox.shrink(),
                                    Center(
                                      child: CachedNetworkImage(
                                          imageUrl: detail.image!,
                                          width: title == "Quiz" ? 90.sp : 110.sp,
                                          fit: BoxFit.cover),
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
                                      Text("${detail.name}",
                                          style: header,maxLines: 1),
                                      Text(
                                        "Total:${title != "Quiz" ?detail.totalItem : detail.total}",
                                        style: desc,
                                      )
                                    ],
                                  ),
                                ),
                                // Obx(() =>  Positioned(
                                //     top: 0,
                                //     right: 0,
                                //     child: CupertinoButton(
                                //       onPressed: () async {
                                //         controlllervalue[index] = controlllervalue[index] == true ? false : true;
                                //         Map<String,dynamic> mapData = {};
                                //         mapData = {
                                //           "Id": detail.id,
                                //           "uniqid":  detail.uniqid,
                                //           "name":  detail.name,
                                //           "color":  detail.color,
                                //           "vactor_color":  detail.vactor_color,
                                //           "image":  detail.image,
                                //           "totalItem": detail.totalItem,
                                //         };
                                //
                                //         if(title == "Category"){
                                //           final _categoriesBox = Hive.box('Categories');
                                //           controlllervalue[index] == true?_categoriesBox.put(detail.uniqid, mapData):_categoriesBox.delete(detail.uniqid);
                                //           print("_categoriesBox _categoriesBox.length ---------------> ${_categoriesBox.length}");
                                //         }
                                //         else{
                                //           final _quizBox = Hive.box('Quiz');
                                //           controlllervalue[index] == true?_quizBox.put(detail.uniqid, mapData):_quizBox.delete(detail.uniqid);
                                //         }
                                //       },
                                //       borderRadius:
                                //       BorderRadius.only(
                                //           bottomLeft:
                                //           Radius.circular(
                                //               20),
                                //           topRight:
                                //           Radius.circular(
                                //               20)),
                                //       color: controlllervalue[index] != null &&
                                //           controlllervalue[index]
                                //               !=
                                //               true
                                //           ? Colors.transparent
                                //           : Colors.pink
                                //           .withOpacity(0.2),
                                //       padding: EdgeInsets.all(0),
                                //       minSize: 35.sp,
                                //       child: Icon(
                                //           controlllervalue[index]
                                //               !=
                                //               true
                                //               ? CupertinoIcons
                                //               .bookmark
                                //               : CupertinoIcons
                                //               .bookmark_fill,
                                //           color: Colors.pink,
                                //           size: 18.sp),
                                //     )
                                // ))
                              ],
                            ),
                          ),
                        ) : SizedBox.shrink();
                      },
                    );
                  }
                  else{
                    return  Center(
                      child: CircularProgressIndicator(
                          color: Colors.orange),
                    );
                  }
                } else {
                  return  Center(
                    child: CircularProgressIndicator(
                        color: Colors.orange),
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: FlutterWidgets.button(
                height: 40.sp,
                width: width,
                onTap: onpress,
                backgroundColor: buttoncolor,
                borderColor: buttonBorderColor,
                content: Text("View All",style: TextStyle(color: ConstantsColors.whitecolor,fontSize: 18.sp,fontWeight: FontWeight.w600))
            ),
          ),
        ],
      );
    }


    return SafeArea(
        top: false,
        child: Scaffold(
          body: Container(
              color: ConstantsColors.whitecolor,
              child: Container(
                color: ConstantsColors.backgroundcolor,
                child: Column(
                  children: [
                    Container(
                      height: 320.sp,
                      child: Stack(
                        children: [
                          Image.asset(Constants.BACKGROUND_HOME,
                              width: width, fit: BoxFit.cover),
                          Container(
                            margin: EdgeInsets.only(
                                top: 30.sp, left: 20.sp, right: 20.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: bottomnavigationBarController.advancedDrawerController.showDrawer,
                                      padding: EdgeInsets.zero,
                                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                                        valueListenable: bottomnavigationBarController.advancedDrawerController,
                                        builder: (_, value, __) {
                                          return AnimatedSwitcher(
                                            duration: Duration(milliseconds: 250),
                                            child: Image.asset(Constants.DRAWER,
                                                width: 35.sp)
                                          );
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CupertinoButton(
                                          onPressed: () {
                                            Get.to(DashboardMySaveView());
                                          },
                                          child: SvgPicture.asset("assets/Home/bookmark.svg",width: 35.sp),
                                        ),
                                        Image.asset(Constants.BELL,
                                            width: 35.sp),
                                      ],
                                    )
                                  ],
                                ),

                                Text("Welcome",
                                    style: TextStyle(
                                        color: ConstantsColors.whitecolor,
                                        fontSize: 29.sp,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(height: 10.sp),
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset(Constants.DINOSAUR,
                                  width: 300.sp))
                        ],
                      ),
                    ),
                    Container(
                      height: height-350.sp,
                      // height: height-(height*0.38).sp,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 LocalVariables.userId == 'Users' ? userUnLogin_recentSection() : userLogin_recentSection(),
                                  LocalVariables.userId == 'Users' ? userUnLogin_datas(
                                  fun: controller.catagorydetailsForHomePage(),
                                  controlllervalue: controller.categoriesSave,
                                  title: "Category",
                                  buttonBorderColor: ConstantsColors.darkgreen,
                                  buttoncolor: ConstantsColors.green,
                                  onpress: () {
                                    bottomnavigationBarController.selectedPage.value = 1;
                                    Get.to(BottomnavigationBarView());
                                  },
                                    )
                                    : userLogin_datas(
                                    fun: controller.catagorydetailsForHomePage(),
                                    controlllervalue: controller.categoriesSave,
                                    title: "Category",
                                    buttonBorderColor: ConstantsColors.darkgreen,
                                    buttoncolor: ConstantsColors.green,
                                    onpress: (){
                                      // print("move to Quiz screen ------------->");
                                      bottomnavigationBarController.selectedPage.value = 1;
                                      Get.to(BottomnavigationBarView());
                                    },
                                ),
                                    LocalVariables.userId == 'Users' ? userUnLogin_datas(
                                      fun: controller.quizdeatilsForHomePage(),
                                      controlllervalue: controller.quizSave,
                                      title: "Quiz",
                                      buttonBorderColor: ConstantsColors.darkPink,
                                      buttoncolor: ConstantsColors.pinckColor,
                                      onpress: (){
                                        // print("move to Quiz screen ------------->");
                                        bottomnavigationBarController.selectedPage.value = 2;
                                        Get.to(BottomnavigationBarView());
                                      },
                                    )
                                    :userLogin_datas(
                                    fun: controller.quizdeatilsForHomePage(),
                                    controlllervalue: controller.quizSave,
                                    title: "Quiz",
                                    buttonBorderColor: ConstantsColors.darkPink,
                                    buttoncolor: ConstantsColors.pinckColor,
                                    onpress: (){
                                      bottomnavigationBarController.selectedPage.value = 2;
                                      Get.to(BottomnavigationBarView());
                                    },
                                ),
                                SizedBox(height: 80.sp)
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
    );
  }
}

