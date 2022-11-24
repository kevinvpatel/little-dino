class ScoardBoardModel {
  int? status;
  String? type;
  String? message;
  Data? data;

  ScoardBoardModel({this.status, this.type, this.message, this.data});

  ScoardBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? questions;
  int? answers;
  int? totalCategory;
  int? playCategory;
  int? totalPercentage ;

  Data({this.questions, this.answers,this.totalCategory,this.playCategory,this.totalPercentage});

  Data.fromJson(Map<String, dynamic> json) {
    questions = json['questions'];
    answers = json['answers'];
    totalCategory = json['totalCategory'];
    playCategory = json['playCategory'];
    totalPercentage = json['totalPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questions'] = this.questions;
    data['answers'] = this.answers;
    data['totalCategory'] = this.totalCategory;
    data['playCategory'] = this.playCategory;
    data['totalPercentage'] = this.totalPercentage;
    return data;
  }
}