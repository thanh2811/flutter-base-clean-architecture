// To parse this JSON data, do
//
//     final listOrder = listOrderFromJson(jsonString);

import 'dart:convert';

ListOrder listOrderFromJson(String str) => ListOrder.fromJson(json.decode(str));

String listOrderToJson(ListOrder data) => json.encode(data.toJson());

class ListOrder {
  ListOrder({
    this.data,
    this.totalCount,
  });

  List<Order>? data;
  int? totalCount;

  factory ListOrder.fromJson(Map<String, dynamic> json) => ListOrder(
        data: List<Order>.from(json["data"].map((x) => Order.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class Order {
  Order({
    this.id,
    this.orderDate,
    this.orderEmployee,
    this.customer,
    this.type,
    this.status,
    this.route,
    this.phone,
    this.address,
    this.customerName,
    this.totalPayment,
    this.orderCode,
    this.totalAmount,
  });

  String? id;
  DateTime? orderDate;
  OrderEmployee? orderEmployee;
  Customer? customer;
  int? type;
  int? status;
  dynamic route;
  String? phone;
  String? address;
  String? customerName;
  int? totalPayment;
  String? orderCode;
  int? totalAmount;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        orderEmployee: json["orderEmployee"] == null
            ? null
            : OrderEmployee.fromJson(json["orderEmployee"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        type: json["type"],
        status: json["status"],
        route: json["route"],
        phone: json["phone"],
        address: json["address"],
        customerName: json["customerName"],
        totalPayment: json["totalPayment"],
        orderCode: json["orderCode"],
        totalAmount: json["totalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderDate": orderDate == null ? null : orderDate!.toIso8601String(),
        "orderEmployee": orderEmployee == null ? null : orderEmployee!.toJson(),
        "customer": customer == null ? null : customer!.toJson(),
        "type": type,
        "status": status,
        "route": route,
        "phone": phone,
        "address": address,
        "customerName": customerName,
        "totalPayment": totalPayment,
        "orderCode": orderCode,
        "totalAmount": totalAmount,
      };
}
class Customer {
  Customer({
    this.id,
    this.customerCode,
    this.customerName,
    this.customerGroupId,
    this.customerTypeId,
    this.channelId,
    this.areaId,
    this.debtLimit,
    this.lastVisitBy,
    this.contactName,
  });

  String? id;
  String? customerCode;
  String? customerName;
  String? customerGroupId;
  String? customerTypeId;
  String? channelId;
  String? areaId;
  String? debtLimit;
  String? lastVisitBy;
  String? contactName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    customerCode: json["customerCode"],
    customerName: json["customerName"],
    customerGroupId: json["customerGroupId"],
    customerTypeId: json["customerTypeId"],
    channelId: json["channelId"],
    areaId: json["areaId"],
    debtLimit: json["debtLimit"],
    lastVisitBy: json["lastVisitBy"],
    contactName: json["contactName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customerCode": customerCode,
    "customerName": customerName,
    "customerGroupId": customerGroupId,
    "customerTypeId": customerTypeId,
    "channelId": channelId,
    "areaId": areaId,
    "debtLimit": debtLimit,
    "lastVisitBy": lastVisitBy,
    "contactName": contactName,
  };
}

class OrderEmployee {
  OrderEmployee({
    this.id,
    this.employeeCode,
    this.employeeName,
    this.employeeTitle,
  });

  String? id;
  String? employeeCode;
  String? employeeName;
  String? employeeTitle;

  factory OrderEmployee.fromJson(Map<String, dynamic> json) => OrderEmployee(
    id: json["id"],
    employeeCode: json["employeeCode"],
    employeeName: json["employeeName"],
    employeeTitle: json["employeeTitle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeCode": employeeCode,
    "employeeName": employeeName,
    "employeeTitle": employeeTitle,
  };
}
