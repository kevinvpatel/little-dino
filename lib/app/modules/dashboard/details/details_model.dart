class Details {
  int? status;
  String? type;
  String? message;
  List<Data>? data;

  Details({this.status, this.type, this.message, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data2 = <String, dynamic>{};
    data2['status'] = status;
    data2['type'] = type;
    data2['message'] = message;
    if (data != null) {
      data2['data'] = data?.map((v) => v.toJson()).toList();
    }
    return data2;
  }
}

class Data {
  String? id;
  String? uniqid;
  String? categoryId;
  String? title;
  String? name;
  String? color;
  String? image;
  String? audio_string;
  String? description;
  String? vactor_color;
  String? title_color;
  String? example;

  Data(
      {this.id,
      this.uniqid,
      this.categoryId,
      this.title,
      this.name,
      this.color,
      this.image,
      this.audio_string,
      this.description,
      this.vactor_color,
      this.title_color,
      this.example
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqid = json['uniqid'];
    categoryId = json['category_id'];
    title = json['title'];
    name = json['name'];
    color = json['color'];
    image = json['image'];
    audio_string = json['audio'];
    description = json['description'];
    vactor_color = json['vactor_color'];
    title_color = json['title_color'];
    example = json['example'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['uniqid'] = uniqid;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['name'] = name;
    data['color'] = color;
    data['image'] = image;
    data['audio'] = audio_string;
    data['description'] = description;
    data['vactor_color'] = vactor_color;
    data['title_color'] = title_color;
    data['example'] = example;
    return data;
  }
}
