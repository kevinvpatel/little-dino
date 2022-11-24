import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../quiz_caterodies_model.dart';

class QuizCaterodiesProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return QuizCaterodies.fromJson(map);
      if (map is List) {
        return map.map((item) => QuizCaterodies.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/quiz/category?quiz_id=d11553eee9e46659b81c04da802a397b';
  }

  Future<QuizCaterodies?> getQuizCaterodies({required String id}) async {
    print("REach on getQuizCaterodies ---------------->");
    QuizCaterodies? quizCaterodies;
    final response = await get('http://tubfl.com/littledino/public/api/v1/quiz/category?quiz_id=$id',headers: {'auth-key':'simplerestapi'});

    if(response.statusCode == 200){
      quizCaterodies = QuizCaterodies.fromJson(response.body);
      Hive.openBox('quizCztegories').then((value) {
        value.put('datas', response.body['data']);
      });
    }
    return quizCaterodies;
  }

  Future<Response<QuizCaterodies>> postQuizCaterodies(
          QuizCaterodies quizcaterodies) async =>
      await post('quizcaterodies', quizcaterodies);
  Future<Response> deleteQuizCaterodies(int id) async =>
      await delete('quizcaterodies/$id');
}
