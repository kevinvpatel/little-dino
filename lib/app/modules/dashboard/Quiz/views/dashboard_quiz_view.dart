import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/controllers/dashboard_home_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/quiz_model.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/providers/quiz_caterodies_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/views/dashboard_quiz_caterogies_view.dart';
import '../controllers/dashboard_quiz_controller.dart';

class DashboardQuizView extends GetView<DashboardQuizController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil().setWidth(540);
    ScreenUtil().setHeight(200);
    ScreenUtil().setSp(24);
    DashboardQuizController controller = DashboardQuizController();
    DashboardHomeController dashboardHomeController = Get.put(DashboardHomeController());

    TextStyle header = TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: ConstantsColors.fontColor,overflow: TextOverflow.ellipsis);
    TextStyle desc = TextStyle(fontSize: 15.sp, color: ConstantsColors.fontColor,fontWeight: FontWeight.w600);

    addQuizData(details,mapData) async {
      final _quizdetailBox = Hive.box("QuizData");
      _quizdetailBox.put(details.uniqid, mapData);
    }

    return Templates.detailsScreens(
      title: "Quiz",
      context: context,
      onTap: (){},
      backarrowISDisplay: false,
      svgImagePath: Constants.NOTIFICATION,
      cont: Container(
        padding: EdgeInsets.only(left: 20.sp, right: 20.sp,top: 10.sp),
        child: FutureBuilder<Quiz?>(
          future: dashboardHomeController.quizdeatils(),
          builder: (BuildContext context,
              AsyncSnapshot<Quiz?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                var data = snapshot.data!.data!;
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
                    childAspectRatio:0.85.sp,
                  ),
                  itemBuilder: (context, index) {
                    var details = data[index];
                    return InkWell(
                      onTap: () async {

                        print('details.uniqid!## -> ${details.uniqid!}');
                        LocalVariables.quizType_uniqueId = details.uniqid!;
                        LocalVariables.selectedquiz = details.name!;
                        LocalVariables.selectedquiz_Id = details.id!;
                        Map<String,dynamic> mapdata = {
                          "Id": details.id,
                          "uniqid":  details.uniqid,
                          "name":  details.name,
                          "color":  details.color,
                          "vactor_color":  details.vactor_color,
                          "image":  details.image,
                          "totalItem": details.total
                        };
                        LocalVariables.userId == "Users" ? addQuizData(details,mapdata) : '';
                        LocalVariables.savedQuiz = mapdata;
                        Get.to(DashboardQuizCaterogiesView());
                        await QuizCaterodiesProvider().getQuizCaterodies(id: details.uniqid!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor(
                              details.color!),
                          borderRadius: BorderRadius
                              .only(
                              bottomRight: Radius
                                  .circular(25),
                              bottomLeft: Radius
                                  .circular(25),
                              topRight: Radius
                                  .circular(25)
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.sp),
                            Container(
                              alignment: Alignment
                                  .center,
                              child: CachedNetworkImage(
                                  imageUrl: details.image!,
                                  fit: BoxFit.cover,
                                  width: 80.sp),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets
                                  .only(left: 18.sp,
                                  right: 18.sp,
                                  bottom: 10.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .end,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(details.name!,
                                      style: header,maxLines: 1),
                                  SizedBox(
                                      height: 2.sp),
                                  Text("Total:${ details.total}",
                                      style: desc)
                                ],
                              ),
                            ),
                            SizedBox(height: 3.sp)
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              else if (snapshot.hasError) {
                return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
              }
              else {
                return Center(
                  child: CircularProgressIndicator(
                      color: Colors.orange),
                );
              }
            }
            else {
              return Center(
                child: CircularProgressIndicator(
                    color: Colors.orange),
              );
            }
          },
        ),
      ),
    );
  }
}
