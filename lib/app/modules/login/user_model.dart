class UserModel {
  String? id;
  String? uniqid;
  String? role;
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? gender;
  String? profile;

  UserModel(
      {this.id,
        this.uniqid,
        this.role,
        this.firstName,
        this.lastName,
        this.email,
        this.dob,
        this.gender,
        this.profile});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqid = json['uniqid'];
    role = json['role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uniqid'] = uniqid;
    data['role'] = role;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['dob'] = dob;
    data['gender'] = gender;
    data['profile'] = profile;
    return data;
  }
}