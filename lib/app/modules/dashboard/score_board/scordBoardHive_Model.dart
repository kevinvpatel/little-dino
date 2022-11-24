class ScoarBoard{
  List<Data>? data;
  ScoarBoard({this.data});
  ScoarBoard.fromjson(Map<String,dynamic> json){
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
  Map<String,dynamic> tojson(){
    final data2 = <String, dynamic>{};
    if (data2 != null) {
      data2['data'] = data!.map((v) => v.toJson()).toList();
    }
    return data2;
  }
}

class Data{
  String? id;
  String? uniqid;
  String? title;
  String? categoryId;
  String? quizTypeId;
  String? category;
  String? quizType;
  String? image;
  String? color;
  String? vactor_color;
  String? indicator_color;
  String? time;
  int? totleQuestions;
  int? answer;

  Data({this.id,this.uniqid,this.title,this.categoryId,this.quizTypeId,this.category,this.quizType,this.image,this.color,this.totleQuestions,this.answer,this.time,this.vactor_color,this.indicator_color});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqid = json['uniqid'];
    title = json['title'];
    categoryId = json['categoryId'];
    quizTypeId = json['quizTypeId'];
    category = json['category'];
    quizType = json['quizType'];
    image = json['image'];
    color = json['color'];
    vactor_color = json['vactor_color'];
    totleQuestions = json['totleQuestions'];
    indicator_color = json['indicator_color'];
    answer = json['answer'];
    time = json['Time'];
  }

  Map<String,dynamic> toJson() {
    final Map<String,dynamic> data = new  Map<String,dynamic>();
    data['id'] = id;
    data['uniqid'] = uniqid;
    data['title'] = title;
    data['categoryId'] = categoryId;
    data['quizTypeId'] = quizTypeId;
    data['category'] = category;
    data['quizType'] = quizType;
    data['image'] = image;
    data['vactor_color'] = vactor_color;
    data['totleQuestions'] = totleQuestions;
    data['indicator_color'] = indicator_color;
    data['answer'] = answer;
    data['Time'] = time;
    return data;
  }
}

class FinalScores {
  int? questions;
  int? answers;
  int? totalCategory;
  int? playCategory;
  int? totalPercentage ;

  FinalScores({this.questions, this.answers,this.totalCategory,this.playCategory,this.totalPercentage});

  FinalScores.fromJson(Map<String, dynamic> json) {
    // print("json ------------------>$json");
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