// To parse this JSON data, do
//
//     final accountInfo = accountInfoFromJson(jsonString);

import 'dart:convert';

class AccountInfo {
  AccountInfo({
    this.id,
    this.login,
    this.referralCode,
    this.firstName,
    this.email,
    this.imageUrl,
    this.activated,
    this.langKey,
    this.createdDate,
    this.createdBy,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.authorities,
  });

  final String? id;
  final String? login;
  final String? referralCode;
  final String? firstName;
  final String? email;
  final String? imageUrl;
  final bool? activated;
  final String? langKey;
  final String? createdDate;
  final String? createdBy;
  final String? lastModifiedBy;
  final String? lastModifiedDate;
  final List<String>? authorities;

  factory AccountInfo.fromRawJson(String str) =>
      AccountInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountInfo.fromJson(Map<String, dynamic> json) => AccountInfo(
        id: json["id"],
        login: json["login"],
        referralCode: json["referralCode"],
        firstName: json["firstName"],
        email: json["email"],
        imageUrl: json["imageUrl"],
        activated: json["activated"],
        langKey: json["langKey"],
        createdDate: json["createdDate"],
        createdBy: json["createdBy"],
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"],
        authorities: json["authorities"] == null
            ? null
            : List<String>.from(json["authorities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
        "referralCode": referralCode,
        "firstName": firstName,
        "email": email,
        "imageUrl": imageUrl,
        "activated": activated,
        "langKey": langKey,
        "createdDate": createdDate,
        "createdBy": createdBy,
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate,
        "authorities": authorities == null
            ? null
            : List<dynamic>.from(authorities!.map((x) => x)),
      };
}
