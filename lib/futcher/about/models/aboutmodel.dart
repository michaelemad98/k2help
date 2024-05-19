// To parse this JSON data, do
//
//     final getAboutDescriptionModel = getAboutDescriptionModelFromJson(jsonString);

import 'dart:convert';

GetAboutDescriptionModel getAboutDescriptionModelFromJson(String str) => GetAboutDescriptionModel.fromJson(json.decode(str));

String getAboutDescriptionModelToJson(GetAboutDescriptionModel data) => json.encode(data.toJson());

class GetAboutDescriptionModel {
  bool ? success;
  String? message;
  Data? data;

  GetAboutDescriptionModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetAboutDescriptionModel.fromJson(Map<String, dynamic> json) => GetAboutDescriptionModel(
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
  String? about;
  String ? introImage;

  Data({
    this.about,
    this.introImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    about: json["about"],
    introImage: json["intro_image"],
  );

  Map<String, dynamic> toJson() => {
    "about": about,
    "intro_image": introImage,
  };
}
