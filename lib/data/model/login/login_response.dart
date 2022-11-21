// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.idToken,
  });

  final String idToken;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        idToken: json["id_token"],
      );

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
      };
}
