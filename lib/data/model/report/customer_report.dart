// To parse this JSON data, do
//
//     final customerReport = customerReportFromJson(jsonString);

import 'dart:convert';

CustomerReport customerReportFromJson(String str) =>
    CustomerReport.fromJson(json.decode(str));

String customerReportToJson(CustomerReport data) => json.encode(data.toJson());

class CustomerReport {
  CustomerReport({
    this.data,
    this.sumOfProduct,
    this.sumOfTotalMoney,
    this.sumOfOrder,
    this.sumOfQuantity,
    this.sumOfNetRevenue,
    this.sumOfRevenue,
    this.sumOfCustomer,
  }) {
    data ??= [];
    sumOfProduct ??= 0;
    sumOfTotalMoney ??= 0;
    sumOfOrder ??= 0;
    sumOfQuantity ??= 0;
    sumOfNetRevenue ??= 0;
    sumOfRevenue ??= 0;
    sumOfCustomer ??= 0;
  }

  List<Datum>? data;
  int? sumOfProduct;
  int? sumOfTotalMoney;
  int? sumOfOrder;
  int? sumOfQuantity;
  int? sumOfNetRevenue;
  int? sumOfRevenue;
  int? sumOfCustomer;

  factory CustomerReport.fromJson(Map<String, dynamic> json) => CustomerReport(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        sumOfProduct: json["sumOfProduct"],
        sumOfTotalMoney: json["sumOfTotalMoney"],
        sumOfOrder: json["sumOfOrder"],
        sumOfQuantity: json["sumOfQuantity"],
        sumOfNetRevenue: json["sumOfNetRevenue"],
        sumOfRevenue: json["sumOfRevenue"],
        sumOfCustomer: json["sumOfCustomer"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<Datum>.from(data!.map((x) => x.toJson())),
        "sumOfProduct": sumOfProduct,
        "sumOfTotalMoney": sumOfTotalMoney,
        "sumOfOrder": sumOfOrder,
        "sumOfQuantity": sumOfQuantity,
        "sumOfNetRevenue": sumOfNetRevenue,
        "sumOfRevenue": sumOfRevenue,
        "sumOfCustomer": sumOfCustomer,
      };
}

class Datum {
  Datum({
    this.customer,
    this.netRevenue,
    this.totalMoney,
    this.quantity,
    this.unit,
    this.revenue,
    this.numberOfOrder,
    this.numberOfProduct,
  });

  Customer? customer;
  int? netRevenue;
  int? totalMoney;
  int? quantity;
  Unit? unit;
  int? revenue;
  int? numberOfOrder;
  int? numberOfProduct;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        netRevenue: json["netRevenue"],
        totalMoney: json["totalMoney"],
        quantity: json["quantity"],
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        revenue: json["revenue"],
        numberOfOrder: json["numberOfOrder"],
        numberOfProduct: json["numberOfProduct"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer?.toJson(),
        "netRevenue": netRevenue,
        "totalMoney": totalMoney,
        "quantity": quantity,
        "unit": unit?.toJson(),
        "revenue": revenue,
        "numberOfOrder": numberOfOrder,
        "numberOfProduct": numberOfProduct,
      };
}

class Customer {
  Customer({
    this.id,
    this.customerCode,
    this.customerName,
    this.address,
    this.phone,
  });

  String? id;
  String? customerCode;
  String? customerName;
  String? address;
  String? phone;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        customerCode: json["customerCode"],
        customerName: json["customerName"],
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerCode": customerCode,
        "customerName": customerName,
        "address": address,
        "phone": phone,
      };
}

class Unit {
  Unit({
    this.id,
    this.unitName,
  });

  String? id;
  String? unitName;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        unitName: json["unitName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unitName": unitName,
      };
}
