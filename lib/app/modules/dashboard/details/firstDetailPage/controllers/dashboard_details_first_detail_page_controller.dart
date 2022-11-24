import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/details/alphabets/controllers/dashboard_details_alphabets_controller.dart';
import 'package:little_dino_app/app/modules/dashboard/details/initializeCategiresCard.dart';

class DashboardDetailsFirstDetailPageController extends GetxController {
  //TODO: Implement DashboardDetailsFirstDetailPageController

  final count = 0.obs;
  RxInt index = 0.obs;
  RxBool issetctedOrNot = false.obs;

  Stream<InitializeCategiresCard?> fetchDataOfTillCardSwip(){
    InitializeCategiresCard? initializeCategiresCard;
    return FirebaseFirestore.instance.collection('users')
            .doc(LocalVariables.userId).collection('TillCardSwip').
            where('categoryuniqId',isEqualTo: LocalVariables.selectedCategory_uniqueId).snapshots().map((event) {
              var details = event.docs[0].data();
              Map<String,dynamic> mapdata= {
                'id': "${details['id']}",
                'uniqid': "${details['uniqid']}",
                'categoryId': "${details['categoryId']}",
                'categoryuniqId': "${details['categoryuniqId']}",
                'title': "${details['title']}",
                'name': "${details['name']}",
                'color': "${details['color']}",
                'image': "${details['image']}",
                'audio_string': "${details['audio_string']}",
                'description': "${details['description']}",
                'vactor_color': "${details['vactor_color']}",
                'title_color': "${details['title_color']}",
                'example': "${details['example']}",
                'index': int.parse("${details['index']}"),
              };
              initializeCategiresCard = InitializeCategiresCard.fromJson(mapdata);
              Hive.openBox("StorSavedDetailsFromFCM").then((value) {
                    final _mybox = Hive.box("StorSavedDetailsFromFCM");
                    var data = _mybox.get(details['uniqid']);
                    issetctedOrNot.value = data != null ? true : false ;
              });
            return initializeCategiresCard;
      });
  }
  // {color: #ffe8be, name: B, index: 3, uniqId: 4312e23428ed88bd104ceaf63170711f, Id: 4, title: Bird}

  Future<InitializeCategiresCard?> fetchData() async{
    InitializeCategiresCard? initializeCategiresCard;
    final _initializeCategiresCard = Hive.box('initializeCategiresCard');
    var data = _initializeCategiresCard.get(LocalVariables.selectedCategory_uniqueId);
    if(data != null){
      try{
        LocalVariables.initalizeCard = int.parse(data['index']);
        Map<String,dynamic> mapdata ={
          'id' : data['id'],
          'uniqid' :data['uniqid'],
          'categoryId' :data['categoryId'],
          'categoryuniqId' :data['categoryuniqId'],
          'title' :data['title'],
          'name' :data['name'],
          'color' :data['color'],
          'image' :data['image'],
          'audio_string' :data['audio_string'],
          'description' :data['description'],
          'vactor_color' :data['vactor_color'],
          'title_color' :data['title_color'],
          'example' :data['example'],
          'index' : int.parse(data['index'].toString()),
         };
        initializeCategiresCard = await InitializeCategiresCard.fromJson(mapdata);
        return initializeCategiresCard;
      }catch(error){
        print("Error of First Detail Screen --------------------->$error");
      }
      return initializeCategiresCard;
    }
    else{
      LocalVariables.initalizeCard = 0;
    }
    return initializeCategiresCard;
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
  void onClose() {}
  void increment() => count.value++;
}
