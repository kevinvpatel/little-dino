class RegisterModel{
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String confirm_password;

  RegisterModel({required this.first_name,required this.last_name,required this.email,required this.confirm_password,required this.password});

  factory RegisterModel.fromjson(Map<String,dynamic> json) => RegisterModel(
      first_name : json['first_name'],
      last_name : json['last_name'],
      email : json['email'],
      password : json['password'],
      confirm_password : json['confirm_password'],
  );

  Map<String,dynamic> tojson() {
      final Map<String,dynamic> data = new Map<String,dynamic>();
      data['first_name'] = this.first_name;
      data['last_name'] = this.last_name;
      data['email'] = this.email;
      data['password'] = this.password;
      data['confirm_password'] = this.confirm_password;
      return data;
  }
}