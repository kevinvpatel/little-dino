class Quizquesion {
  int? status;
  String? type;
  String? message;
  List<Data>? data;

  Quizquesion({this.status, this.type, this.message, this.data});

  Quizquesion.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  List<Questions>? question;

  Data(
      {this.id,
        this.uniqid,
        this.title,
        this.categoryId,
        this.quizTypeId,
        this.category,
        this.quizType,
        this.question,
        this.image,
        this.color,
        this.vactor_color,
        this.indicator_color
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqid = json['uniqid'];
    title = json['title'];
    categoryId = json['category_id'];
    quizTypeId = json['quiz_type_id'];
    category = json['category'];
    quizType = json['quizType'];
    image = json['image'];
    color = json['color'];
    vactor_color = json['vactor_color'];
    indicator_color = json['indicator_color'];
    if (json['question'] != null) {
      question = <Questions>[];
      json['question'].forEach((v) {
        question!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uniqid'] = uniqid;
    data['title'] = title;
    data['category_id'] = categoryId;
    data['quiz_type_id'] = quizTypeId;
    data['category'] = category;
    data['quizType'] = quizType;
    data['image'] = image;
    data['color'] = color;
    data['vactor_color'] = vactor_color;
    data['indicator_color'] = indicator_color;
    if (question != null) {
      data['questions'] = question!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? id;
  String? uniqid;
  String? question;
  List? option;
  List? answer;
  String? color;
  String? vactor_color;
  String? sort_answer;
  String? image;

  Questions(
      {this.id,
        this.uniqid,
        this.question,
        this.option,
        this.answer,
        this.color,
        this.vactor_color,
        this.sort_answer,
        this.image});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqid = json['uniqid'];
    question = json['question'];
    if(json['option'] != null) {
      print('typeee -> ${json['option'].first is Map}');
      // option = <Option>[];
      // json['option'].forEach((e) => option?.add(e));
      if(json['option'].first is Map) {
        option = json['option'].cast<Map<String, dynamic>>();
        print('json[option] typeeee -> ${answer}');
      } else {
        option = json['option'].cast<String>();
      }
    }
    answer = json['answer'].cast<String>();
    color = json['color'];
    vactor_color = json['vactor_color'];
    sort_answer = json['sort_answer'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['uniqid'] = this.uniqid;
    data['question'] = this.question;
    if(option != null) {
      if(data['option'].first is Map) {
        data['option'] = option!.map((v) => v.cast<Map<String, dynamic>>()).toList();
      } else {
        data['option'] = this.option;
      }
    }
    data['answer'] = this.answer;
    data['color'] = this.color;
    data['vactor_color'] = this.vactor_color;
    data['sort_answer'] = this.sort_answer;
    data['image'] = this.image;
    return data;
  }
}

class Option {
  String? name;
  String? image;

  Option({this.name, this.image});

  Option.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}