import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/controllers/levelscreens_quiz_screen_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/quizquesion_model.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/views/levelscreens_quiz_screen_view.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/controllers/dashboard_quiz_caterogies_controller.dart';
import 'package:flutter/material.dart';

class UnplayedQuiz extends GetView<DashboardQuizCaterogiesController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil().setSp(24);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    LevelscreensQuizScreenController quizScreenController = LevelscreensQuizScreenController();


    Widget designs({required detail,clr, vector_color}){
      print("detail.vactor_color detail.vactor_color------------------------>$vector_color");
      return InkWell(
        onTap: (){
          WidgetsBinding.instance.addPostFrameCallback((_){
            LocalVariables.selectedIndexOfQuizCategories = detail.id.toString();
            LocalVariables.selectedquiz_uniqId = detail.uniqid!;
            LocalVariables.selectedQuiedname = detail.title!;
            Map<String,dynamic> mapdata = {
              'id' : detail.id,
              'uniqid' : detail.uniqid,
              'title' : detail.title,
              'categoryId' : detail.categoryId,
              'quizTypeId' : detail.quizTypeId,
              'category' : detail.category,
              'quizType' : detail.quizType,
              'image' : detail.image,
              'color' : detail.color,
              'vactor_color' : "${detail.vactor_color}",
              'indicator_color' : detail.indicator_color,
              'totleQuestions' : detail.question?.length.toString() ?? '',
              'answer' : "0",
              'Time' : DateTime.now().toString(),
            };
            print("unplayed Quiz mapdata ------------------>${mapdata}");
            LocalVariables.savedQuizCategories = mapdata;
            Get.to(() => LevelscreensQuizScreenView());
          });
        },
        child: Container(
          width: width,
          height: 110.sp,
          decoration: BoxDecoration(
              color: clr.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight:  Radius.circular(20),
                  topRight:  Radius.circular(20)
              )
          ),
          child: Row(
            children: [
              Container(
                  width: 100.sp,
                  padding: EdgeInsets.only(left: 10.sp,right: 10.sp,bottom: 10.sp),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      detail.vactor_color != '' ? SvgPicture.asset("assets/vector.svg",color: vector_color) : SizedBox.shrink(),
                      Image.network(detail.image!,width: 70.sp)
                    ],
                  )
              ),
              Container(
                  width : 210.sp,
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(detail.title!,style: TextStyle(color: ConstantsColors.fontColor,fontWeight: FontWeight.w600,fontSize: 20.sp)),
                      SizedBox(height: 5.sp),
                      Text("${detail.question?.length ?? 0} Questions",style: TextStyle(color: ConstantsColors.fontColor,fontSize: 15.sp,fontWeight: FontWeight.w600)),
                    ],
                  )
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: height,
        padding: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 20.sp),
        child: FutureBuilder<Quizquesion?>(
          future: quizScreenController.getdata(),
          builder: (context,AsyncSnapshot<Quizquesion?> snapshot) {
            if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                var data = snapshot.data!.data;
                return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10.sp),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data!.length,
                  itemBuilder:(context, index) {
                    var detail = data[index];
                    print("detail.title ----------------------->${detail.title}");
                    print("detail.uniqid ----------------------->${detail.uniqid}");
                    var clr = HexColor(detail.color.toString());
                    var vectorColor = detail.vactor_color != '' ? HexColor("${detail.vactor_color}") : HexColor("${detail.color}");
                    var indicator_color = detail.indicator_color != '' ? HexColor("${detail.indicator_color}") : HexColor("${detail.color}");
                    print("indicator_color ----------------------->${indicator_color}");
                    print(" ");

                    return LocalVariables.userId == 'Users' ?
                            FutureBuilder<int>(
                            future: controller.unplayedquizusingHive(quizCategoriesUniId: detail.uniqid!,quizUniqId: LocalVariables.quizType_uniqueId),
                            builder:(context,AsyncSnapshot<int> snapshot) {
                              if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
                                if(snapshot.hasData){
                                  return snapshot.data == 0 ?
                                  designs(detail: detail,clr: clr,vector_color: vectorColor) : SizedBox.shrink();
                                }
                                else{
                                  return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                                }
                              }
                              else{
                                return FlutterWidgets.disconnected();
                              }
                            },
                          ) :
                            StreamBuilder<int>(
                                stream: controller.unplayedquizusingFCM(quizUniqId: LocalVariables.quizType_uniqueId,quizCategoriesUniId: detail.uniqid!),
                                builder: (context,AsyncSnapshot<int> snapshot) {
                                  if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
                                    if(snapshot.hasData) {
                                      return snapshot.data == 0 ?
                                      designs(detail: detail,clr: clr,vector_color: vectorColor):
                                      SizedBox();
                                    }
                                    else if(!snapshot.hasData) {
                                      return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                                    }
                                    else {
                                      return FlutterWidgets.disconnected();
                                    }
                                  }
                                  else{
                                    return SizedBox();
                                  }
                                },
                              ) ;
                  },
                );
              }
              else if(!snapshot.hasData){
                return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
              }
              else {
                return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
              }
            } else {
              return FlutterWidgets.disconnected();
            }
          },
        ),
      ),
    );
  }
}