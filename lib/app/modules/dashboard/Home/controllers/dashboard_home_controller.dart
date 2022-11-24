import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/providers/category_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/providers/quiz_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/quiz_model.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/category_model.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/mySave_model.dart';


class DashboardHomeController extends GetxController  {
  final count = 0.obs;
  RxList categoriesSave = [].obs;
  RxList quizSave = [].obs;
  RxList lsttitle = [].obs;
  RxList savedRecents = [].obs;
  var ans = 0.obs;

  AnalyticsController analyticsController = Get.put(AnalyticsController());

  @override
  void onInit() async {
    super.onInit();
    Firebase.initializeApp();
    ///In App Messaging
    FirebaseInAppMessaging.instance.triggerEvent("");
    if(Platform.isAndroid) {
      FirebaseMessaging.instance.sendMessage();
    }
    FirebaseMessaging.instance.getInitialMessage();
    // analyticsController.screenTrack(screenName: 'Home_Screen', screenClass: 'HomeScreenActivity');
    analyticsController.androidButtonEvent(screenName: 'HomeScreen_Android', screenClass: 'HomeScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  getdataFromFCV({required String title, required String uniqId, required int index}) async {
    if(LocalVariables.lastname != "Users") {
      try{
        FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).
        collection('$title').where('uniqid',isEqualTo: uniqId).
        snapshots().listen((event) {
          if(title == 'Category') {
            event.docs.length == 1 ? categoriesSave[index] = true : '';
          }
          else if(title == 'Quiz') {
            event.docs.length == 1 ? quizSave[index] = true : '';
          }
          else{
            print("Something was wrong");
          }
        });
      }catch(error) {
        print("Error is ------------->$error");
      }
    }
    else {
      print("Reach on Stream Methd ---------------------> ");
    }
  }


  Future<Category?> catagorydetails() async {
    final categoriesdetail = Hive.box('CategoriesDetails');
    Category? category;
      try{
        var status = 200;
        var type = "success";
        var message = "Category data fatch Successfully";
        List lstdata = [];
        for(int index = 0; index < categoriesdetail.length; index++){
          Map<String,dynamic> mapdata = {
            'id' : categoriesdetail.getAt(index)['id'],
            'uniqid' : categoriesdetail.getAt(index)['uniqid'],
            'name' : categoriesdetail.getAt(index)['name'],
            'color' : categoriesdetail.getAt(index)['color'],
            'vactor_color' : categoriesdetail.getAt(index)['vactor_color'],
            'image' : categoriesdetail.getAt(index)['image'],
            'totalItem' : categoriesdetail.getAt(index)['totalItem'],
          };
          lstdata.add(mapdata);
        }
        if(lstdata != []){
          Map<String,dynamic> mapdata = {
            "status" : status,
            "type" : type,
            "message" : message,
            "data" : lstdata,
          };
          category = Category.fromJson(mapdata);
        }
      }catch(error){
        print("Error ------------------------>$error");
      }
    return category;
  }

  Future loaddata() async {
    LocalVariables.Categoriesdata = [];
    LocalVariables.QuizData = [];
    final _categories = Hive.box('CategoriesDetails');
    final _quiz = Hive.box('QuizDetails');
   await CategoryProvider().getCategory().then((value) {
      value!.data!.forEach((element) {
        try {
          Map<String,dynamic> mapdata = {
              'id' : element.id,
              'uniqid' : element.uniqid,
              'name' : element.name,
              'color' : element.color,
              'vactor_color' : element.vactor_color,
              'image' : element.image,
              'totalItem' : element.totalItem
          };
          LocalVariables.Categoriesdata.add({element.uniqid! : mapdata});
          _categories.put(element.uniqid, mapdata);
        } catch(error) {
          print("Error ------------------->$error");
        }
      });
    });
   await QuizProvider().getQuiz().then((value) {
     value!.data!.forEach((element) {
       Map<String,dynamic> mapdata = {
         'id':element.id,
         'uniqid':element.uniqid,
         'name':element.name,
         'color':element.color,
         'vactor_color':element.vactor_color,
         'image':element.image,
         'total' : element.total
       };
       LocalVariables.QuizData.add({element.uniqid! : mapdata});
       _quiz.put(element.uniqid, mapdata);
     });
   });
  // await AllDetailsProvider().alldetailsofcategories().then((value) {
  //   value!.data!.forEach((element) {
  //      LocalVariables.learningData.add({element.uniqid! : element});
  //      Map<String,dynamic> mapdata = {
  //        'id':element.id,
  //        'uniqid':element.uniqid,
  //        'categoryId':element.categoryId,
  //        'title':element.title,
  //        'name':element.name,
  //        'color':element.color,
  //        'image':element.image,
  //        'audio_string':element.audio_string,
  //        'description':element.description,
  //        'vactor_color':element.vactor_color,
  //        'example':element.example,
  //      };
  //     _learning.put(element.uniqid, mapdata);
  //   });
  // });
  }

  Stream<List<MySave>> recentData(){

      MySave? recent;
      return FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent').snapshots().map((event) {
        List lstmySave = event.docs.map((doc) => doc.data()).toList();

        if(lstmySave != null) {
          try{
            recent = MySave.fromjson({'data':lstmySave});
            savedRecents.value = List.generate(lstmySave.length, (index) => false).obs;
          }
          catch(error){
            print("Error --------------->$error");
          }
        }
        List<MySave> lstdatas = [recent!];
        return lstdatas;
      });
    }

  Future<Quiz?> quizdeatils() async {
      Quiz? quiz;
      final quizBox = Hive.box('QuizDetails');

        try {
          var status = 200;
          var type = "success";
          var message = "Category data fatch Successfully";
          List lstdata = [];
          for (int index = 0; index < quizBox.length; index++) {
            Map<String,dynamic> mapdata = {
              'id' : quizBox.getAt(index)['id'],
              'uniqid' : quizBox.getAt(index)['uniqid'],
              'name' : quizBox.getAt(index)['name'],
              'color' : quizBox.getAt(index)['color'],
              'vactor_color' : quizBox.getAt(index)['vactor_color'],
              'image' : quizBox.getAt(index)['image'],
              'total' : quizBox.getAt(index)['total'],
            };
            lstdata.add(mapdata);
          }
          if (lstdata != []) {
            Map<String, dynamic> mapdata = {
              "status": status,
              "type": type,
              "message": message,
              "data": lstdata,
            };
            quiz = Quiz.fromJson(mapdata);
          }
        } catch (Error) {
          print("Error ------------------------>$Error");
        }
      return quiz;
  }

  Stream<bool> isSaved({required String uniquId,required int index}){
    return FirebaseFirestore.instance.collection('users').
            doc(LocalVariables.userId).collection('Category').
            where("uniqid",isEqualTo: uniquId).snapshots().map((event) {
              savedRecents[index] = event.docs.length == 1?true:false;
              return true;
            });
    }


  Future<MySave?> recentDataFromHive() async  {
    // print("Reach on recentDataFromHive ******************************* ");
    MySave? mySave;
    final _recentBox = Hive.box("Recent");
    List data = [];
    for(int i = 0;i<_recentBox.length;i++){
      Map<String, dynamic> mapdata = {
        "Id": "${_recentBox.getAt(i)['Id']}",
        "uniqid":  "${_recentBox.getAt(i)['uniqid']}",
        "name":  "${_recentBox.getAt(i)['name']}",
        "color":  "${_recentBox.getAt(i)['color']}",
        "vactor_color":  "${_recentBox.getAt(i)['vactor_color']}",
        "image":  "${_recentBox.getAt(i)['image']}",
        "totalItem": "${_recentBox.getAt(i)['totalItem']}",
      };
     data.add(mapdata);
    }
    if(data != ''){
      mySave = await MySave.fromjson({'data':data});
      return mySave;
    }
    return mySave;
  }


  // <---------------------------- For Home page --------------------->


  Future<MySave?> recentDataFromHiveForHomePage() async  {
    MySave? mySave;
    final _recentBox = Hive.box("Recent");
    List data = [];
    for(int i = 0;i < _recentBox.length;i++){
      Map<String, dynamic> mapdata = {
        "Id": "${_recentBox.getAt(i)['Id']}",
        "uniqid":  "${_recentBox.getAt(i)['uniqid']}",
        "name":  "${_recentBox.getAt(i)['name']}",
        "color":  "${_recentBox.getAt(i)['color']}",
        "vactor_color":  "${_recentBox.getAt(i)['vactor_color']}",
        "image":  "${_recentBox.getAt(i)['image']}",
        "totalItem": "${_recentBox.getAt(i)['totalItem']}",
      };
      data.length < 10 ? data.add(mapdata) : '';
    }

    if(data != ''){
      mySave = await MySave.fromjson({'data':data});
      return mySave;
    }
    return mySave;
  }

  Stream<MySave?> recentDataFromFCmFormHomePage(){
    MySave? recent;
    return FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).collection('Recent').snapshots().map((event) {
      int index = 0;
      List lstmySave = [];
      for(int i = 0 ; i < event.docs.length ; i++){
        lstmySave.length < 10 ?lstmySave.add(event.docs[i].data()):'';
      }
      if(lstmySave != null){
        try{
          recent =  MySave.fromjson({'data':lstmySave});
          savedRecents.value = List.generate(lstmySave.length, (index) => false).obs;
        }
        catch(error){
          print("Error --------------->$error");
        }
      }
      return recent;
    });
  }

  Future<Category?> catagorydetailsForHomePage() async {
    final categoriesdetail = Hive.box('CategoriesDetails');
    Category? category;
    try{
      var status = 200;
      var type = "success";
      var message = "Category data fatch Successfully";
      List lstdata = [];
      for(int index = 0; index < categoriesdetail.length ; index++){
        Map<String, dynamic> mapdata = {
          "id": "${categoriesdetail.getAt(index)['id']}",
          "uniqid":  "${categoriesdetail.getAt(index)['uniqid']}",
          "name":  "${categoriesdetail.getAt(index)['name']}",
          "color":  "${categoriesdetail.getAt(index)['color']}",
          "vactor_color":  "${categoriesdetail.getAt(index)['vactor_color']}",
          "image":  "${categoriesdetail.getAt(index)['image']}",
          "totalItem": categoriesdetail.getAt(index)['totalItem'],
        };
        lstdata.length < 10 ? lstdata.add(mapdata) : '';
      }
      if(lstdata != []){
        Map<String,dynamic> mapdata = {
          "status" : status,
          "type" : type,
          "message" : message,
          "data" : lstdata,
        };
        category = Category.fromJson(mapdata);
      }
    }catch(error){
      print("Error ------------------------>$error");
    }
    return category;
  }

  Future<Quiz?> quizdeatilsForHomePage() async {
    Quiz? quiz;
    final quizBox = Hive.box('QuizDetails');

    try {
      var status = 200;
      var type = "success";
      var message = "Category data fatch Successfully";
      List lstdata = [];
      for (int index = 0; index < quizBox.length; index++) {
        Map<String, dynamic> mapdata = {
          "id": "${quizBox.getAt(index)['id']}",
          "uniqid":  "${quizBox.getAt(index)['uniqid']}",
          "name":  "${quizBox.getAt(index)['name']}",
          "color":  "${quizBox.getAt(index)['color']}",
          "vactor_color":  "${quizBox.getAt(index)['vactor_color']}",
          "image":  "${quizBox.getAt(index)['image']}",
          "total": quizBox.getAt(index)['total'],
        };
        lstdata.length < 10 ? lstdata.add(mapdata):'';
      }
      if (lstdata != []) {
        Map<String, dynamic> mapdata = {
          "status": status,
          "type": type,
          "message": message,
          "data": lstdata,
        };
        quiz = Quiz.fromJson(mapdata);
      }
    } catch (Error) {
      print("Error ------------------------>$Error");
    }
    return quiz;
  }

  @override
  void onClose() {
  }
  void increment() => count.value++;
}
