
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../quiz_model.dart';

class QuizProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>)
        return Quiz.fromJson(map);
      if (map is List)
        return map.map((item) => Quiz.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/quiz/type?segment=0';
  }

  Future<Quiz?> getQuiz() async {
    Quiz? quiz;
    http.Response response = await http.get(Uri.parse('http://tubfl.com/littledino/public/api/v1/quiz/type?segment=0'),headers: {'auth-key': 'simplerestapi'});
    if (response.statusCode == 200) {
      quiz = Quiz.fromJson(json.decode(response.body));
    }
    else {
      print(response.reasonPhrase);
    }

    return quiz;
  }

  Future<Response<Quiz>> postQuiz(Quiz quiz) async => await post('quiz', quiz);
  Future<Response> deleteQuiz(int id) async => await delete('quiz/$id');

}
