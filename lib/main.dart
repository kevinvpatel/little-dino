import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/controllers/dashboard_home_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();
  await Hive.openBox('users_Info');
  await Hive.openBox('CategoriesDetails');
  await Hive.openBox('QuizDetails');
  await Hive.openBox('Quiz');
  await Hive.openBox('Recent');
  await Hive.openBox('initializeCategiresCard');
  await Hive.openBox("QuizData");
  await Hive.openBox("savedFrontCategories");
  await Hive.openBox("savedCategories");
  final _myBox = Hive.box('users_Info');
  final categoryBox = await Hive.openBox('CategoriesDetails');

  FirebaseMessaging.instance.getInitialMessage();
  if(Platform.isAndroid) {
    FirebaseMessaging.instance.sendMessage();
  }
  var token = await FirebaseMessaging.instance.getToken();
  print("Print Instance Token ID: " + token!);


  // LocalVariables.getDataFrom_hive();

  DashboardHomeController().quizdeatils();

  AnalyticsController analyticsController = Get.put(AnalyticsController());

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Dosis',
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      navigatorObservers: <NavigatorObserver>[analyticsController.observer],
      title: "Application",
      color: Colors.transparent,
      initialRoute:  _myBox.get(1) == null ? categoryBox.values.isEmpty ? Routes.ONBOARDING : Routes.LOGIN : Routes.BOTTOMNAVIGATION_BAR,
      getPages: AppPages.routes,
      builder: (context, child) {
        ScreenUtil.init(context);
      final MediaQueryData = MediaQuery.of(context);
      final scale = MediaQueryData.textScaleFactor.clamp(0.8, 0.9);
      return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: scale), child: child!);
    },
    ),
  );
}
