import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/details/details_model.dart';
import 'package:little_dino_app/app/modules/dashboard/details/finishscreen.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/views/dashboard_details_first_detail_page_view.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../controllers/dashboard_details_alphabets_controller.dart';

class DashboardDetailsAlphabetsView
    extends GetView<DashboardDetailsAlphabetsController> {
  @override
  Widget build(BuildContext context) {
    DashboardDetailsAlphabetsController controller = Get.put(DashboardDetailsAlphabetsController());
    BottomnavigationBarController bottomnavigationBarController = Get.put(BottomnavigationBarController());
    controller.scrollController = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    LocalVariables.categoriesDetail = [];
    ScreenUtil().setSp(24);
    String? categoryid = LocalVariables.selectedCategory_uniqueId;
    String? title = LocalVariables.selectedCategory_title;

    if(LocalVariables.userId != "Users"){
      StreamBuilder(
        stream: controller.manageSavedFCMbyHive(),
          builder:(context, snapshot) {
            return SizedBox();
          },
      );
    }

    controller.count = LocalVariables.initalizeCard == null || LocalVariables.initalizeCard == null
        ? 0.obs
        : LocalVariables.initalizeCard!.obs;
    LocalVariables.initalizeCard = LocalVariables.initalizeCard == null || LocalVariables.initalizeCard == null
        ? 0
        : LocalVariables.initalizeCard!;

    CarouselOptions carouselOptions = CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
        scrollPhysics: BouncingScrollPhysics(),
        viewportFraction: 0.85,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        slideIndicator: CircularWaveSlideIndicator(),
        height: 420.sp,
        showIndicator: false,
        initialPage: LocalVariables.initalizeCard!,
        onPageChanged: (index, cnt) {
          controller.count.value = index;
          controller.player.value.pause();
          final _initializeCategiresBox = Hive.box('initializeCategiresCard');
          LocalVariables.userId == "Users"
              ? _initializeCategiresBox.put(
                  LocalVariables.selectedCategory_uniqueId,
                  LocalVariables.categoriesDetail[index])
              : FirebaseFirestore.instance
                  .collection('users')
                  .doc(LocalVariables.userId)
                  .collection('TillCardSwip')
                  .doc(LocalVariables.selectedCategory_uniqueId)
                  .set(LocalVariables.categoriesDetail[index]);
        });

    controller.currentIndex.value = LocalVariables.initalizeCard!;
    controller.count.value = LocalVariables.initalizeCard!;

    Widget datas({required detail, required index, required details}) {
      return Container(
        margin: EdgeInsets.only(left: 11.sp, right: 11.sp),
        padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
        decoration: BoxDecoration(
            color: HexColor(detail.color!),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10.sp),
              child: SvgPicture.asset("assets/vector.svg",
                  color: HexColor(detail.vactor_color.toString()), width: 180.sp),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.increment();
                      },
                      child: Text(details.data![index].title!,
                          style: TextStyle(
                              color:HexColor(detail.title_color != '' ? detail.title_color! : detail.vactor_color),
                              fontSize: 100.sp))
                    ),
                    Obx(() {
                      print('index 23 -> $index');
                      return Container(
                        margin: EdgeInsets.only(top: 10.sp),
                        child: CupertinoButton(
                            child: Icon(
                              controller.isselected.value[index].value == true
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              size: 30.sp,
                              color: Colors.pinkAccent,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              // print('controller.isselected.value[index].value 11 -> ${controller.isselected.value[index].value}');
                              Map<String, dynamic> mapdata = {
                                'id': detail.id,
                                'uniqid': detail.uniqid,
                                'categoryId': detail.categoryId,
                                'categoryuniqId': LocalVariables.selectedCategory_uniqueId,
                                'title': detail.title,
                                'name': detail.name,
                                'color': detail.color,
                                'image': detail.image,
                                'audio_string': detail.audio_string,
                                'description': detail.description,
                                'vactor_color': detail.vactor_color,
                                'title_color': detail.title_color,
                                'example': detail.example,
                                'index' : index.toString()
                              };

                              Map<String, dynamic> categoriesdata = {
                                'Id': "${LocalVariables.savedCategories['Id']}",
                                'name': "${LocalVariables.savedCategories['name']}",
                                'color': "${LocalVariables.savedCategories['color']}",
                                'vactor_color': "${LocalVariables.savedCategories['vactor_color']}",
                                'image': "${LocalVariables.savedCategories['image']}",
                                'totalItem': "${LocalVariables.savedCategories['totalItem']}",
                                'uniqid': LocalVariables.selectedCategory_uniqueId,
                              };
                              // print('categoriesdata @@-> $categoriesdata');

                              ///If User Not Logged In
                              if (LocalVariables.userId == "Users") {
                                try {
                                  await Hive.openBox("savedFrontCategories").then((value) {
                                    final savedFrontCategoriesBox = Hive.box('savedFrontCategories');
                                    print("LocalVariables.savedCategories -------------------->${LocalVariables.savedCategories}");
                                    savedFrontCategoriesBox.put(LocalVariables.savedCategories['uniqid'], categoriesdata);
                                  });
                                  final _savedCategoriesBox = Hive.box("savedCategories");
                                  print("mapdata -------------------->$mapdata");
                                  print("detail.uniqid -------------------->${detail.uniqid}");
                                  controller.isselected.value[index].value == false
                                      ? _savedCategoriesBox.put(detail.uniqid, mapdata).then((value) =>
                                      print("Successfully added _savedCategoriesBox"))
                                      : _savedCategoriesBox.delete(detail.uniqid);

                                  print("_savedCategoriesBox -> ${_savedCategoriesBox.get(detail.uniqid)}");
                                } catch(err) {
                                  print("_savedCategoriesBox err -> $err");
                                }
                              }
                              ///If User Logged In
                              else {
                                Hive.openBox("StorSavedDetailsFromFCM").then((value) {
                                  final _myBox = Hive.box("StorSavedDetailsFromFCM");
                                  controller.isselected.value[index].value == false
                                      ? _myBox.delete(detail.uniqid)
                                      : _myBox.put(detail.uniqid,mapdata).then((value) => print('_myBox.put successfully'));
                                });

                                final savedFrontCategoriesCollection = FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(LocalVariables.userId)
                                    .collection('savedFrontCategories');
                                savedFrontCategoriesCollection
                                    .doc(LocalVariables.savedCategories['uniqid'])
                                    .set(categoriesdata);


                                final savedCategoriesCollection = FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(LocalVariables.userId)
                                    .collection('savedCategories');
                                controller.isselected.value[index].value == false
                                    ? savedCategoriesCollection
                                    .doc(detail.uniqid)
                                    .set(mapdata)
                                    : savedCategoriesCollection
                                    .doc(detail.uniqid)
                                    .delete();

                                FirebaseFirestore.instance.collection("users").doc(LocalVariables.userId).collection('savedCategories').
                                where('categoryuniqId',isEqualTo: LocalVariables.selectedCategory_uniqueId).snapshots().map((event) {
                                  try {
                                    event.docs.isEmpty
                                        ? savedFrontCategoriesCollection
                                        .doc(LocalVariables.selectedCategory_uniqueId)
                                        .delete().then((value) => print("Delete successfully ---------->")):'';
                                  } catch(error) {
                                    print("Error ---------------------->$error");
                                  }
                                });
                              }

                              controller.isselected.value[index].value == true
                                  ? controller.isselected.value[index].value = false
                                  : controller.isselected.value[index].value = true;
                              print('controller.isselected.value[index].value 22 -> ${controller.isselected.value[index].value}');
                              print(' ');
                            }),
                      );
                    })
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    detail.image! != null
                        ? CachedNetworkImage(
                            imageUrl: detail.image!,
                            fit: BoxFit.cover,
                            width: 174.sp,
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                Spacer(),
                Center(
                  child: Text(detail.name!,
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: ConstantsColors.fontColor,
                          fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 15.sp),
              ],
            ),
          ],
        ),
      );
    }

    ///Unsigned User Carousel View
    Widget unSignIn(){
      return  FutureBuilder<Details?>(
        future: controller.getAlphabetData(id: categoryid),
        builder: (context,AsyncSnapshot<Details?> snapshot) {
          if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              Details details = snapshot.data!;
              controller.lengh = details.data!.length;
              return Scaffold(
                body: Container(
                  width: width,
                  color: Colors.orangeAccent,
                  child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
                      child: Container(
                        width: width,
                        height: height*0.8+1.4.sp,
                        alignment: Alignment.center,
                         color: Colors.orangeAccent.withOpacity(0.2),
                        child:Obx(() => FlutterCarousel(
                          options: carouselOptions,
                          carouselController: controller.buttonCarouselController,
                          items: List.generate(details.data!.length, (index) {
                            print('details.data!.length -> ${details.data!.length}');
                            print("controller.isselected.value[index].value -> ${controller.isselected.value.length}");
                            var detail = details.data![index];
                            controller.audio.value = details.data![controller.count.value].audio_string!;
                            Map<String,dynamic> mapdata = {
                              'id' : detail.id,
                              'uniqid' : detail.uniqid,
                              'categoryId' : detail.categoryId,
                              'categoryuniqId' : LocalVariables.selectedCategory_uniqueId,
                              'title' : detail.title,
                              'name' : detail.name,
                              'color' : detail.color,
                              'image' : detail.image,
                              'title_color' : detail.title_color,
                              'audio_string' : detail.audio_string,
                              'description' : detail.description,
                              'vactor_color' : detail.vactor_color,
                              'example' : detail.example,
                              'index' : index.toString()
                            };
                            LocalVariables.categoriesDetail.add(mapdata);
                            controller.manageSavedUseingHive(index: index,detailsUniqId: detail.uniqid!);
                            return datas(index: index, detail: detail, details: details);
                          }),
                        )
                        ),
                      )
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Obx(() => Container(
                  color: CupertinoColors.white,
                  child: Container(
                    color: Colors.orangeAccent.withOpacity(0.2),
                    child: CurvedNavigationBar(
                      index: 1,
                      height: 60.sp,
                      items: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10.sp),
                          child: InkWell(
                            onTap: () {
                              controller.decrement();
                            },
                            child: RotatedBox(
                                quarterTurns: 2,
                                child: SvgPicture.asset(
                                  "assets/detail_bottomnavigationbar/left-arrow.svg",
                                  width: 40.sp,
                                )),
                          ),
                        ),
                        Container(
                            height: 35.sp,
                            width: 35.sp,
                            padding: EdgeInsets.all(5.sp),
                            child: controller.playerState.value == 'loading'
                                ? CircularProgressIndicator(color: Colors.white)
                                : SvgPicture.asset("assets/detail_bottomnavigationbar/volume.svg",
                                color: Colors.white, fit: BoxFit.cover)
                        ),
                        controller.count.value != controller.lengh-1 ?
                        Container(
                          margin: EdgeInsets.only(top: 10.sp),
                          child: InkWell(
                              onTap: () {
                                controller.increment();
                              },
                              child: SvgPicture.asset(
                                "assets/detail_bottomnavigationbar/left-arrow.svg",
                                width: 40.sp,
                              )
                          ),
                        ):
                        Container(
                          height: 35.sp,
                          width: 75.sp,
                          margin: EdgeInsets.only(top: 10.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.sp),
                              border: Border.all(
                                width: 2,
                                color: Color(0xffD2691E).withOpacity(0.8),
                              )),
                          child: CupertinoButton(
                              color: Colors.orangeAccent,
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(50.sp),
                              child: Text("Finish", style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                              onPressed: () {
                                Get.to(FinishScreen());
                              }
                          ),
                        )

                      ],
                      color: Colors.orangeAccent.withOpacity(0.4),
                      buttonBackgroundColor: Colors.orangeAccent,
                      backgroundColor: Colors.transparent,
                      letIndexChange: (index) {
                        if (index == 1) {
                          controller.play(controller.productslist[controller.count.value]);
                          controller.player.value.play();
                        }
                        return false;
                      },
                    ),
                  ),
                )),
              );
            }
            else if(!snapshot.hasData){
              return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
            }
            else{
              return FlutterWidgets.disconnected();
            }
          }
          else{
            return FlutterWidgets.disconnected();
          }
        },
      );
    }


    ///Signed User Carousel View
    Widget SignIn(){
      return FutureBuilder<Details?>(
        future: controller.getAlphabetData(id: categoryid),
        builder: (context,AsyncSnapshot<Details?> snapshot) {
          if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasData){
              Details details = snapshot.data!;
              controller.lengh = details.data!.length;
              return Scaffold(
                body: Container(
                  width: width,
                  color: Colors.orangeAccent,
                  child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
                      child: Container(
                        width: width,
                        height: height*0.8+1.4.sp,
                        alignment: Alignment.center,
                        color: Colors.orangeAccent.withOpacity(0.2),
                        child:Obx(() => FlutterCarousel(
                          options:carouselOptions,
                          carouselController:
                          controller.buttonCarouselController,
                          items: List.generate(details.data!.length, (index) {
                            var detail = details.data![index];
                            controller.audio.value = details.data![controller.count.value].audio_string!;
                            Map<String,dynamic> mapdata = {
                              'id' : detail.id,
                              'uniqid' : detail.uniqid,
                              'categoryId' : detail.categoryId,
                              'categoryuniqId' : LocalVariables.selectedCategory_uniqueId,
                              'title' : detail.title,
                              'name' : detail.name,
                              'color' : detail.color,
                              'image' : detail.image,
                              'title_color' : detail.title_color,
                              'audio_string' : detail.audio_string,
                              'description' : detail.description,
                              'vactor_color' : detail.vactor_color,
                              'example' : detail.example,
                              'index' : index.toString()
                            };
                            LocalVariables.categoriesDetail.add(mapdata);
                            controller.manageSavedUseingHiveForFCM(index: index, detailsUniqId: detail.uniqid!);
                            return datas(index: index,detail: detail,details: details);
                          }),
                        )
                        ),
                      )
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Obx(() {
                  print('playing type1: ${controller.playerState.value}');
                  return Container(
                    color: CupertinoColors.white,
                    child: Container(
                      color : Colors.orangeAccent.withOpacity(0.2),
                      child: CurvedNavigationBar(
                        index: 1,
                        height: 60.sp,
                        items: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            child: InkWell(
                              onTap: () {
                                controller.decrement();
                              },
                              child: RotatedBox(
                                  quarterTurns: 2,
                                  child: SvgPicture.asset(
                                    "assets/detail_bottomnavigationbar/left-arrow.svg",
                                    width: 40.sp,
                                  )),
                            ),
                          ),
                          Obx(() =>
                              Container(
                                  height: 35.sp,
                                  width: 35.sp,
                                  padding: EdgeInsets.all(5.sp),
                                  // child: SvgPicture.asset("assets/detail_bottomnavigationbar/volume.svg",
                                  //     color: Colors.white, fit: BoxFit.cover)
                                  child: controller.playerState.value == 'loading'
                                      ? CircularProgressIndicator(color: Colors.white)
                                      : SvgPicture.asset("assets/detail_bottomnavigationbar/volume.svg",
                                      color: Colors.white, fit: BoxFit.cover)
                              )
                          ),
                          controller.count.value != controller.lengh-1?
                          Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            child: InkWell(
                                onTap: () {
                                  controller.increment();
                                },
                                child: SvgPicture.asset(
                                  "assets/detail_bottomnavigationbar/left-arrow.svg",
                                  width: 40.sp,
                                )
                            ),
                          ):
                          Container(
                            height: 35.sp,
                            width: 75.sp,
                            margin: EdgeInsets.only(top: 10.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.sp),
                                border: Border.all(
                                  width: 2,
                                  color: Color(0xffD2691E).withOpacity(0.8),
                                )),
                            child: CupertinoButton(
                                color: Colors.orangeAccent,
                                padding: EdgeInsets.zero,
                                borderRadius: BorderRadius.circular(50.sp),
                                child: Text("Finish", style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                                onPressed: () {
                                  Get.to(FinishScreen());
                                }
                            ),
                          )

                        ],
                        color: Colors.orangeAccent.withOpacity(0.4),
                        buttonBackgroundColor: Colors.orangeAccent,
                        backgroundColor: Colors.transparent,
                        letIndexChange: (index) {
                          // index == 1?FlutterTts().speak(controller.audio.value):'';
                          if (index == 1) {
                            controller.play(controller.productslist[controller.count.value]);
                            controller.player.value.play();
                          }
                          return false;
                        },
                      ),
                    ),
                  );
                }),
              );
            }
            else if(!snapshot.hasData){
              return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
            }
            else{
              return FlutterWidgets.disconnected();
            }
          }
          else{
            return FlutterWidgets.disconnected();
          }
        },
      );
    }

    return WillPopScope(
      onWillPop: () {
        print('LocalVariables.fromScreen == "ContinueScreen" ->  ${LocalVariables.fromScreen == "ContinueScreen"}');
        print('bottomnavigationBarController.selectedPage.value ->  ${bottomnavigationBarController.selectedPage.value}');
        if(LocalVariables.fromScreen == "Home") {
          LocalVariables.fromScreen = '';
          bottomnavigationBarController.selectedPage = 0.obs;
          Get.to(BottomnavigationBarView());
        }
        else if(LocalVariables.fromScreen == "ContinueScreen") {
          // LocalVariables.fromScreen = '';
          // Get.to(DashboardDetailsFirstDetailPageView());
          LocalVariables.fromScreen = '';
          bottomnavigationBarController.selectedPage = 0.obs;
          Get.to(BottomnavigationBarView());
        } else if(LocalVariables.fromScreen == "ContinueScreen" && bottomnavigationBarController.selectedPage.value == 1) {
          Get.back();
          bottomnavigationBarController.selectedPage = 1.obs;
        } else {
          Get.back();
        }
        return Future.value(true);
      },
      child: Templates.detailsScreens(
          title: title,
          context: context,
          onTap: () {
            controller.currentIndex.value = LocalVariables.initalizeCard!;
            bottomnavigationBarController.advancedDrawerController
                .hideDrawer();
            Get.to(BottomnavigationBarView());
          },
          ontapback: () {
            print("LocalVariables.fromScreen ---------------------> ${LocalVariables.fromScreen}");
            if(LocalVariables.fromScreen == "Home") {
              LocalVariables.fromScreen = '';
              bottomnavigationBarController.selectedPage = 0.obs;
              Get.to(BottomnavigationBarView());
            }
            else if(LocalVariables.fromScreen == "ContinueScreen") {
              // LocalVariables.fromScreen = '';
              // Get.to(DashboardDetailsFirstDetailPageView());
              LocalVariables.fromScreen = '';
              bottomnavigationBarController.selectedPage = 0.obs;
              Get.to(BottomnavigationBarView());
            } else {
              Get.back();
            }
          },
          backarrowISDisplay: true,
          svgImagePath: Constants.HOME,
          cont: Container(
            child: LocalVariables.userId == "Users" ? unSignIn(): SignIn(),
          ),
      ),
    );

  }
}

