// To parse this JSON data, do
//
//     final routeResponse = routeResponseFromJson(jsonString);

import 'dart:convert';

RouteResponse routeResponseFromJson(String str) =>
    RouteResponse.fromJson(json.decode(str));

String routeResponseToJson(RouteResponse data) => json.encode(data.toJson());

class RouteResponse {
  RouteResponse({
    this.routeId,
    this.route,
    this.customerId,
    this.customer,
    this.lastModifiedDate,
  });

  String? routeId;
  Route? route;
  String? customerId;
  dynamic customer;
  DateTime? lastModifiedDate;

  factory RouteResponse.fromJson(Map<String, dynamic> json) => RouteResponse(
        routeId: json["routeId"],
        route: Route.fromJson(json["route"]),
        customerId: json["customerId"],
        customer: json["customer"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "routeId": routeId,
        "route": route?.toJson(),
        "customerId": customerId,
        "customer": customer,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
      };
}

class Route {
  Route({
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

  String? id;
  String? routeCode;
  String? routeName;
  Employee? employee;
  UnitTreeGroup? unitTreeGroup;
  dynamic routeDate;
  dynamic startedDate;
  dynamic status;
  dynamic createdBy;
  DateTime? createdDate;
  String? lastModifiedBy;
  DateTime? lastModifiedDate;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        routeCode: json["routeCode"],
        routeName: json["routeName"],
        employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
        unitTreeGroup: json["unitTreeGroup"] == null ? null : UnitTreeGroup.fromJson(json["unitTreeGroup"]),
        routeDate: json["routeDate"],
        startedDate: json["startedDate"],
        status: json["status"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null ? null : DateTime.parse(json["lastModifiedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "routeCode": routeCode,
        "routeName": routeName,
        "employee": employee?.toJson(),
        "unitTreeGroup": unitTreeGroup?.toJson(),
        "routeDate": routeDate,
        "startedDate": startedDate,
        "status": status,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate?.toIso8601String(),
      };
}

class Employee {
  Employee({
    this.id,
    this.employeeCode,
    this.employeeName,
    this.email,
    this.employeeTitle,
  });

  String? id;
  String? employeeCode;
  String? employeeName;
  String? email;
  String? employeeTitle;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeCode: json["employeeCode"],
        employeeName: json["employeeName"],
        email: json["email"],
        employeeTitle: json["employeeTitle"],
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

  String? id;
  String? unitTreeGroupCode;
  String? name;
  dynamic orgName;
  dynamic fullOrgName;

  factory UnitTreeGroup.fromJson(Map<String, dynamic> json) => UnitTreeGroup(
        id: json["id"],
        unitTreeGroupCode: json["unitTreeGroup_Code"],
        name: json["name"],
        orgName: json["orgName"],
        fullOrgName: json["fullOrgName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unitTreeGroup_Code": unitTreeGroupCode,
        "name": name,
        "orgName": orgName,
        "fullOrgName": fullOrgName,
      };
}
