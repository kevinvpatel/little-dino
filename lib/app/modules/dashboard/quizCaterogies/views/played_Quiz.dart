import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/views/levelscreens_quiz_screen_view.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/controllers/dashboard_quiz_caterogies_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/scordBoardHive_Model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class playedQuiz extends GetView<DashboardQuizCaterogiesController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil().setSp(24);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Widget design({required data}){
      return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10.sp),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder:(context, index) {
          var detail = data[index];
          var clr = HexColor(detail.color!);
          print("detail.indicator_color detail.indicator_color --------------------->${detail.indicator_color}");
          return Container(
            width: width,
            height: 120.sp,
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
                    padding: EdgeInsets.all(10.sp),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        detail.vactor_color != null ? SvgPicture.asset("assets/vector.svg",color: HexColor(detail.vactor_color)):SizedBox.shrink(),
                        Image.network(detail.image!,width: 70.sp)
                      ],
                    )
                ),
                Container(
                    width : 150.sp,
                    height: 100.sp,
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(detail.title!, style: TextStyle(color: ConstantsColors.fontColor,fontWeight: FontWeight.w600,fontSize: 20.sp)),
                        SizedBox(height: 2.sp),
                        Text(DateFormat("dd-MMMM-yyyy").format(DateFormat("yyyy-MM-dd").parse(detail.time!)),style: TextStyle(color: ConstantsColors.fontColor,fontSize: 13.sp,fontWeight: FontWeight.w600)),
                        SizedBox(height: 13.sp),
                        SizedBox(
                          height: 35.sp,
                          child: CupertinoButton(
                            alignment: Alignment.center,
                            onPressed: (){
                              LocalVariables.selectedQuiedname = detail.title!;
                              LocalVariables.selectedquiz_uniqId = detail.uniqid!;
                              LocalVariables.selectedIndexOfQuizCategories = detail.id.toString();
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
                                'vactor_color' : detail.vactor_color,
                                'indicator_color' : detail.indicator_color,
                                'totleQuestions' : '0',
                                'answer' : "0",
                                'Time' : DateTime.now().toString(),
                              };
                              LocalVariables.savedQuizCategories = mapdata;
                              if(LocalVariables.userId != "Users") {
                                FirebaseFirestore.instance.collection("users").doc(LocalVariables.userId).
                                collection('ScoarBoard').doc(LocalVariables.quizType_uniqueId).collection('scoars').doc(detail.uniqid).delete();
                              }
                              else{
                                final _myBox = Hive.box(LocalVariables.quizType_uniqueId);
                                _myBox.delete(detail.uniqid);
                              }
                              Get.to(LevelscreensQuizScreenView());
                            },
                            borderRadius: BorderRadius.circular(20),
                            color: HexColor(detail.indicator_color),
                            padding: EdgeInsets.symmetric(horizontal: 15.sp),
                            child: Text("Retake Quiz",style: TextStyle(color: CupertinoColors.white,fontSize: 15.sp,fontWeight: FontWeight.w500)),
                          ),
                        )
                      ],
                    )
                ),
                Spacer(),
                Container(
                    width: 70.sp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70.sp,
                          alignment: Alignment.center,
                          child: CircularPercentIndicator(
                            radius: 30.0,
                            lineWidth: 5.0,
                            percent: 0.5,
                            backgroundColor: HexColor(detail.indicator_color ?? detail.vactor_color ),
                            center: Text("${((detail.answer!/detail.totleQuestions!)*100).ceil()}%",style: TextStyle(color: HexColor(detail.indicator_color ?? detail.vactor_color),fontWeight: FontWeight.w600,fontSize: 18.sp)),
                            progressColor: HexColor( detail.indicator_color ?? detail.vactor_color),
                          ),
                        ),
                        Text("${detail.answer}/${detail.totleQuestions}",style: TextStyle(color: ConstantsColors.fontColor,fontWeight: FontWeight.w700,fontSize: 15.sp)),
                      ],
                    )
                ),
              ],
            ),
          );
        },
      );
    }




    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: height,
        padding: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 20.sp),
        child: LocalVariables.userId == 'Users' ?
        FutureBuilder<ScoarBoard?>(
            future: controller.playedquizFromHive(quizUniqid: LocalVariables.quizType_uniqueId),
            builder:(context,AsyncSnapshot<ScoarBoard?> snapshot) {
              if(snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active){
                if(snapshot.hasData){
                  var data = snapshot.data!.data;
                  return data!.length != 0 ?
                  design(data: data) :
                  FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                }
                else{
                  return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
                }
              }
              else{
                return Center(
                  child: CircularProgressIndicator(color: ConstantsColors.orangeColor),
                );
              }
            },
          )
         : StreamBuilder<ScoarBoard?>(
          stream: controller.playedquizFromFCM(quizUniqId:LocalVariables.quizType_uniqueId),
          builder: (context,AsyncSnapshot<ScoarBoard?> snapshot) {
            if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                var data = snapshot.data!.data;

                return data!.length == 0 ?
                FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height)  :
                design(data: data);
              }
              else{
                return FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height);
              }
            }
            else{
              return Center(
                child: Text("Disconnected"),
              );
            }
          },
        ),
      ),
    );
  }
}