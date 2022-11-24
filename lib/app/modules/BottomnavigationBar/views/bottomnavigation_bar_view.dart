import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/constants_colors.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/About_Us/views/dashboard_about_us_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Privacy_Policy/views/dashboard_privacy_policy_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Setting/views/dashboard_setting_view.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/views/dashboard_score_board_view.dart';
import 'package:little_dino_app/app/modules/login/controllers/login_controller.dart';
import 'package:little_dino_app/app/modules/login/views/login_view.dart';
import '../controllers/bottomnavigation_bar_controller.dart';



class BottomnavigationBarView extends GetView<BottomnavigationBarController> {
  @override
  Widget build(BuildContext context) {
    BottomnavigationBarController controller = Get.put(BottomnavigationBarController());
    LoginController loginController = Get.put(LoginController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil().setSp(20);
    ScreenUtil().setWidth(540);
    ScreenUtil().setHeight(200);
    Firebase.initializeApp();
    LocalVariables.fromScreen = '';
    Widget menus({required String title,required String path,required Function() fun}){
      return InkWell(
        onTap: fun,
        child: Container(
          height: 40.sp,
          margin: EdgeInsets.only(bottom: 10.sp),
          child: Row(
            children: [
              Container(
                height: 40.sp,
                width: 40.sp,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ConstantsColors.whitecolor.withOpacity(0.8))
                ),
                child: SvgPicture.asset(path,fit: BoxFit.cover,color: ConstantsColors.whitecolor.withOpacity(0.8)),
              ),
              SizedBox(width: 10.sp),
              Text(title,style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w600,color: ConstantsColors.whitecolor.withOpacity(0.8)))
            ],
          )
        ),
      );
    }

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    exitpopButtons({required String buttontitle,required Color backgroundColor,required Color bordercolor,required Function() onpres}){
     return Container(
        width: width*0.4,
        height: 45.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: bordercolor,
                width: 1.8
            )
        ),
        child: ElevatedButton(
            onPressed: onpres,
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                ),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all(backgroundColor)
            ),
            child: Text("$buttontitle",style: TextStyle(color: CupertinoColors.white,fontWeight: FontWeight.w600,fontSize: 24.sp))
        ),
      );
    }

    exitPopup(){
      return Container(
        width: width,
        height: 350.sp,
        padding: EdgeInsets.only(left: 20.sp,right: 20.sp,bottom: 20.sp),

        child: Column(
          children: [
            SizedBox(height: 20.sp),
            SvgPicture.asset("assets/bottomnavigationBar/exit_image.svg",width: 270.sp),
            SizedBox(height: 28.sp),
            Text("Do You Want To Exit?",style: TextStyle(color: ConstantsColors.fontColor,fontSize: 20.sp,fontWeight: FontWeight.w600)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                exitpopButtons(buttontitle: "Exit",backgroundColor: Color.fromRGBO(249, 51, 51, 1),bordercolor: Color.fromRGBO(177, 41, 41, 1),onpres: () => exit(0)),
                exitpopButtons(buttontitle: "Cancel",backgroundColor: Color.fromRGBO(8, 153, 58, 1),bordercolor: Color.fromRGBO(1,118,41,1),onpres: () => Get.back())
              ],
            )
          ],
        ),
      );
    }



    return WillPopScope(
      onWillPop: () {
        print("controller.selectedPage.value == 0 ------------------->${controller.selectedPage.value == 0}");
        if(controller.selectedPage.value != 0){
          controller.selectedPage.value = 0;
        }
        else{
          print("----------------------------");
          showModalBottomSheet(
            backgroundColor: CupertinoColors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50.sp),
                    topLeft: Radius.circular(50.sp)
                )
            ),
            context: context,
            builder: (context) {
              print("******************************");
              return exitPopup();
            },
          );
        }
        return Future.value(false);
      },
      child: AdvancedDrawer(
        backdropColor: Color.fromRGBO(126, 163 , 0, 1),
        controller: controller.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        childDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        disabledGestures: true,
        openRatio: 0.63,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
              body: Obx(() => controller.lstpages.value[controller.selectedPage.value],),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Obx(() => Visibility(
                  visible: !keyboardIsOpen,
                  child: Container(
                    // color: Colors.yellow,
                    width: width,
                    child: CurvedNavigationBar(
                    index: controller.selectedPage.value,
                    height:40.sp,
                    items: <Widget>[
                      controller.selectedPage.value == 0?
                      Container(
                          width: 30.sp,
                          height: 30.sp,
                          padding: EdgeInsets.all(3.sp),
                          child: SvgPicture.asset("assets/bottomnavigationBar/home.svg",color: Colors.white,fit: BoxFit.cover,)) :
                      SvgPicture.asset("assets/bottomnavigationBar/home.svg",fit: BoxFit.cover),
                      controller.selectedPage.value == 1?
                      Container(
                          width: 30.sp,
                          height: 30.sp,
                          padding: EdgeInsets.all(3.sp),
                          child: SvgPicture.asset("assets/bottomnavigationBar/category.svg",fit: BoxFit.cover,color: Colors.white)):
                      SvgPicture.asset("assets/bottomnavigationBar/category.svg",fit: BoxFit.cover),

                      controller.selectedPage.value == 2?
                        Container(
                          width: 30.sp,
                          height: 30.sp,
                          padding: EdgeInsets.all(3.sp),
                          child:
                          SvgPicture.asset("assets/bottomnavigationBar/quiz.svg",fit: BoxFit.cover,color: Colors.white)):
                          SvgPicture.asset("assets/bottomnavigationBar/quiz.svg",fit: BoxFit.cover),

                      controller.selectedPage.value == 3?
                      Container(
                          width: 30.sp,
                          height: 30.sp,
                          padding: EdgeInsets.all(3.sp),
                          child:
                          SvgPicture.asset("assets/bottomnavigationBar/profile.svg",fit: BoxFit.cover,color: Colors.white)):
                      SvgPicture.asset("assets/bottomnavigationBar/profile.svg",fit: BoxFit.cover),

                    ],
                    color: Colors.white,
                    buttonBackgroundColor: Colors.lightBlueAccent,
                    backgroundColor: Colors.transparent,
                    animationCurve: Curves.easeInOut,
                    animationDuration: Duration(milliseconds: 600),
                    onTap: (index) {
                      print("${controller.selectedPage.value}");
                      controller.selectedPage.value = index;
                    },
                    letIndexChange: (index) => true,
                  ),
                )
              ))
          ),
        ),
        drawer: SafeArea(
          child: Container(
            height: height,
            padding: EdgeInsets.only(left: 25.sp,top: 10.sp),
            child: Column(
              children: [
                ListTileTheme(
                  textColor: ConstantsColors.whitecolor.withOpacity(0.8),
                  iconColor: ConstantsColors.whitecolor.withOpacity(0.8),
                  contentPadding: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ListTile(
                        onTap: (){
                          controller.advancedDrawerController.hideDrawer();
                        },
                        leading: Container(
                          width: 40.sp,
                          height: 40.sp,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white.withOpacity(0.8))
                          ),
                          child: SvgPicture.asset('assets/drawer/close.svg',fit: BoxFit.cover,color: Colors.white.withOpacity(0.8)),
                        ),
                      ),
                      SizedBox(height: 15.sp),
                      menus(path: 'assets/drawer/home2.svg', title: 'Home',fun: () {
                        controller.selectedPage.value = 0;
                        controller.advancedDrawerController.hideDrawer();
                        Get.to(BottomnavigationBarView());
                      }
                      ),
                      menus(path: 'assets/drawer/categories.svg', title: 'Category',fun: () {
                        controller.selectedPage.value = 1;
                        controller.advancedDrawerController.hideDrawer();
                        Get.to(BottomnavigationBarView());
                      }),
                      menus(path: 'assets/drawer/quiz.svg', title: 'Quiz',fun: () {
                        controller.selectedPage.value = 2;
                        controller.advancedDrawerController.hideDrawer();
                        Get.to(BottomnavigationBarView());
                      }),
                      menus(path: 'assets/drawer/user.svg', title: 'Profile',fun: () {
                        controller.selectedPage.value = 3;
                        controller.advancedDrawerController.hideDrawer();
                        Get.to(BottomnavigationBarView());
                      }),
                      menus(path: 'assets/drawer/score.svg', title: 'Score Board',fun: () {
                        controller.advancedDrawerController.hideDrawer();
                        Get.to(DashboardScoreBoardView());
                      }),

                      Container(
                        margin: EdgeInsets.only(right: 50.sp),
                        child: Divider(
                          color: ConstantsColors.whitecolor.withOpacity(0.5),
                          endIndent: 50.sp,
                          height: 45.sp,
                          thickness: 1.5,
                        ),
                      ),
                      SizedBox(height: 8.sp),
                      menus(path: 'assets/drawer/aboutUs.svg', title: 'About Us',fun: () => Get.to(DashboardAboutUsView())),
                      menus(path: 'assets/drawer/privacyPolicy.svg', title: 'Privacy Policy',fun: () => Get.to(DashboardPrivacyPolicyView())),
                      menus(path: 'assets/drawer/settings.svg', title: 'Setting',fun: () => Get.to(DashboardSettingView()))
                    ],
                  ),
                ),
                Spacer(),
                Divider(
                  color: ConstantsColors.whitecolor.withOpacity(0.5),
                  height: 0,
                  thickness: 1.5,
                ),
                CupertinoButton(
                  onPressed: (){
                    controller.advancedDrawerController.hideDrawer();
                    LoginController().logOut();
                    loginController.isLoaded.value = false;
                    loginController.email.text = '';
                    loginController.pass.text = '';
                    Get.to(LoginView());
                  },
                  padding: EdgeInsets.zero, 
                  child: Text(LocalVariables.userId == "Users" ? "Sign In" : "Sign Out",style: TextStyle(color: ConstantsColors.whitecolor.withOpacity(0.8),fontWeight: FontWeight.w400,fontSize: 17.sp)),
                ),
              ],
            )
          )
        
        )
      )
    );
  }
}
