// To parse this JSON data, do
//
//     final getFaqModel = getFaqModelFromJson(jsonString);

import 'dart:convert';

GetFaqModel getFaqModelFromJson(String str) => GetFaqModel.fromJson(json.decode(str));

String getFaqModelToJson(GetFaqModel data) => json.encode(data.toJson());

class GetFaqModel {
  bool ?success;
  dynamic message;
  List<Datum>? data;

  GetFaqModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetFaqModel.fromJson(Map<String, dynamic> json) => GetFaqModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String ?question;
  String ?answer;

  Datum({
    this.question,
    this.answer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}
