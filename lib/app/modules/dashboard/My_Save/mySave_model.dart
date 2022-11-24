class MySave{
  List<Data>? data;
  MySave({this.data});
  MySave.fromjson(Map<String,dynamic> json){
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
  String? Id;
  String? uniqid;
  String? name;
  String? color;
  String? vactor_color;
  String? image;
  String? totalItem;

  Data({this.Id, this.uniqid, this.name, this.color, this.image,this.vactor_color,this.totalItem});

  Data.fromJson(Map<String, dynamic> json) {
    Id = "${json['Id']}";
    uniqid = "${json['uniqid']}";
    name = "${json['name']}";
    color = "${json['color']}";
    image = "${json['image']}";
    vactor_color = "${json['vactor_color']}";
    totalItem = "${json['totalItem']}";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Id'] = Id;
    data['uniqid'] = uniqid;
    data['name'] = name;
    data['color'] = color;
    data['image'] = image;
    data['vactor_color'] = vactor_color;
    data['totalItem'] = totalItem;
    return data;
  }
}