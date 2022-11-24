import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/views/dashboard_home_view.dart';
import 'package:little_dino_app/app/modules/dashboard/Quiz/views/dashboard_quiz_view.dart';
import 'package:little_dino_app/app/modules/dashboard/category/views/dashboard_category_view.dart';
import 'package:little_dino_app/app/modules/dashboard/details/firstDetailPage/views/dashboard_details_first_detail_page_view.dart';
import 'package:little_dino_app/app/modules/dashboard/profile/views/dashboard_profile_view.dart';

class BottomnavigationBarController extends GetxController {
  //TODO: Implement BottomnavigationBarController

  final count = 0.obs;
  RxInt selectedPage = 0.obs;
  RxList lstpages = [
    DashboardHomeView(),
    DashboardCategoryView(),
    DashboardQuizView(),
    DashboardProfileView()
  ].obs;
  void handleMenuButtonPressed() {
    try{
      advancedDrawerController.showDrawer();
      advancedDrawerController.toggleDrawer();
    }catch(error){
      print("Error is ----------->$error");
    }
    update();
  }
  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();


  drawerItems({required String imagePath, String name = '', required Function() onTap, double padding = 8}) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        child: SvgPicture.asset(imagePath),
        height: 32.h,
        width: 32.h,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.6, color: Colors.white)
        ),
      ),
      title: Text(name, style: TextStyle(fontSize: 19),),
    );
  }

@override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    advancedDrawerController.hideDrawer;
    advancedDrawerController.dispose();
    update();
  }
  void increment() => count.value++;
}
