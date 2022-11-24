class Answers {
  int? status;
  String? message;
  Data? data;

  Answers({this.status, this.message, this.data});

  Answers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data2 = <String, dynamic>{};
    data2['status'] = status;
    data2['message'] = message;
    if (data2 != null) {
      data2['data'] = data!.toJson();
    }
    return data2;
  }
}

class Data {
  String? userId;
  String? categoryId;
  String? quizTypeId;
  String? questionId;
  String? answer;
  int? ansType;
  int? marks;
  String? uniqid;

  Data(
      {this.userId,
      this.categoryId,
      this.quizTypeId,
      this.questionId,
      this.answer,
      this.ansType,
      this.marks,
      this.uniqid});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    categoryId = json['category_id'];
    quizTypeId = json['quiz_type_id'];
    questionId = json['question_id'];
    answer = json['answer'];
    ansType = json['ans_type'];
    marks = int.parse(json['marks'].toString());
    uniqid = json['uniqid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['quiz_type_id'] = quizTypeId;
    data['question_id'] = questionId;
    data['answer'] = answer;
    data['ans_type'] = ansType;
    data['marks'] = marks;
    data['uniqid'] = uniqid;
    return data;
  }
}
