// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool ?success;
  dynamic message;
  Data ?data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  int? id;
  String? firstName;
  String ?lastName;
  String? email;
  String? username;
  String? phone;
  String ?deviceToken;
  String ?emailVerifiedAt;
  String ?createdAt;
  String? updatedAt;
  String ?token;
  String ?picture;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
    this.deviceToken,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.picture,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    username: json["username"],
    phone: json["phone"],
    deviceToken: json["device_token"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    token: json["token"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "username": username,
    "phone": phone,
    "device_token": deviceToken,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "token": token,
    "picture": picture,
  };
}
