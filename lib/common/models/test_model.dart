// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:example_architecture/core/base/base_model.dart';

class Welcome extends BaseModel<Welcome> {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Welcome({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  @override
  fromJson(Map<String, dynamic> json) => Welcome(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
