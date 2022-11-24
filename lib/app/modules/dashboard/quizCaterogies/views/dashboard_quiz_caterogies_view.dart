import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/constants.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/controllers/bottomnavigation_bar_controller.dart';
import 'package:little_dino_app/app/modules/BottomnavigationBar/views/bottomnavigation_bar_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Template.dart';
import 'package:little_dino_app/app/modules/dashboard/levelscreens/quizScreen/controllers/levelscreens_quiz_screen_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/views/played_Quiz.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/views/unplayed_quiz.dart';
import '../controllers/dashboard_quiz_caterogies_controller.dart';

class DashboardQuizCaterogiesView
    extends GetView<DashboardQuizCaterogiesController> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil().setSp(24);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DashboardQuizCaterogiesController controller = Get.put(DashboardQuizCaterogiesController());
    BottomnavigationBarController bottomnavigationBarController = BottomnavigationBarController();

    // hiveData(details) async {
    //   await Hive.openBox("${LocalVariables.selectedquiz_uniqueId}").then((value) => print("Box is Opend"));
    //   final _myquizCategories = Hive.box(LocalVariables.selectedquiz_uniqueId);
    //   Map<String,dynamic> mapData = {};
    //   print("_myquizCategories.length ------------------>${_myquizCategories.get(details.uniqid)}");
    //   if(_myquizCategories.get(details.uniqid) == null){
    //     mapData = {
    //       "id" : details.id,
    //       "uniqid" : details.uniqid,
    //       "title" : details.title,
    //       "categoryId" : details.categoryId,
    //       "quizTypeId" : details.quizTypeId,
    //       "category" : details.category,
    //       "quizType" : details.quizType,
    //       "image" : details.image,
    //       "color" : details.color,
    //       "totleQuestions" : 0 ,
    //       "answer" : 0 ,
    //     };
    //   }else{
    //     var datas = _myquizCategories.get(details.uniqid);
    //     print("datas -------------->$datas");
    //     mapData = {
    //       "id" : datas['id'],
    //       "uniqid" : datas['uniqid'],
    //       "title" : datas['title'],
    //       "categoryId" : datas['categoryId'],
    //       "quizTypeId" : datas['quizTypeId'],
    //       "category" : datas['category'],
    //       "quizType" : datas['quizType'],
    //       "image" : datas['image'],
    //       "color" : datas['color'],
    //       "totleQuestions" :  datas['totleQuestions'],
    //       "answer" : datas['answer'],
    //     };
    //   }
    //   _myquizCategories.put(details.uniqid , mapData);
    //
    // }

    return WillPopScope(
      onWillPop: () {
        bottomnavigationBarController.selectedPage.value = 2;
        bottomnavigationBarController.advancedDrawerController.hideDrawer();
        Get.to(BottomnavigationBarView());
        return Future.value(false);
      },
      child: Templates.detailsScreens(
        title: LocalVariables.selectedquiz,
        context: context,
        svgImagePath: Constants.BACK_HOME,
        backarrowISDisplay: true,
        ontapback: () {
          bottomnavigationBarController.selectedPage.value = 2;
          bottomnavigationBarController.advancedDrawerController.hideDrawer();
          Get.to(BottomnavigationBarView());
        },
        onTap: (){},
        cont: Container(
          height: height,
          padding: EdgeInsets.only(top: 10.sp),
          child: DefaultTabController(
            length: 2,
            child:Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: SegmentedTabControl(
                    // Customization of widget
                    radius: Radius.circular(50.sp),
                    backgroundColor: Color.fromRGBO(255, 232, 190, 1),
                    indicatorColor: Color.fromRGBO(250, 181, 5, 1),
                    tabTextColor: ConstantsColors.fontColor,
                    selectedTabTextColor: ConstantsColors.whitecolor,
                    squeezeIntensity: 2,
                    textStyle: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500),
                    height: 45.sp,
                    tabPadding: EdgeInsets.symmetric(horizontal: 8.sp),
                    // Options for selection
                    // All specified values will override the [SegmentedTabControl] setting
                    tabs: [
                      SegmentTab(
                        label: 'Played',
                      ),
                      SegmentTab(
                        label: 'Unplayed',
                      ),
                    ],
                  ),
                ),
                // Sample pages
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      playedQuiz(),
                      UnplayedQuiz(),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
