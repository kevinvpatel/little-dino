import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/dashboard/score_board/scoardBoard_Model.dart';
class ScorboardProvider{
   Future<ScoardBoardModel?> getData({required quizId}) async {
     ScoardBoardModel? scoardBoardModel;
     try{
       http.Response response = await http.post(
           Uri.parse("http://tubfl.com/littledino/public/api/v1/scores"),
           headers: {'auth-key':'simplerestapi'},
           body:{
             'user_id' : LocalVariables.userId,
             'quiz_type_id' : quizId
           }
       );
       if(response.statusCode == 200){
         scoardBoardModel = ScoardBoardModel.fromJson(json.decode(response.body));
       }
     }catch(Error){
       print("Error -------------------------- > $Error");
     }
     return scoardBoardModel;
   }
}