// To parse this JSON data, do
//
//     final checkCollaboratorResponse = checkCollaboratorResponseFromJson(jsonString);

import 'dart:convert';

class CheckCollaboratorResponse {
  CheckCollaboratorResponse({
    this.type,
  });

  final String? type;

  factory CheckCollaboratorResponse.fromRawJson(String str) =>
      CheckCollaboratorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckCollaboratorResponse.fromJson(Map<String, dynamic> json) =>
      CheckCollaboratorResponse(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
