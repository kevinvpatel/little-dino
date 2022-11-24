class Completescreen {
  int? status;
  String? type;
  String? message;
  Data? data;

  Completescreen({this.status, this.type, this.message, this.data});

  Completescreen.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final data2 = <String, dynamic>{};
    data2['status'] = status;
    data2['type'] = type;
    data2['message'] = message;
    if (data2 != null) {
      data2['data'] = data!.toJson();
    }
    return data2;
  }
}

class Data {
  int? questions;
  int? answers;

  Data({this.questions, this.answers});

  Data.fromJson(Map<String, dynamic> json) {
    questions = json['questions'];
    answers = json['answers'];

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['questions'] = questions;
    data['answers'] = answers;
    return data;
  }
}
