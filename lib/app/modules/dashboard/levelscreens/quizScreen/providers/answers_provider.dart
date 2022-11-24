import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/constants/local_veriables.dart';
import '../answers_model.dart';

class AnswersProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Answers.fromJson(map);
      if (map is List)
        return map.map((item) => Answers.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/add/answer';
  }
  // Answers
  Future getAnswers({required List lstanswer}) async {

    ///if marks 0 then answer wrong otherwise right
    print("lstans ------------------------>${lstanswer}");

    var headers = {
      'auth-key': 'simplerestapi',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://tubfl.com/littledino/public/api/v1/add/answer'));
    request.fields.addAll({
      'user_id':LocalVariables.userId,
      'quiz_type_id':LocalVariables.quizType_uniqueId,
      'quiz_id':LocalVariables.selectedquiz_uniqId,
      'question_id' : LocalVariables.question_uniqId,
    });
    print(" ");
    print("user_id ------------->${LocalVariables.userId}");
    print("quiz_type_id ------------->${LocalVariables.quizType_uniqueId}");
    print("quiz_id ------------->${LocalVariables.selectedquiz_uniqId}");
    print("question_id ------------->${LocalVariables.question_uniqId}");

    print("Answer4 length ------------->${lstanswer}");
    List.generate(lstanswer.length, (index) {
      request.fields.addAll({'answer[$index]':lstanswer[index]});
    });
    request.headers.addAll(headers);

    print("Request Fields -------------->${request.fields}");
    http.StreamedResponse response = await request.send();
    final result = String.fromCharCodes(await response.stream.toBytes());
    Map<String,dynamic> finalresult = json.decode(result);
    print("response.statusCode -----------------> ${response.statusCode}");

    if (response.statusCode == 200) {
      Answers? answer = Answers.fromJson(finalresult);
      print("answer.data!.marks ------------------> ${answer.data!.marks}");
      return answer.data!.marks;
    }
    else {
      print(response.reasonPhrase);
      return 0;
    }
  }

  Future<Response<Answers>> postAnswers(Answers answers) async =>
      await post('answers', answers);
  Future<Response> deleteAnswers(int id) async => await delete('answers/$id');
}
