class ManageSavedata{
  List<Data>? data;
  ManageSavedata({this.data});
  ManageSavedata.fromjson(Map<String,dynamic> json){
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

class Data {
  String? id;
  String? uniqid;
  String? categoryId;
  String? categoryuniqId;
  String? title;
  String? name;
  String? color;
  String? image;
  String? audio_string;
  String? description;
  String? vactor_color;
  String? example;

  Data({this.id,
    this.uniqid,
    this.categoryId,
    this.categoryuniqId,
    this.title,
    this.name,
    this.color,
    this.image,
    this.audio_string,
    this.description,
    this.vactor_color,
    this.example});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqid = json['uniqid'];
    categoryId = json['category_id'];
    categoryId = json['categoryuniqId'];
    title = json['title'];
    name = json['name'];
    color = json['color'];
    image = json['image'];
    audio_string = json['audio'];
    description = json['description'];
    vactor_color = json['vactor_color'];
    example = json['example'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['uniqid'] = uniqid;
    data['category_id'] = categoryId;
    data['category_id'] = categoryuniqId;
    data['title'] = title;
    data['name'] = name;
    data['color'] = color;
    data['image'] = image;
    data['audio'] = audio_string;
    data['description'] = description;
    data['vactor_color'] = vactor_color;
    data['example'] = example;
    return data;
  }
}