import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/constants/local_veriables.dart';
import '../completescreen_model.dart';

class CompletescreenProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Completescreen.fromJson(map);
      if (map is List)
        return map.map((item) => Completescreen.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/scores';
  }

  Future<Completescreen?> getCompletescreen() async {
    Completescreen? completescreen;
    print("----------------------------");
    print("user_id ----------------------------${LocalVariables.userId}");
    print("quiz_id----------------------------${LocalVariables.selectedquiz_Id}");
    print("category_id----------------------------${LocalVariables.selectedCategory_Id}");
    try{
      final response = await http.post(
          Uri.parse('http://tubfl.com/littledino/public/api/v1/scores'),
          headers: {'auth-key':'simplerestapi'},
          body: {
            'user_id' : LocalVariables.userId,
            'quiz_id' : LocalVariables.selectedquiz_Id,
            'category_id' : LocalVariables.selectedCategory_Id
          }
      );
      print("--------------------------${response.body}");
      print("Response status --------------> ${response.statusCode}");
      if(response.statusCode == 200){
        completescreen = Completescreen.fromJson(json.decode(response.body));
        print("completescreen ------------------>$completescreen");
      }
    }catch(error){
      print("Error -------------------------->$error");
    }

    return completescreen;
  }

  Future<Response<Completescreen>> postCompletescreen(
          Completescreen completescreen) async =>
      await post('completescreen', completescreen);
  Future<Response> deleteCompletescreen(int id) async =>
      await delete('completescreen/$id');
}
