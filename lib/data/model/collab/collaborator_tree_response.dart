import 'dart:convert';

class CollaboratorTreeResponse {
  CollaboratorTreeResponse({
    this.referralCode,
    this.referralName,
    this.username,
    this.fullname,
    this.type,
    this.quantityF1,
    this.quantityF2,
    this.hierarchicalTreeF1Rp,
    this.hierarchicalTreeF2Rp,
  });

  final String? referralCode;
  final String? referralName;
  final String? username;
  final String? fullname;
  final String? type;
  final int? quantityF1;
  final int? quantityF2;
  final List<CollaboratorTreeResponse>? hierarchicalTreeF1Rp;
  final List<CollaboratorTreeResponse>? hierarchicalTreeF2Rp;

  factory CollaboratorTreeResponse.fromRawJson(String str) =>
      CollaboratorTreeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CollaboratorTreeResponse.fromJson(Map<String, dynamic> json) =>
      CollaboratorTreeResponse(
        referralCode: json["referralCode"],
        referralName: json["referralName"],
        username: json["username"],
        fullname: json["fullname"],
        type: json["type"],
        quantityF1: json["quantityF1"],
        quantityF2: json["quantityF2"],
        hierarchicalTreeF1Rp: json["hierarchicalTreeF1Rp"] == null
            ? null
            : List<CollaboratorTreeResponse>.from(json["hierarchicalTreeF1Rp"]
                .map((x) => CollaboratorTreeResponse.fromJson(x))),
        hierarchicalTreeF2Rp: json["hierarchicalTreeF2Rp"] == null
            ? null
            : List<CollaboratorTreeResponse>.from(json["hierarchicalTreeF2Rp"]
                .map((x) => CollaboratorTreeResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "referralCode": referralCode,
        "referralName": referralName,
        "username": username,
        "fullname": fullname,
        "type": type,
        "quantityF1": quantityF1,
        "quantityF2": quantityF2,
        "hierarchicalTreeF1Rp": hierarchicalTreeF1Rp == null
            ? null
            : List<dynamic>.from(hierarchicalTreeF1Rp!.map((x) => x.toJson())),
        "hierarchicalTreeF2Rp": hierarchicalTreeF2Rp == null
            ? null
            : List<dynamic>.from(hierarchicalTreeF2Rp!.map((x) => x.toJson())),
      };
}
