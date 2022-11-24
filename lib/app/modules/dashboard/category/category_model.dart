class Category {
  int? status;
  String? type;
  String? message;
  List<Data>? data;

  Category({this.status, this.type, this.message, this.data});

  Category.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? color;
  String? image;

  Data({this.id, this.uniqid, this.name, this.color, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqid = json['uniqid'];
    name = json['name'];
    color = json['color'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['uniqid'] = uniqid;
    data['name'] = name;
    data['color'] = color;
    data['image'] = image;
    return data;
  }
}
