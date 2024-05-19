// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  bool ?success;
  dynamic message;
  List<Datum> ?data;

  CountryModel({
    this.success,
    this.message,
    this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
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
  int ?id;
  String ?name;
  List<City>? cities;

  Datum({
    this.id,
    this.name,
    this.cities,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cities": List<dynamic>.from(cities!.map((x) => x.toJson())),
  };
}

class City {
  int ?id;
  String ?name;
  int ? countryId;
  List<Street> ?streets;

  City({
    this.id,
    this.name,
    this.countryId,
    this.streets,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    streets: List<Street>.from(json["streets"].map((x) => Street.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "streets": List<dynamic>.from(streets!.map((x) => x.toJson())),
  };
}

class Street {
  int? id;
  String ?name;
  int ?cityId;

  Street({
    this.id,
    this.name,
    this.cityId,
  });

  factory Street.fromJson(Map<String, dynamic> json) => Street(
    id: json["id"],
    name: json["name"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city_id": cityId,
  };
}
