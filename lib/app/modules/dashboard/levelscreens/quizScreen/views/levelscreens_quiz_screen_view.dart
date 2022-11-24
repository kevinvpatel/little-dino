import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipecards/flutter_swipecards.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/controllers.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/completed/views/dashboard_levelscreens_completed_view.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/quizquesion_model.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/views/dashboard_quiz_caterogies_view.dart';
import '../controllers/levelscreens_quiz_screen_controller.dart';
import 'package:flutter/foundation.dart';

enum Answer { right, wrong, none }

class LevelscreensQuizScreenView
    extends GetView<LevelscreensQuizScreenController> {
  @override
  Widget build(BuildContext context) {
    LevelscreensQuizScreenController controller =
        Get.put(LevelscreensQuizScreenController());
    controller.selectedanswer.value = Answer.none;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    controller.onInit();
    BottomnavigationBarController bottomnavigationBarController =
        Get.put(BottomnavigationBarController());
    ScreenUtil().setSp(24);
    CardController cardController = CardController();

    ///Left Swipe
    lt() {
      controller.singleAnser.value == 0;
      cardController.triggerLeft();
    }

    ///Right Swipe
    rt({required int totalquestions}) async {
      controller.singleAnser.value == 1;
      cardController.triggerRight();
      LocalVariables.riteAnswers++;
      Map<String, dynamic> mapData = {
        "id": LocalVariables.savedQuizCategories['id'],
        "uniqid": LocalVariables.savedQuizCategories['uniqid'],
        "title": LocalVariables.savedQuizCategories['title'],
        "categoryId": LocalVariables.savedQuizCategories['categoryId'],
        "quizTypeId": LocalVariables.savedQuizCategories['quizTypeId'],
        "category": LocalVariables.savedQuizCategories['category'],
        "quizType": LocalVariables.savedQuizCategories['quizType'],
        "image": LocalVariables.savedQuizCategories['image'],
        "color": LocalVariables.savedQuizCategories['color'],
        "indicator_color": LocalVariables.savedQuizCategories['indicator_color'],
        "vactor_color": LocalVariables.savedQuizCategories['vactor_color'],
        "totleQuestions": LocalVariables.totlequestions,
        "answer": LocalVariables.riteAnswers,
        "Time": DateTime.now().toString()
      };
      if (LocalVariables.userId == 'Users') {
        await Hive.openBox(LocalVariables.quizType_uniqueId).then((value) {
          final _box = Hive.box(LocalVariables.quizType_uniqueId);
          _box.put(LocalVariables.savedQuizCategories['uniqid'], mapData);
        });
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(LocalVariables.userId)
            .collection("ScoarBoard")
            .doc(LocalVariables.savedQuiz['uniqid'])
            .set(LocalVariables.savedQuiz);
        FirebaseFirestore.instance
            .collection("users")
            .doc(LocalVariables.userId)
            .collection("ScoarBoard")
            .doc(LocalVariables.savedQuiz['uniqid'])
            .collection('scoars')
            .doc(LocalVariables.savedQuizCategories['uniqid'])
            .set(mapData);
      }
    }

    ///Wrong Right Answer Card
    answerisWrongOrRight(
        {required String question,
        required String sortAnswer,
        required selectedAnser}) {
      String ans1 = selectedAnser[0] != '' ? "${selectedAnser[0]}" : '';
      String ans2 = selectedAnser[1] != '' ? " , ${selectedAnser[1]}" : '';
      String ans3 = selectedAnser[2] != '' ? " , ${selectedAnser[2]}" : '';
      String ans4 = selectedAnser[3] != '' ? " , ${selectedAnser[3]}" : '';
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        decoration: BoxDecoration(
            color: controller.singleAnser.value == 1
                ? Color.fromRGBO(198, 253, 217, 1)
                : Color.fromRGBO(255, 208, 208, 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70.sp),
            SvgPicture.asset(
                controller.singleAnser.value == 1
                    ? "assets/rightAnswer.svg"
                    : "assets/wrongAnser.svg",
                width: 90.sp,
                fit: BoxFit.cover),
            SizedBox(height: 70.sp),
            Text(
              "$question",
              style: TextStyle(
                  color: ConstantsColors.fontColor,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.sp),
            Container(
                width: 250.sp,
                child: Text(
                  "You Select ${ans1}${ans2}${ans3}${ans4} that's  ${controller.singleAnser.value == 1 ? "Right Answer" : "Wrong Answer so the Right Answer is "} $sortAnswer",
                  style: TextStyle(
                      color: ConstantsColors.fontColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp),
                  textAlign: TextAlign.center,
                )),
            Spacer(),
            Container(
              width: 250.sp,
              height: 40.sp,
              margin: EdgeInsets.only(bottom: 20.sp),
              decoration: BoxDecoration(
                color: ConstantsColors.whitecolor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: controller.singleAnser.value == 1
                        ? Color.fromRGBO(8, 153, 58, 1)
                        : Color.fromRGBO(249, 51, 51, 1),
                    width: 2),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    controller.selectedanswer.value = Answer.none;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        controller.singleAnser.value == 1
                            ? Color.fromRGBO(153, 237, 182, 1)
                            : Color.fromRGBO(255, 208, 208, 1)),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  child: Text("Next Card",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: controller.singleAnser.value == 1
                              ? Color.fromRGBO(8, 153, 58, 1)
                              : Color.fromRGBO(249, 51, 51, 1)))),
            )
          ],
        ),
      );
    }


    return Templates.detailsScreens(
      title: LocalVariables.selectedQuiedname,
      context: context,
      backarrowISDisplay: true,
      svgImagePath: Constants.HOME,
      onTap: () {
        bottomnavigationBarController.selectedPage.value = 0;
        bottomnavigationBarController.advancedDrawerController.hideDrawer();
        Get.to(BottomnavigationBarView());
      },
      ontapback: () => Get.to(DashboardQuizCaterogiesView()),
      cont: Container(
        height: height,
        padding: EdgeInsets.only(top: 20.sp,left: 20.sp,right: 20.sp),
        child: Column(
          children: [
            Text(LocalVariables.selectedquiz,
                style: TextStyle(
                    color: Colors.pink.withOpacity(0.8),
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w800)),
            SizedBox(height: height * 0.015),
            FutureBuilder<Quizquesion?>(
              future: controller.getdata(),
              builder: (context, AsyncSnapshot<Quizquesion?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    var data;
                    for(int i = 0 ; i < snapshot.data!.data!.length ; i++) {
                      print("abc  ${LocalVariables.selectedIndexOfQuizCategories} == ${snapshot.data!.data![i].id} ----------------->${LocalVariables.selectedIndexOfQuizCategories == snapshot.data!.data![i].id}");
                        if(LocalVariables.selectedIndexOfQuizCategories == snapshot.data!.data![i].id){
                          data = snapshot.data!.data![i];
                        }
                    }
                    LocalVariables.totlequestions = data.question?.length ?? 0;
                    controller.answers = List.generate(4, (index) => '').obs;
                    if(data.question?.length != null) {
                      return Container(
                        height: height * 0.7,
                        width: width,
                        child: TinderSwapCard(
                          totalNum: data.question?.length ?? 0,
                          maxHeight: height * 0.675,
                          minHeight: height * 0.66,
                          maxWidth: 300.sp,
                          minWidth: 250.sp,
                          cardController: cardController,
                          allowHorizontalMovement: false,
                          allowVerticalMovement: false,
                          swipeUpdateCallback: (dragUpdateDetails, alignment) {
                            print(" ");
                            print("swipeUpdateCallback DragUpdateDetails ------------------------- ${dragUpdateDetails}");
                            print("swipeUpdateCallback Alignment ------------------------- ${alignment}");
                          },
                          swipeCompleteCallback: (value, callback) {
                            print(" ");
                            print("swipeCompleteCallback value ------------------------- ${value}");
                            print("swipeCompleteCallback callback ------------------------- ${callback}");
                            if(value == CardSwipeOrientation.left || value == CardSwipeOrientation.right) {
                              controller.isItDisplay.value = false;
                              controller.selectedanswer.value = controller.singleAnser.value == 1 ? Answer.right : Answer.wrong;
                              controller.selectedIndex = ''.obs;
                              callback == data.question!.length - 1
                                  ? Get.to(DashboardLevelscreensCompletedView())
                                  : '';
                            }
                          },
                          disableBothMovement: true,
                          stackNum: 3,
                          orientation: AmassOrientation.bottom,
                          cardBuilder: (context, mainindex) {
                            var details = data.question![mainindex];
                            var clr = HexColor(details.color.toString());
                            controller.count.value = 0;
                            List opetions = details.option;
                            List answers = details.answer;
                            if(data.quizType != "Multiple Choice") {
                              // controller.selectedmultipleOptions =
                              //     List.generate(opetions.length, (index) => '').obs;
                              controller.selectedmultipleOptions =
                                  List.generate(1, (index) => '').obs;
                            } else {
                              controller.selectedmultipleOptions.clear();
                            }
                            controller.selectedAnswers =
                                List.generate(opetions.length, (index) => false)
                                    .obs;
                            controller.singleChoiseAnswer = opetions;
                            controller.istapeOrNot = false;
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    color: clr),
                                child: Obx(() => Stack(
                                  children:[
                                    controller.selectedanswer.value != Answer.none
                                        ? answerisWrongOrRight(
                                        question: '${data.question![mainindex != 0 ? mainindex - 1 : 0].question}',
                                        sortAnswer: '${data.question![mainindex != 0 ? mainindex - 1 : 0].sort_answer}',
                                        selectedAnser: controller.answers.value) :
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 14.sp,vertical: 10.sp) ,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                  "${mainindex + 1}/${data.question!.length}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 20.sp)),
                                              SizedBox(width: 8.sp)
                                            ],
                                          ),
                                          SizedBox(height: height*0.015),
                                          Container(
                                            width: 300.sp,
                                            height: height * 0.08,
                                            alignment: Alignment.center,
                                            child: Center(
                                              child: Text(
                                                " ${details.question}",
                                                style: TextStyle(
                                                    fontSize: 21.sp,
                                                    fontWeight: FontWeight.w600),
                                                maxLines: 3,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: height*0.015),
                                          details.image != ''
                                              ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SvgPicture.asset("assets/vector.svg", color: HexColor(details.vactor_color),width: height*0.13),
                                                  CachedNetworkImage(
                                                    imageUrl: details.image!,
                                                    width: height*0.10,
                                                    fit: BoxFit.cover,
                                                  )
                                                ],
                                              )
                                              : SizedBox.shrink(),
                                          SizedBox(height: height  * 0.015),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: opetions.length,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (context, index) {
                                              final options = opetions[index] is String ? opetions[index] : opetions[index]['name'];
                                              return Obx(() => InkWell(
                                                onTap: () {
                                                  controller.istapeOrNot = true;
                                                  controller.isItDisplay.value = true;
                                                  if (data.quizType == "Multiple Choice") {
                                                    print("controller.selectedAnswers.value[index] 11------------>${controller.selectedAnswers.value[index]}");
                                                    controller.selectedAnswers[index] = controller.selectedAnswers.value[index] == true ? false : true;
                                                    controller.answers[index] = controller.selectedAnswers.value[index] == true ? options : '';
                                                    int i = 0;
                                                    controller.selectedAnswers.forEach((element) {
                                                      // print("element 11------------>${element}");
                                                      // print("options 11------------>${options}");
                                                      // print("i 11------------>${index}");
                                                      // controller.selectedmultipleOptions.value[i] = element == true ? options : '';
                                                      if(element == true) {
                                                        if(controller.selectedmultipleOptions.contains(options) == false) {
                                                          // controller.selectedmultipleOptions.value.add(options);
                                                          controller.selectedmultipleOptions.value.add(index==0 ? 'A' : index==1 ? 'B' : index==2 ? 'C' : 'D');
                                                        }
                                                      }
                                                      // print("controller.selectedmultipleOptions.value 11------------>${controller.selectedmultipleOptions.value}");
                                                      i++;
                                                    });
                                                      print(" ");
                                                  } else {
                                                    if (answers[0] == "A" ||
                                                        answers[0] == "B" ||
                                                        answers[0] == "C" ||
                                                        answers[0] == "D") {
                                                      controller.selectedIndex.value = "$index";
                                                      // print('controller.selectedmultipleOptions -> ${controller.selectedmultipleOptions.length}');
                                                      // print('controller.opetions[index] -> ${controller.opetions[index]}');
                                                      controller.selectedmultipleOptions[0] = controller.opetions[index];
                                                      // controller.selectedmultipleOptions.add(controller.opetions[index]);
                                                      print('options -> ${options}');
                                                      controller.answers[0] = options.toString();
                                                    } else {
                                                      controller.selectedIndex.value = "$index";
                                                      controller.selectedmultipleOptions[0] = controller.singleChoiseAnswer[index];
                                                      // controller.selectedmultipleOptions.add(controller.singleChoiseAnswer[index]);
                                                      controller.answers[0] = options;
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  width: 250.sp,
                                                  height: height * 0.050,
                                                  margin: EdgeInsets.only(bottom: 10.sp),
                                                  decoration: BoxDecoration(
                                                    color: controller.ColorOfopetions[index],
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Text(
                                                          "${opetions[index] is String ? opetions[index] : opetions[index]['name']}",
                                                          style: TextStyle(
                                                              fontSize: 18.sp,
                                                              fontWeight: FontWeight.w600,
                                                              color: ConstantsColors.whitecolor)),
                                                      data.quizType == "Multiple Choice" && controller.selectedAnswers[index] == true
                                                          ? Container(width: 250.sp,
                                                            alignment: Alignment.centerRight,
                                                            child: Container(
                                                              width: 23.sp,
                                                              height: 23.sp,
                                                              padding: EdgeInsets.all(3.sp),
                                                              margin: EdgeInsets.only(right: 4.sp),
                                                              decoration: BoxDecoration(
                                                                  color: ConstantsColors.whitecolor,
                                                                  borderRadius: BorderRadius.circular(100)),
                                                              child: SvgPicture.asset(
                                                                  "assets/cheackmark.svg"),
                                                            ),
                                                          )
                                                          : SizedBox(
                                                            width: 20.sp,
                                                            height: height * 0.020,
                                                          ),
                                                      controller.selectedIndex.value != ''
                                                          ? data.quizType != "Multiple Choice" && int.parse(controller.selectedIndex.value.toString()) == index
                                                          ? Container(
                                                            width: 250.sp,
                                                            alignment: Alignment.centerRight,
                                                            child: Container(
                                                              width: 23.sp,
                                                              height: 23.sp,
                                                              padding: EdgeInsets.all(3.sp),
                                                              margin: EdgeInsets.only(right: 4.sp),
                                                              decoration: BoxDecoration(
                                                                  color: ConstantsColors.whitecolor,
                                                                  borderRadius: BorderRadius.circular(100)),
                                                              child: SvgPicture.asset(
                                                                  "assets/cheackmark.svg"),
                                                            ),
                                                          )
                                                          : SizedBox(
                                                            width: 20.sp,
                                                            height: height * 0.020)
                                                          : SizedBox.shrink(),
                                                      //Radio Button

                                                      SizedBox(width: 10.sp)
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            },
                                          ),
                                          Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  if (controller.istapeOrNot == true) {
                                                    LocalVariables.question_uniqId = details.uniqid!;
                                                    List finalAnswers = [];
                                                    int flag = 0;
                                                    for (int i = 0; i < controller.selectedmultipleOptions.value.length; i++) {
                                                      controller.selectedmultipleOptions.value[i] != ''
                                                          ? finalAnswers.add(controller.selectedmultipleOptions.value[i].toString())
                                                          : '';
                                                    }
                                                    finalAnswers = finalAnswers.toSet().toList();
                                                    print('finalAnswers.length -> ${finalAnswers}');
                                                    print('answers.length -> ${answers}');
                                                    if (finalAnswers.length == answers.length) {
                                                      // for (int i = 0; i < answers.length; i++) {
                                                      //   flag = finalAnswers[i] == answers[i] ? 1 : 0;
                                                      // }
                                                      ///check if finalAnswers list contain all elements as same as answers list
                                                      flag = finalAnswers.every((element) => answers.contains(element)) == true ? 1 : 0;
                                                      controller.singleAnser.value = flag;
                                                      flag == 1 ? rt(totalquestions: data.question!.length) : lt();
                                                    } else {
                                                      controller.singleAnser.value = flag;
                                                      flag = 0;
                                                      lt();
                                                    }
                                                    // print("finalansers ------------>$finalansers");
                                                    controller.setAnsers(lstans: finalAnswers);
                                                  } else {
                                                    FlutterWidgets.alertmesage(title: "Something is Wrong", message: "Please Select Anyone Option", fontsize: 20.sp, marginFormBottom: 12.sp);
                                                  }
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(10.sp),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                      color: ConstantsColors.orangeColor),
                                                  child: RotatedBox(
                                                    quarterTurns: 2,
                                                    child: SvgPicture.asset("assets/appbar/left-arrow.svg"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: height * 0.01)
                                        ],
                                      ),
                                    )],
                                )),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Expanded(
                        child: FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height),
                      );
                    }
                   } else {
                    return Expanded(
                      child: FlutterWidgets.noDataFound(headerFontSize: 25.sp,descriptionFontSize: 20.sp,space: 3.sp,width: width,height: height),
                    );
                   }
                } else {
                  return Expanded(
                    child: FlutterWidgets.disconnected(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
