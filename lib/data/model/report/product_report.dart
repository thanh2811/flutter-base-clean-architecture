// To parse this JSON data, do
//
//     final productReport = productReportFromJson(jsonString);

import 'dart:convert';

ProductReport productReportFromJson(String str) =>
    ProductReport.fromJson(json.decode(str));

String productReportToJson(ProductReport data) => json.encode(data.toJson());

class ProductReport {
  ProductReport({
    this.data,
    this.sumOfQuantity,
    this.sumOfNetRevenue,
    this.sumOfTotalMoney,
    this.sumOfRevenue,
    this.sumOfOrder,
    this.sumOfCustomer,
    this.sumOfProduct,
  }) {
    data ??= [];
    sumOfQuantity ??= 0;
    sumOfNetRevenue ??= 0;
    sumOfTotalMoney ??= 0;
    sumOfRevenue ??= 0;
    sumOfOrder ??= 0;
    sumOfCustomer ??= 0;
    sumOfProduct ??= 0;
  }

  List<Datum>? data;
  int? sumOfQuantity;
  int? sumOfNetRevenue;
  int? sumOfTotalMoney;
  int? sumOfRevenue;
  int? sumOfOrder;
  int? sumOfCustomer;
  int? sumOfProduct;

  factory ProductReport.fromJson(Map<String, dynamic> json) => ProductReport(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        sumOfQuantity: json["sumOfQuantity"],
        sumOfNetRevenue: json["sumOfNetRevenue"],
        sumOfTotalMoney: json["sumOfTotalMoney"],
        sumOfRevenue: json["sumOfRevenue"],
        sumOfOrder: json["sumOfOrder"],
        sumOfCustomer: json["sumOfCustomer"],
        sumOfProduct: json["sumOfProduct"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "sumOfQuantity": sumOfQuantity,
        "sumOfNetRevenue": sumOfNetRevenue,
        "sumOfTotalMoney": sumOfTotalMoney,
        "sumOfRevenue": sumOfRevenue,
        "sumOfOrder": sumOfOrder,
        "sumOfCustomer": sumOfCustomer,
        "sumOfProduct": sumOfProduct,
      };
}

class Datum {
  Datum({
    this.productId,
    this.productName,
    this.netRevenue,
    this.totalMoney,
    this.quantity,
    this.unit,
    this.productCode,
    this.revenue,
    this.quantityOfOrder,
    this.quantityOfCustomer,
  });

  String? productId;
  String? productName;
  int? netRevenue;
  int? totalMoney;
  int? quantity;
  Unit? unit;
  String? productCode;
  int? revenue;
  int? quantityOfOrder;
  int? quantityOfCustomer;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["productId"],
        productName: json["productName"],
        netRevenue: json["netRevenue"],
        totalMoney: json["totalMoney"],
        quantity: json["quantity"],
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        productCode: json["productCode"],
        revenue: json["revenue"],
        quantityOfOrder: json["quantityOfOrder"],
        quantityOfCustomer: json["quantityOfCustomer"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "netRevenue": netRevenue,
        "totalMoney": totalMoney,
        "quantity": quantity,
        "unit": unit?.toJson(),
        "productCode": productCode,
        "revenue": revenue,
        "quantityOfOrder": quantityOfOrder,
        "quantityOfCustomer": quantityOfCustomer,
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
