// To parse this JSON data, do
//
//     final productRequest = productRequestFromJson(jsonString);

import 'dart:convert';

ProductRequest productRequestFromJson(String str) => ProductRequest.fromJson(json.decode(str));

String productRequestToJson(ProductRequest data) => json.encode(data.toJson());

class ProductRequest {
  ProductRequest({
    this.productId,
    this.productName,
    this.unitId,
    this.warehouseId,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
    this.discount,
    this.discountRate,
    this.note,
    this.type,
    this.numberOfPromotionProduct,
  }){
    quantity = quantity ?? 0;
    unitPrice = unitPrice ?? 0;
    discountRate = discountRate ?? 0;
    discount = discount ?? 0;
  }

  String? productId;
  String? productName;
  String? unitId;
  String? warehouseId;
  double? unitPrice;
  int? quantity;
  double? totalPrice;
  double? discount;
  double? discountRate;
  String? note;
  int? type;
  int? numberOfPromotionProduct;

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
    productId: json["productId"],
    productName: json["productName"],
    unitId: json["unitId"],
    warehouseId: json["warehouseId"],
    unitPrice: json["unitPrice"],
    quantity: json["quantity"],
    totalPrice: json["totalPrice"],
    discount: json["discount"],
    discountRate: json["discountRate"],
    note: json["note"],
    type: json["type"],
    numberOfPromotionProduct: json["numberOfPromotionProduct"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "unitId": unitId,
    "warehouseId": warehouseId,
    "unitPrice": unitPrice,
    "quantity": quantity,
    "totalPrice": totalPrice,
    "discount": discount,
    "discountRate": discountRate,
    "note": note,
    "type": type,
    "numberOfPromotionProduct": numberOfPromotionProduct,
  };
}
