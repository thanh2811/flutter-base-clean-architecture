// To parse this JSON data, do
//
//     final listProductResponse = listProductResponseFromJson(jsonString);

import 'dart:convert';

import '../order/order_detail.dart';

ListProductResponse listProductResponseFromJson(String str) =>
    ListProductResponse.fromJson(json.decode(str));

String listProductResponseToJson(ListProductResponse data) =>
    json.encode(data.toJson());

class ListProductResponse {
  ListProductResponse({
    this.data,
    this.totalCount,
  });

  List<Datum>? data;
  int? totalCount;

  factory ListProductResponse.fromJson(Map<String, dynamic> json) =>
      ListProductResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class Datum {
  Datum({
    this.id,
    this.sku,
    this.productName,
    this.barcode,
    this.retailPrice,
    this.price,
    this.importRetailPrice,
    this.importPrice,
    this.vat,
    this.discountAcc,
    this.priceAcc,
    this.status,
    this.inventoryWarning,
    this.conversionNumber,
    this.productDescription,
    this.medias,
    this.major,
    this.warehouse,
    this.brand,
    this.supplier,
    this.retailUnit,
    this.wholeSaleUnit,
    this.warehouseAcc,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
  });

  String? id;
  String? sku;
  String? productName;
  String? barcode;
  double? retailPrice;
  double? price;
  double? importRetailPrice;
  double? importPrice;
  double? vat;
  String? discountAcc;
  String? priceAcc;
  bool? status;
  int? inventoryWarning;
  int? conversionNumber;
  String? productDescription;
  List<Media>? medias;
  Major? major;
  dynamic warehouse;
  Brand? brand;
  Supplier? supplier;
  Unit? retailUnit;
  Unit? wholeSaleUnit;
  dynamic warehouseAcc;
  dynamic createdBy;
  DateTime? createdDate;
  dynamic lastModifiedBy;
  DateTime? lastModifiedDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sku: json["sku"],
        productName: json["productName"],
        barcode: json["barcode"],
        retailPrice: json["retailPrice"].toDouble(),
        price: json["price"].toDouble(),
        importRetailPrice: json["importRetailPrice"].toDouble(),
        importPrice: json["importPrice"].toDouble(),
        vat: json["vat"].toDouble(),
        discountAcc: json["discountAcc"],
        priceAcc: json["priceAcc"],
        status: json["status"],
        inventoryWarning: json["inventoryWarning"],
        conversionNumber: json["conversionNumber"],
        productDescription: json["productDescription"],
        medias: json["medias"] == null
            ? null
            : List<Media>.from(json["medias"].map((x) => Media.fromJson(x))),
        major: json["major"] == null ? null : Major.fromJson(json["major"]),
        warehouse: json["warehouse"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        supplier: json["supplier"] == null
            ? null
            : Supplier.fromJson(json["supplier"]),
        retailUnit: json["retailUnit"] == null
            ? null
            : Unit.fromJson(json["retailUnit"]),
        wholeSaleUnit: json["wholeSaleUnit"] == null
            ? null
            : Unit.fromJson(json["wholeSaleUnit"]),
        warehouseAcc: json["warehouseAcc"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastModifiedBy: json["lastModifiedBy"],
        lastModifiedDate: json["lastModifiedDate"] == null
            ? null
            : DateTime.parse(json["lastModifiedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "productName": productName,
        "barcode": barcode,
        "retailPrice": retailPrice,
        "price": price,
        "importRetailPrice": importRetailPrice,
        "importPrice": importPrice,
        "vat": vat,
        "discountAcc": discountAcc,
        "priceAcc": priceAcc,
        "status": status,
        "inventoryWarning": inventoryWarning,
        "conversionNumber": conversionNumber,
        "productDescription": productDescription,
        "medias": medias == null
            ? null
            : List<dynamic>.from(medias!.map((x) => x.toJson())),
        "major": major == null ? null : major!.toJson(),
        "warehouse": warehouse,
        "brand": brand == null ? null : brand!.toJson(),
        "supplier": supplier == null ? null : supplier!.toJson(),
        "retailUnit": retailUnit == null ? null : retailUnit!.toJson(),
        "wholeSaleUnit": wholeSaleUnit == null ? null : wholeSaleUnit!.toJson(),
        "warehouseAcc": warehouseAcc,
        "createdBy": createdBy,
        "createdDate": createdDate!.toIso8601String(),
        "lastModifiedBy": lastModifiedBy,
        "lastModifiedDate": lastModifiedDate == null
            ? null
            : lastModifiedDate!.toIso8601String(),
      };
}

class Brand {
  Brand({
    this.id,
    this.brandName,
    this.brandCode,
  });

  String? id;
  String? brandName;
  String? brandCode;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        brandName: json["brandName"],
        brandCode: json["brandCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandName": brandName,
        "brandCode": brandCode,
      };
}

class Major {
  Major({
    this.id,
    this.commodityName,
    this.commodityCode,
  });

  String? id;
  String? commodityName;
  String? commodityCode;

  factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        commodityName: json["commodityName"],
        commodityCode: json["commodityCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "commodityName": commodityName,
        "commodityCode": commodityCode,
      };
}

class Media {
  Media({
    this.id,
    this.value,
  });

  String? id;
  String? value;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}

class Supplier {
  Supplier({
    this.id,
    this.supplierName,
    this.supplierCode,
  });

  String? id;
  String? supplierName;
  String? supplierCode;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        supplierName: json["supplierName"],
        supplierCode: json["supplierCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplierName": supplierName,
        "supplierCode": supplierCode,
      };
}
