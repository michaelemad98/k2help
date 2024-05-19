import 'dart:convert';
CommunityModel communitymodelFromJson(String str) => CommunityModel.fromJson(json.decode(str));

String communitymodelToJson(CommunityModel data) => json.encode(data.toJson());
class CommunityModel{
  bool ?success;
  String ? message;
  List<Datum> ?data;
  CommunityModel({
    this.success,
    this.message,
    this.data,
  });
  factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
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
  int? id;
  int ?userId;
  String? description;
  String? image;
  User ?user;
  List<Comment> ?comments;

  Datum({
    this.id,
    this.userId,
    this.description,
    this.image,
    this.user,
    this.comments,
  });
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    description: json["description"],
    image: json["image"],
    user: User.fromJson(json["user"]),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "description": description,
    "image": image,
    "user": user!.toJson(),
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}
class User{
  int ?id;
  String ?firstName;
  String ? lastName;

  User({
    this.id,
    this.firstName,
    this.lastName,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}
class Comment {
  int? id;
  int ?postId;
  String ?description;
  int ?userId;
  User? user;
  List<Replaye>? replayes;

  Comment({
    this.id,
    this.postId,
    this.description,
    this.userId,
    this.user,
    this.replayes,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    postId: json["post_id"],
    description: json["description"],
    userId: json["user_id"],
    user: User.fromJson(json["user"]),
    replayes: List<Replaye>.from(json["replayes"].map((x) => Replaye.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_id": postId,
    "description": description,
    "user_id": userId,
    "user": user!.toJson(),
    "replayes": List<dynamic>.from(replayes!.map((x) => x.toJson())),
  };
}
class Replaye {
  int ?id;
  int? commentId;
  String ?description;
  int? userId;
  User? user;

  Replaye({
    this.id,
    this.commentId,
    this.description,
    this.userId,
    this.user,
  });

  factory Replaye.fromJson(Map<String, dynamic> json) => Replaye(
    id: json["id"],
    commentId: json["comment_id"],
    description: json["description"],
    userId: json["user_id"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment_id": commentId,
    "description": description,
    "user_id": userId,
    "user": user!.toJson(),
  };
}
