// To parse this JSON data, do
//
//     final latModelUser = latModelUserFromJson(jsonString);

import 'dart:convert';

LatModelUser latModelUserFromJson(String str) => LatModelUser.fromJson(json.decode(str));

String latModelUserToJson(LatModelUser data) => json.encode(data.toJson());

class LatModelUser {
  bool isSuccess;
  int value;
  String message;

  LatModelUser({
    required this.isSuccess,
    required this.value,
    required this.message,
  });

  factory LatModelUser.fromJson(Map<String, dynamic> json) => LatModelUser(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
  };
}
