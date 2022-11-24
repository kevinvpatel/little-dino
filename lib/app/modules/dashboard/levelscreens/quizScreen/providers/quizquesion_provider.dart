import 'dart:convert';
import 'package:get/get.dart';
import 'package:little_dino_app/app/constants/local_veriables.dart';
import '../quizquesion_model.dart';

class QuizquesionProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Quizquesion.fromJson(map);
      if (map is List)
        return map.map((item) => Quizquesion.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/questions?category_id=b491a0c2811a8ef7eff14e42f644f8b9&quiz_id=6f4bc2f3fce43c65a649c499dd729ec8&level_id=08c1d7870af5673db56c938a7f89f987';
  }

  Future<Quizquesion?> getQuizquesion() async {
    Quizquesion? quizquesion;
    print("LocalVariables.selectedquiz_uniqueId ------------------>${LocalVariables.quizType_uniqueId}");
    final response = await get(
                            'http://tubfl.com/littledino/public/api/v1/questions?quiz_type_id=${LocalVariables.quizType_uniqueId}',
                             headers: {'auth-key':'simplerestapi'},
                      );

    try {
        print("quizquesion response.statusCode ------------------>${response.statusCode}");
      if(response.statusCode == 200) {
        print("response.body ------------------>${response.body}");
        quizquesion = Quizquesion.fromJson(response.body);
      }
    } catch(err) {
        print("quizquesion err ------------------>${err}");
    }
    return quizquesion;
  }

  Future<Response<Quizquesion>> postQuizquesion(
          Quizquesion quizquesion) async =>
      await post('quizquesion', quizquesion);
  Future<Response> deleteQuizquesion(int id) async =>
      await delete('quizquesion/$id');
}
