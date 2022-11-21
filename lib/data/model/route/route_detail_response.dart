// To parse this JSON data, do
//
//     final routeDetailResponse = routeDetailResponseFromJson(jsonString);

import 'dart:convert';

class RouteDetailResponse {
  RouteDetailResponse({
    this.data,
    this.totalCount,
  });

  final List<RouteData>? data;
  final int? totalCount;

  factory RouteDetailResponse.fromRawJson(String str) =>
      RouteDetailResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RouteDetailResponse.fromJson(Map<String, dynamic> json) =>
      RouteDetailResponse(
        data: json["data"] == null
            ? null
            : List<RouteData>.from(
                json["data"].map((x) => RouteData.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class RouteData {
  RouteData({
    this.id,
    this.routeCode,
    this.routeName,
    this.employee,
    this.unitTreeGroup,
    this.routeDate,
    this.startedDate,
    this.status,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
  });

  final String? id;
  final String? routeCode;
  final String? routeName;
  final RouteEmployee? employee;
  final UnitTreeGroup? unitTreeGroup;
  final String? routeDate;
  final String? startedDate;
  final dynamic status;
  final String? createdBy;
  final String? createdDate;
  final String? lastModifiedBy;
  final String? lastModifiedDate;

  factory RouteData.fromRawJson(String str) =>
      RouteData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RouteData.fromJson(Map<String, dynamic> json) => RouteData(
        id: json["id"],
        routeCode: json["routeCode"],
        routeName: json["routeName"],
        employee: json["employee"] == null
            ? null
            : RouteEmployee.fromJson(json["employee"]),
        unitTreeGroup: json["unitTreeGroup"] == null
            ? null
            : UnitTreeGroup.fromJson(json["unitTreeGroup"]),
        routeDate: json["routeDate"],
        startedDate: json["startedDate"],
        status: json["status"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"],
        lastModifiedBy:
            json["lastModifiedBy"],
        lastModifiedDate:
            json["lastModifiedDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "routeCode": routeCode,
        "routeName": routeName,
        "employee": employee == null ? null : employee!.toJson(),
        "unitTreeGroup": unitTreeGroup == null ? null : unitTreeGroup!.toJson(),
        "routeDate": routeDate,
        "startedDate": startedDate,
        "status": status,
        "createdBy": createdBy,
        "createdDate": createdDate == null ? null : createdDate!,
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate == null ? null : lastModifiedDate!,
      };
}

class RouteEmployee {
  RouteEmployee({
    this.id,
    this.employeeCode,
    this.employeeName,
    this.email,
    this.employeeTitle,
  });

  final String? id;
  final String? employeeCode;
  final String? employeeName;
  final String? email;
  final String? employeeTitle;

  factory RouteEmployee.fromRawJson(String str) =>
      RouteEmployee.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RouteEmployee.fromJson(Map<String, dynamic> json) => RouteEmployee(
        id: json["id"],
        employeeCode:
            json["employeeCode"],
        employeeName:
            json["employeeName"],
        email: json["email"],
        employeeTitle:
            json["employeeTitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeCode": employeeCode,
        "employeeName": employeeName,
        "email": email,
        "employeeTitle": employeeTitle,
      };
}

class UnitTreeGroup {
  UnitTreeGroup({
    this.id,
    this.unitTreeGroupCode,
    this.name,
    this.orgName,
    this.fullOrgName,
  });

  final String? id;
  final String? unitTreeGroupCode;
  final String? name;
  final dynamic orgName;
  final dynamic fullOrgName;

  factory UnitTreeGroup.fromRawJson(String str) =>
      UnitTreeGroup.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitTreeGroup.fromJson(Map<String, dynamic> json) => UnitTreeGroup(
        id: json["id"],
        unitTreeGroupCode: json["unitTreeGroup_Code"],
        name: json["name"],
        orgName: json["orgName"],
        fullOrgName: json["fullOrgName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unitTreeGroup_Code":
            unitTreeGroupCode,
        "name": name,
        "orgName": orgName,
        "fullOrgName": fullOrgName,
      };
}
