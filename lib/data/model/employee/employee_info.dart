// To parse this JSON data, do
//
//     final employeeInfo = employeeInfoFromJson(jsonString);

import 'dart:convert';

class EmployeeInfo {
  EmployeeInfo({
    this.id,
    this.employeeCode,
    this.employeeName,
    this.email,
    this.employeeTitle,
    this.status,
    this.lastSeenDate,
    this.lastSyncDate,
    this.createdDate,
    this.lastModifiedDate,
  });

  final String? id;
  final String? employeeCode;
  final String? employeeName;
  final String? email;
  final String? employeeTitle;
  final bool? status;
  final String? lastSeenDate;
  final String? lastSyncDate;
  final String? createdDate;
  final String? lastModifiedDate;

  factory EmployeeInfo.fromRawJson(String str) =>
      EmployeeInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) => EmployeeInfo(
        id: json["id"],
        employeeCode: json["employeeCode"],
        employeeName: json["employeeName"],
        email: json["email"],
        employeeTitle: json["employeeTitle"],
        status: json["status"],
        lastSeenDate: json["lastSeenDate"],
        lastSyncDate: json["lastSyncDate"],
        createdDate: json["createdDate"],
        lastModifiedDate: json["lastModifiedDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeCode": employeeCode,
        "employeeName": employeeName,
        "email": email,
        "employeeTitle": employeeTitle,
        "status": status,
        "lastSeenDate": lastSeenDate,
        "lastSyncDate": lastSyncDate,
        "createdDate": createdDate,
        "lastModifiedDate": lastModifiedDate,
      };
}
