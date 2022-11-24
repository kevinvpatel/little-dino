import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/providers/quiz_caterodies_provider.dart';
import 'package:little_dino_app/app/modules/dashboard/quizCaterogies/quiz_caterodies_model.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/scordBoardHive_Model.dart';

class DashboardQuizCaterogiesController extends GetxController {
  //TODO: Implement DashboardQuizCaterogiesController

  final count = 0.obs;

  Future<QuizCaterodies?> getdata({required String id}) async {
    var quizCaterodies = await QuizCaterodiesProvider().getQuizCaterodies(id: id);
    return quizCaterodies;
  }

  Stream<ScoarBoard?> playedquizFromFCM({required String quizUniqId}){
    print('quizUniqId## -> $quizUniqId');
    ScoarBoard? scoarBoard;
    List<Map<String,dynamic>> lstData = [];
      return FirebaseFirestore.instance.collection("users").doc(LocalVariables.userId).
                 collection('ScoarBoard').doc(quizUniqId).collection('scoars').snapshots().map((event) {
                    var data = event.docs;
                    data.forEach((element) {
                      Map<String,dynamic> mapdata = {
                        'id' : element.data()['id'],
                        'uniqid' : element.data()['uniqid'],
                        'title' : element.data()['title'],
                        'categoryId' : element.data()['categoryId'],
                        'quizTypeId' : element.data()['quizTypeId'],
                        'category' : element.data()['category'],
                        'quizType' : element.data()['quizType'],
                        'image' : element.data()['image'],
                        'color' : element.data()['color'],
                        'vactor_color' : element.data()['vactor_color'],
                        'indicator_color' : element.data()['indicator_color'],
                        'totleQuestions' : element.data()['totleQuestions'],
                        'answer' : element.data()['answer'],
                        'Time' : element.data()['Time']
                      };
                      lstData.add(mapdata);
                      print('mapdata## -> $mapdata');
                    });
                    if(lstData != []){
                      scoarBoard = ScoarBoard.fromjson({'data': lstData});
                    }
                    return scoarBoard;
                 });
  }
  
  Stream<int> unplayedquizusingFCM({required String quizCategoriesUniId,required String quizUniqId}){
    return FirebaseFirestore.instance.collection("users").doc(LocalVariables.userId).
            collection('ScoarBoard').doc(quizUniqId).collection('scoars').
            where('uniqid',isEqualTo: quizCategoriesUniId).snapshots().map((event) {
              return event.docs.length;
          });
  }



  // UnSign In Users ----------------------------------------->
  Future<ScoarBoard?> playedquizFromHive({required String quizUniqid})async{
    ScoarBoard? scoarBoard;
    List<Map<String,dynamic>> data = [];
    final _scoardBox = await Hive.box(quizUniqid);
    for(int i = 0;i < _scoardBox.length ; i++){
      print("Index is ---------------------------->${_scoardBox.getAt(i)}");
      Map<String,dynamic> mapdata = {
        'id' : _scoardBox.getAt(i)['id'],
        'uniqid' : _scoardBox.getAt(i)['uniqid'],
        'title' : _scoardBox.getAt(i)['title'],
        'categoryId' : _scoardBox.getAt(i)['categoryId'],
        'quizTypeId' : _scoardBox.getAt(i)['quizTypeId'],
        'category' : _scoardBox.getAt(i)['category'],
        'quizType' : _scoardBox.getAt(i)['quizType'],
        'image' : _scoardBox.getAt(i)['image'],
        'color' : _scoardBox.getAt(i)['color'],
        'vactor_color' : _scoardBox.getAt(i)['vactor_color'],
        'indicator_color' : _scoardBox.getAt(i)['indicator_color'],
        'Time' : _scoardBox.getAt(i)['Time'],
        'totleQuestions' : _scoardBox.getAt(i)['totleQuestions'],
        'answer' : _scoardBox.getAt(i)['answer'],
      };
      data.add(mapdata);
    }
    if(data.length != 0){
      scoarBoard = ScoarBoard.fromjson({'data' : data});
    }
    return scoarBoard;
  }

  Future<int> unplayedquizusingHive({required String quizCategoriesUniId,required String quizUniqId}) async {
    await Hive.openBox(quizUniqId);
    int length = 0;
    try{
      final _scoardBox = await Hive.box(quizUniqId);
      length = _scoardBox.get(quizCategoriesUniId) == null ? 0 : 1;
    }catch(error){
      print("The Error is -------------------->$error");
    }
    return Future.value(length);
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
