import 'dart:convert';

import 'package:get/get.dart';

import '../quizlevel_model.dart';

class QuizlevelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Quizlevel.fromJson(map);
      if (map is List)
        return map.map((item) => Quizlevel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/levels?segment=0';
  }

  Future<Quizlevel> getQuizlevel() async {
    print("Reach here getQuizlevel------------------------------->");
    Quizlevel quizlevel;
    final response = await get('http://tubfl.com/littledino/public/api/v1/levels?segment=0',headers: {'auth-key':'simplerestapi'});
    quizlevel = Quizlevel.fromJson(response.body);
    return quizlevel;
  }

  Future<Response<Quizlevel>> postQuizlevel(Quizlevel quizlevel) async =>
      await post('quizlevel', quizlevel);
  Future<Response> deleteQuizlevel(int id) async =>
      await delete('quizlevel/$id');
}
