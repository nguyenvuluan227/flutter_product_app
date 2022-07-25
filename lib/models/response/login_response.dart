// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

LoginResponse loginFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.token
  });

  String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"]
      );

  Map<String, dynamic> toJson() => {
        "token": token
      };
}
