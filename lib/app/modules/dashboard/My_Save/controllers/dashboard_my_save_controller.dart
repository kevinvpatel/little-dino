import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/mySave_model.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/saved_categories_detail_model.dart';

class DashboardMySaveController extends GetxController {
  RxInt count = 0.obs;

  int totoalSaved = 0;

  Future<MySave?> savedDatafromHive() async {
    print("Reach on MySave ----------------------->");
    MySave? mySave;
    await Hive.openBox("savedFrontCategories").then((value) async {
      final _savedCategories = Hive.box('savedFrontCategories');
      List data = [];
        print('_savedCategories.getAt(i)[name] -> ${_savedCategories.length}');
      for(int i = 0;i<_savedCategories.length;i++){
        Map<String, dynamic> mapdata = {
          "Id": "${_savedCategories.getAt(i)['Id']}",
          "uniqid":  "${_savedCategories.getAt(i)['uniqid']}",
          "name":  "${_savedCategories.getAt(i)['name']}",
          "color":  "${_savedCategories.getAt(i)['color']}",
          "vactor_color":  "${_savedCategories.getAt(i)['vactor_color']}",
          "image":  "${_savedCategories.getAt(i)['image']}",
          "totalItem": "${_savedCategories.getAt(i)['totalItem']}",
        };
        data.add(mapdata);
      }
      if(data != []){
        mySave = MySave.fromjson({'data':data});
        return mySave;
      }
    });
    return mySave;
  }

  Future<MySave?> finalsavedDataFromehive({required  mapdata}) async {
    MySave? mySave;
    // final _savedCategories = Hive.box('savedFrontCategories');
    await Hive.openBox('savedCategories').then((value) async {
      final _mybox = Hive.box("savedCategories");
      final _savedFrontCategories = Hive.box("savedFrontCategories");
      List data = [];
      for(int index = 0; index<_mybox.length; index++){
        _mybox.getAt(index)['categoryuniqId'] == mapdata['uniqid'] ? _savedFrontCategories.put(mapdata['uniqid'], mapdata) : _savedFrontCategories.delete(mapdata['uniqid']);
      }
      if(data != []){
        mySave = MySave.fromjson({'data':data});
        return mySave;
      }
    });
    return mySave;
  }


  // List<bool>? isVisibleCell;
  //
  // Future checkDetails({required String uniqId}) async {
  //   final r = await Details(uniqId: uniqId);
  //   isVisibleCell!.add(r!.data!.isEmpty ? false : true);
  //   print('r ™-> ${r.data!.length}');
  //   print('isVisibleCell.value ™-> ${isVisibleCell}');
  // }




  Future<SavedCategoriesDetailModel?> Details({required String uniqId}) async{
    SavedCategoriesDetailModel? savedCategoriesDetailModel;
    final _savedCategories = Hive.box('savedCategories');
    List data = [];
    for(int i = 0; i<_savedCategories.length; i++) {
      Map<String, dynamic> mapdata = {
        'id' : "${_savedCategories.getAt(i)['id']}",
        'uniqid' : "${_savedCategories.getAt(i)['uniqid']}",
        'categoryId' : "${_savedCategories.getAt(i)['categoryId']}",
        'categoryuniqId' : "${_savedCategories.getAt(i)['categoryuniqId']}",
        'title' : "${_savedCategories.getAt(i)['title']}",
        'name' : "${_savedCategories.getAt(i)['name']}",
        'color' : "${_savedCategories.getAt(i)['color']}",
        'image' : "${_savedCategories.getAt(i)['image']}",
        'audio_string' : "${_savedCategories.getAt(i)['audio_string']}",
        'description' : "${_savedCategories.getAt(i)['description']}",
        'vactor_color' : "${_savedCategories.getAt(i)['vactor_color']}",
        'title_color' : "${_savedCategories.getAt(i)['title_color']}",
        'example' : "${_savedCategories.getAt(i)['example']}",
        'index' : "${_savedCategories.getAt(i)['index']}",
      };
      _savedCategories.getAt(i)['categoryuniqId'] == uniqId ? data.add(mapdata):'';
    }
    if(data != []) {
      savedCategoriesDetailModel = SavedCategoriesDetailModel.fromjson({'data':data});
      print("savedCategoriesDetailModel ----------------->$savedCategoriesDetailModel");
      return savedCategoriesDetailModel;
    }
    print("savedCategoriesDetailModel 2----------------->$savedCategoriesDetailModel");
    return savedCategoriesDetailModel;
  }

  // ---------------------------- Users Login ---------------------

  // Stream<SavedCategoriesDetailModel?> savedDataFCM({required String categoriesUniquesId}){
  //   SavedCategoriesDetailModel? savedCategoriesDetailModel;
  //   return FirebaseFirestore.instance.collection('users').
  //          doc(LocalVariables.userId).collection('savedCategories').
  //          where('categoryuniqId',isEqualTo: categoriesUniquesId).
  //          snapshots().map((event) {
  //          print("Events savedDataFCM----------------->${event.docs.first.data()}");
  //          List lstdata = [];
  //          for(int i = 0;i<event.docs.length;i++){
  //            var data = event.docs[i].data();
  //            Map<String, dynamic> mapdata = {
  //              "id" : "${data['id']}",
  //              "uniqid" : "${data['uniqid']}",
  //              "categoryId" : "${data['categoryId']}",
  //              "categoryuniqId" : "${data['categoryuniqId']}",
  //              "title" : "${data['title']}",
  //              "name" : "${data['name']}",
  //              "color" : "${data['color']}",
  //              "image" : "${data['image']}",
  //              "audio_string" : "${data['audio_string']}",
  //              "description" : "${data['description']}",
  //              "vactor_color" : "${data['vactor_color']}",
  //              "title_color" : "${data['title_color']}",
  //              "example" : "${data['example']}",
  //              "index" : "${data['index']}",
  //            };
  //            lstdata.add(mapdata);
  //          }
  //          if(lstdata != '')  {
  //            savedCategoriesDetailModel = SavedCategoriesDetailModel.fromjson({'data':lstdata});
  //            return savedCategoriesDetailModel;
  //          }
  //          return savedCategoriesDetailModel;
  //       });
  // }

  Stream<SavedCategoriesDetailModel?> savedDataFCM({required String categoriesUniquesId}){
    SavedCategoriesDetailModel? savedCategoriesDetailModel;
    return FirebaseFirestore.instance.collection('users').
    doc(LocalVariables.userId).collection('savedCategories').
    where('categoryuniqId',isEqualTo: categoriesUniquesId).
    snapshots().map((event) {
      print("Events savedDataFCM <SavedCategoriesDetailModel?>----------------->${event.docs.first.data()}");
      List lstdata = [];
      for(int i = 0;i<event.docs.length;i++){
        var data = event.docs[i].data();
        Map<String, dynamic> mapdata = {
          "id" : "${data['id']}",
          "uniqid" : "${data['uniqid']}",
          "categoryId" : "${data['categoryId']}",
          "categoryuniqId" : "${data['categoryuniqId']}",
          "title" : "${data['title']}",
          "name" : "${data['name']}",
          "color" : "${data['color']}",
          "image" : "${data['image']}",
          "audio_string" : "${data['audio_string']}",
          "description" : "${data['description']}",
          "vactor_color" : "${data['vactor_color']}",
          "title_color" : "${data['title_color']}",
          "example" : "${data['example']}",
          "index" : "${data['index']}",
        };
        lstdata.add(mapdata);
        print("Events lstdata -----------> ${lstdata}");
        print(" ");
      }
      if(lstdata != [])  {
        savedCategoriesDetailModel = SavedCategoriesDetailModel.fromjson({'data':lstdata});
        return savedCategoriesDetailModel;
      }
      return savedCategoriesDetailModel;
    });
  }

  Stream<MySave?> DetailsFCM(){
    MySave? mySave;
    return FirebaseFirestore.instance.collection('users').
           doc(LocalVariables.userId).collection('savedFrontCategories').
           snapshots().map((event) {
           List lstdata = [];
           for(int i = 0;i<event.docs.length;i++){
             var data = event.docs[i].data();
             Map<String, dynamic> mapdata = {
               "Id" : "${data['Id']}",
               "uniqid" : "${data['uniqid']}",
               "name" : "${data['name']}",
               "color" : "${data['color']}",
               "vactor_color" : "${data['vactor_color']}",
               "image" : "${data['image']}",
               "totalItem" : "${data['totalItem']}",
             };
             lstdata.add(mapdata);
           }
           if(lstdata != [])  {
             mySave = MySave.fromjson({'data': lstdata});
             return mySave;
           }
           return mySave;
        });
  }


  AnalyticsController analyticsController = Get.put(AnalyticsController());


  @override
  void onInit() {
    count = 0.obs;
    super.onInit();
    analyticsController.androidButtonEvent(screenName: 'MySaveScreen_Android', screenClass: 'MySaveScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
