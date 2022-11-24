import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/controllers/dashboard_my_save_controller.dart';
import 'package:flutter/material.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/saved_categories_detail_model.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/views/display_Saved_categories.dart';


class DashboardSaveCategories extends GetView<DashboardMySaveController> {
  @override
  Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      ScreenUtil().setSp(24);
      DashboardMySaveController controller = Get.put(DashboardMySaveController());
      BottomnavigationBarController bottomnavigationBarController = BottomnavigationBarController();
      var mapdata = LocalVariables.savedCategories;
      LocalVariables.fromScreen = '';

      Widget dataScreen({required datas}) {
        return Column(
          children: [
            Container(
              width: width,
              height: 100.sp,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: HexColor(mapdata['color']),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft:  Radius.circular(20),
                      topRight:  Radius.circular(20)
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100.sp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 10.sp),
                              child: SvgPicture.asset("assets/vector.svg",color: HexColor(mapdata['vactor_color'].toString()),width: 70.sp),
                            ),
                            CachedNetworkImage(
                                imageUrl: mapdata['image'],
                                width: 65.sp,
                                fit: BoxFit.cover),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mapdata['name'], style: TextStyle(color: ConstantsColors.fontColor, fontSize: 20.sp, fontWeight: FontWeight.w800)),
                      SizedBox(height: 5.sp),
                      Text("Total: ${datas!.length}", style: TextStyle(color: ConstantsColors.fontColor, fontSize: 15.sp, fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 20),
                itemCount: datas!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var detail = datas[index];
                  return InkWell(
                    onTap: () {
                      LocalVariables.fromScreen = "mysaveDetailScreen";
                      LocalVariables.selectedCategory_uniqueId = mapdata['uniqid'];
                      LocalVariables.selectedCategory_title = mapdata['name'];
                      Map<String,dynamic> data = {
                        'id' : "${detail.id}",
                        'uniqid' : "${detail.uniqid}",
                        'categoryId' : "${detail.categoryId}",
                        'categoryuniqId' : "${mapdata['uniqid']}",
                        'title' : "${detail.title}",
                        'name' : "${detail.name}",
                        'color' : "${detail.color}",
                        'image' : "${detail.image}",
                        'audio_string' : "${detail.audio_string}",
                        'description' : "${detail.description}",
                        'vactor_color' : detail.vactor_color,
                        'title_color' : "${detail.title_color}",
                        'example' : "${detail.example}",
                        'index' : "${detail.index}"
                      };
                      LocalVariables.displaySvaedcategories = data;
                      Get.to(DisplaySvaedCategories());
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 3.sp, left: 5.sp),
                      decoration: BoxDecoration(
                          color: HexColor(detail.color!),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)
                          )
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          detail.vactor_color != '' ? Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 10.sp),
                            child: SvgPicture.asset("assets/vector.svg", color: HexColor(detail.vactor_color), width: 70.sp),
                          ) : SizedBox.shrink(),
                          CachedNetworkImage(
                              imageUrl: detail.image!,
                              width: 60.sp,
                              fit: BoxFit.cover),
                          detail.title != '' ? Positioned(
                              top: 0,
                              left: 0,
                              child: Text(detail.title!, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35.sp, color: HexColor(detail.title_color != ''?detail.title_color.toString():detail.vactor_color)))
                          ) : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }

      return Templates.detailsScreens(
          title: "Saved",
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
              height: height,
              padding: EdgeInsets.only(top: 20.sp,left: 20.sp,right: 20.sp),
              child: LocalVariables.userId == 'Users' ?
              FutureBuilder<SavedCategoriesDetailModel?>(
                future: controller.Details(uniqId: mapdata['uniqid']),
                builder: (context,AsyncSnapshot<SavedCategoriesDetailModel?> snapshot) {
                  if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasData){
                      var datas = snapshot.data!.data;
                      return dataScreen(datas: datas);
                    }
                    else if(!snapshot.hasData){
                      return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                    }
                    else{
                      return FlutterWidgets.disconnected();
                    }
                  }
                  else{
                    return SizedBox();
                  }
                },
              ):
              StreamBuilder<SavedCategoriesDetailModel?>(
                stream: controller.savedDataFCM(categoriesUniquesId: mapdata['uniqid']),
                  builder:(context,AsyncSnapshot<SavedCategoriesDetailModel?> snapshot) {
                    if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasData){
                        var datas = snapshot.data!.data;
                        return dataScreen(datas: datas);
                      }
                      else{
                        return FlutterWidgets.noDataFound(headerFontSize: 25.sp, descriptionFontSize: 20.sp, space: 3.sp, width: width, height: height);
                      }
                    }
                    else{
                      return SizedBox();
                    }
                  },
              )
          )
    );
  }
}