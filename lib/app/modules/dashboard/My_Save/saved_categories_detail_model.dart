class SavedCategoriesDetailModel{
  List<Data>? data;
  SavedCategoriesDetailModel({this.data});
  SavedCategoriesDetailModel.fromjson(Map<String,dynamic> json){
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
  String? title_color;
  String? example;
  String? index;

  Data({
    this.id,
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
    this.title_color,
    this.example,
    this.index,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = "${json['id']}";
    uniqid = "${json['uniqid']}";
    categoryId = "${json['categoryId']}";
    categoryuniqId = "${json['categoryuniqId']}";
    title = "${json['title']}";
    name = "${json['name']}";
    color = "${json['color']}";
    image = "${json['image']}";
    audio_string = "${json['audio_string']}";
    description = "${json['description']}";
    vactor_color = "${json['vactor_color']}";
    title_color = "${json['title_color']}";
    example = "${json['example']}";
    index = "${json['index']}";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

     data['id'] = id;
     data['uniqid'] = uniqid;
     data['categoryId'] = categoryId;
     data['categoryuniqId'] = categoryuniqId;
     data['title'] = title;
     data['name'] = name;
     data['color'] = color;
     data['image'] = image;
     data['audio_string'] = audio_string;
     data['description'] = description;
     data['vactor_color'] = vactor_color;
     data['title_color'] = title_color;
     data['example'] = example;
     data['index'] = index;
    return data;
  }
}