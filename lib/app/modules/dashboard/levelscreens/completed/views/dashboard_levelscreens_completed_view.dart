import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/views/dashboard_quiz_caterogies_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../controllers/dashboard_levelscreens_completed_controller.dart';

class DashboardLevelscreensCompletedView
    extends GetView<DashboardLevelscreensCompletedController> {
  @override
  Widget build(BuildContext context) {
    DashboardLevelscreensCompletedController controller = Get.put(DashboardLevelscreensCompletedController());
    ScreenUtil().setSp(24);
    controller.controllerCenter = ConfettiController(duration: const Duration(microseconds: 2000));
    controller.controllerCenter.play();
    dataEnterinHive() async {
      await Hive.openBox(LocalVariables.quizType_uniqueId).then((value) {
        final _box =  Hive.box(LocalVariables.quizType_uniqueId);
        var data = _box.get(LocalVariables.selectedCategory_uniqueId);
        if(data != null){
          Map<String,dynamic> mapData = {
            "id" : data['id'],
            "uniqid" : data['uniqid'],
            "title" : data['title'],
            "categoryId" : data['categoryId'],
            "quizTypeId" : data['quizTypeId'],
            "category" : data['category'],
            "quizType" : data['quizType'],
            "image" : data['image'],
            "color" : data['color'],
            "totleQuestions" : LocalVariables.totlequestions ,
            "answer" : LocalVariables.riteAnswers,
            "Time" : DateTime.now()
          };
          _box.put(data['uniqid'], mapData);
        }
      });
    }
     LocalVariables.userId == 'Users' ? dataEnterinHive():'';
    print('LocalVariables.riteAnswers -> ${LocalVariables.riteAnswers}');
    print('LocalVariables.totlequestions -> ${LocalVariables.totlequestions}');
    return WillPopScope(
      onWillPop:() => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ConstantsColors.backgroundcolor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: controller.controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: 0,
                  emissionFrequency: 0.5,
                  numberOfParticles: 65,
                  gravity: 0.1,
                  shouldLoop: false,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Quiz Completed",style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromRGBO(141, 182, 0, 1),fontSize: 25.sp)),
                  SvgPicture.asset("assets/level/trofy.svg",width: 200.sp),
                  Text(LocalVariables.selectedquiz, style: TextStyle(fontSize: 23.sp,color: Colors.black,fontWeight: FontWeight.w500)),
                  SizedBox(height: 20.sp),
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: LocalVariables.riteAnswers / LocalVariables.totlequestions,
                    center: Text(
                      "${LocalVariables.riteAnswers}/${LocalVariables.totlequestions}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: Color.fromRGBO(255, 201, 215, 1),
                    progressColor: Color.fromRGBO(249, 100, 138, 1),
                  ),
                ],
              ),

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20.sp,right: 20.sp,bottom: 20.sp),
          decoration: BoxDecoration(
              color: Color.fromRGBO(95, 207, 255, 1),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Color.fromRGBO(29, 123, 212, 1)
              )
          ),
          child: ElevatedButton(
            onPressed: (){
              LocalVariables.fromCompelet = true;

              Get.to(DashboardQuizCaterogiesView());
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all( Color.fromRGBO(95, 207, 255, 1)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              )
            ),
            child: Text("Finish",style: TextStyle(color: ConstantsColors.whitecolor,fontWeight: FontWeight.w600,fontSize: 20.sp)),
          ),
        )
      ),
    );
  }
}


