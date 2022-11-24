
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:little_dino_app/app/constants/analytics_controller.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/My_Save/mySave_model.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/Provider/ScoreBoard_Provider.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/scoardBoard_Model.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/scordBoardHive_Model.dart';
class DashboardScoreBoardController extends GetxController {
  //TODO: Implement DashboardScoreBoardController

  final count = 0.obs;


  Future<MySave?> quizdata() async {
    MySave? mySave;
    print("-------------------------------------------------");
    final _quiizbox = Hive.box("QuizData");
    print("_quiizbox ------------------>${_quiizbox}");
    List data = [];
    for(int i = 0;i<_quiizbox.length;i++){
      Map<String, dynamic> mapdata = {
        "Id": "${_quiizbox.getAt(i)['Id']}",
        "uniqid":  "${_quiizbox.getAt(i)['uniqid']}",
        "name":  "${_quiizbox.getAt(i)['name']}",
        "color":  "${_quiizbox.getAt(i)['color']}",
        "vactor_color":  "${_quiizbox.getAt(i)['vactor_color']}",
        "image":  "${_quiizbox.getAt(i)['image']}",
        "totalItem": "${_quiizbox.getAt(i)['totalItem']}",
      };
      data.add(mapdata);
    }
    if(data != ''){
      mySave = await MySave.fromjson({'data':data});
      return mySave;
    }
    print("mySave --------------------->${mySave}");
    return mySave;
  }

  Future<FinalScores?> fetchScoreusingHive({required String uniqId}) async {
    ScoarBoard? scoarBoard;
    FinalScores? finalScores;
    int totalquestions = 0;
    int totalanswer = 0;
    print("uniqId ---------------->${uniqId}");
    await Hive.openBox(uniqId);
    final _box = Hive.box(uniqId);
    List<Map<String,dynamic>> lstdata = [];
    for(int i = 0 ; i < _box.length ; i++){
      Map<String,dynamic> mapdata = {
        'id' : _box.getAt(i)['id'],
        'uniqid' : _box.getAt(i)['uniqid'],
        'title' : _box.getAt(i)['title'],
        'categoryId' : _box.getAt(i)['categoryId'],
        'quizTypeId' : _box.getAt(i)['quizTypeId'],
        'category' : _box.getAt(i)['category'],
        'quizType' : _box.getAt(i)['quizType'],
        'image' : _box.getAt(i)['image'],
        'color' : _box.getAt(i)['color'],
        'Time' : _box.getAt(i)['Time'],
        'totleQuestions' : _box.getAt(i)['totleQuestions'],
        'answer' : _box.getAt(i)['answer'],
      };
      print("mapdata ------------->${mapdata}");
      lstdata.add(mapdata);
    }
    if(lstdata != ''){
      scoarBoard = await ScoarBoard.fromjson({'data':lstdata});
    }

    if(scoarBoard != null){
      print("scoarBoard.data! -------------------->${scoarBoard.data!.length}");
      var data = scoarBoard.data!;

      for(int i = 0 ; i < data.length ; i++){
        totalquestions = totalquestions + data[i].totleQuestions!.toInt();
        totalanswer = totalanswer + data[i].answer!.toInt();
      }

      int percentage = (totalanswer/totalquestions * 100).ceil();

      Map<String,dynamic> mapdata = {
        'totalCategory' : lstdata.length.toInt(),
        'playCategory' :  data.length.toInt(),
        'totalPercentage' :  percentage,
        'questions' : totalquestions.toInt(),
        'answers' : totalanswer.toInt(),
      };

      finalScores = await FinalScores.fromJson(mapdata);
      return finalScores;
    }
    return finalScores;
  }

  Stream<MySave?>  scoardDataFromFCM(){
    print("LocalVariables.userId -------------->${LocalVariables.userId}");
    return FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).
                collection('ScoarBoard').snapshots().map((event) {

      MySave? mySave;
      List data = [];
      var datas  = event.docs;
      for(int i = 0;i<datas.length;i++){
        print("event datas[i]------------>${datas[i]}");
        Map<String, dynamic> mapdata = {
          "Id": "${datas[i]['Id']}",
          "uniqid":  "${datas[i]['uniqid']}",
          "name":  "${datas[i]['name']}",
          "color":  "${datas[i]['color']}",
          "vactor_color":  "${datas[i]['vactor_color']}",
          "image":  "${datas[i]['image']}",
          "totalItem": "${datas[i]['totalItem']}",
        };
        data.add(mapdata);
      }
      if(data != ''){
        mySave =  MySave.fromjson({'data':data});
        return mySave;
      }
      return mySave;
    });
  }
  
  Stream<FinalScores?> fetchScoreusingFCM({required quizId,required totalItem}){
    FinalScores? finalScores;
    int answers = 0;
    int questions = 0;
    return FirebaseFirestore.instance.collection('users').doc(LocalVariables.userId).
            collection('ScoarBoard').doc('$quizId').collection('scoars').snapshots().map((event) {
            var datas = event.docs;
              datas.forEach((element) {
                print("element.data() ----------->${element.data()}");
                answers = answers + int.parse(element.data()['answer'].toString());
                questions = questions + int.parse(element.data()['totleQuestions'].toString());
              });
            print("answers ----------->${answers}");
            print("questions ----------->${questions}");
            print("datas.length ----------->${datas.length}");
              Map<String,dynamic> mapdata = {
                'questions':questions,
                'answers':answers,
                'totalCategory':int.parse(totalItem.toString()),
                // 'playCategory':datas.length,
                'playCategory':answers,
                'totalPercentage':((answers/questions)*100).ceil(),
               };
              finalScores = FinalScores.fromJson(mapdata);

            return finalScores;
    });
  }


  AnalyticsController analyticsController = Get.put(AnalyticsController());


  @override
  void onInit() {
    super.onInit();
    analyticsController.androidButtonEvent(screenName: 'ScoreBoardScreen_Android', screenClass: 'ScoreBoardScreenActivity');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
