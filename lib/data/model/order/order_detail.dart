// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  OrderDetail({
    this.id,
    this.orderDate,
    this.group,
    this.orderEmployee,
    this.warehouse,
    this.customer,
    this.route,
    this.type,
    this.status,
    this.paymentMethod,
    this.description,
    this.phone,
    this.address,
    this.customerName,
    this.totalAmount,
    this.totalOfVat,
    this.totalDiscountProduct,
    this.tradeDiscount,
    this.totalPayment,
    this.orderCode,
    this.deliveryDate,
    this.prePayment,
    this.listProduct,
    this.listPromotionProduct,
  }) {
    listProduct = listProduct ?? [];
    listPromotionProduct = listPromotionProduct ?? [];
    route = route ?? RouteOrder();
  }

  String? id;
  DateTime? orderDate;
  Group? group;
  OrderEmployee? orderEmployee;
  Warehouse? warehouse;
  Customer? customer;
  RouteOrder? route;
  int? type;
  int? status;
  int? paymentMethod;
  String? description;
  String? phone;
  String? address;
  String? customerName;
  int? totalAmount;
  double? totalOfVat;
  double? totalDiscountProduct;
  double? tradeDiscount;
  double? totalPayment;
  String? orderCode;
  DateTime? deliveryDate;
  int? prePayment;
  List<ProductOrder>? listProduct;
  List<PromotionProductOrder>? listPromotionProduct;

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json["id"],
      orderDate:
          json['orderDate'] == null ? null : DateTime.parse(json["orderDate"]),
      group: json['group'] == null ? null : Group.fromJson(json["group"]),
      orderEmployee: json["orderEmployee"] == null
          ? null
          : OrderEmployee.fromJson(json["orderEmployee"]),
      warehouse: json["warehouse"] == null
          ? null
          : Warehouse.fromJson(json["warehouse"]),
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      route: json["route"] == null ? null : RouteOrder.fromJson(json["route"]),
      type: json["type"],
      status: json["status"],
      paymentMethod: json["paymentMethod"],
      description: json["description"],
      phone: json["phone"],
      address: json["address"],
      customerName: json["customerName"],
      totalAmount: json["totalAmount"],
      totalOfVat: json["totalOfVAT"].toDouble(),
      totalDiscountProduct: json["totalDiscountProduct"].toDouble(),
      tradeDiscount: json["tradeDiscount"].toDouble(),
      totalPayment: json["totalPayment"].toDouble(),
      orderCode: json["orderCode"],
      deliveryDate: json["deliveryDate"] == null
          ? null
          : DateTime.parse(json["deliveryDate"]),
      prePayment: json["prePayment"],
      listProduct: json["listProduct"] == null
          ? null
          : List<ProductOrder>.from(
              json["listProduct"].map((x) => ProductOrder.fromJson(x))),
      listPromotionProduct: json["listPromotionProduct"] == null
          ? null
          : List<PromotionProductOrder>.from(json["listPromotionProduct"]
              .map((x) => PromotionProductOrder.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderDate": orderDate == null ? null : orderDate!.toIso8601String(),
        "group": group,
        "orderEmployee": orderEmployee == null ? null : orderEmployee!.toJson(),
        "warehouse": warehouse,
        "customer": customer == null ? null : customer!.toJson(),
        "route": route,
        "type": type,
        "status": status,
        "paymentMethod": paymentMethod,
        "description": description,
        "phone": phone,
        "address": address,
        "customerName": customerName,
        "totalAmount": totalAmount,
        "totalOfVAT": totalOfVat,
        "totalDiscountProduct": totalDiscountProduct,
        "tradeDiscount": tradeDiscount,
        "totalPayment": totalPayment,
        "orderCode": orderCode,
        "deliveryDate":
            deliveryDate == null ? null : deliveryDate!.toIso8601String(),
        "prePayment": prePayment,
        "listProduct": listProduct == null
            ? null
            : List<dynamic>.from(listProduct!.map((x) => x.toJson())),
        "listPromotionProduct": listPromotionProduct == null
            ? null
            : List<dynamic>.from(listPromotionProduct!.map((x) => x)),
      };
}

class Customer {
  Customer(
      {this.id,
      this.customerCode,
      this.customerName,
      this.customerGroupId,
      this.customerTypeId,
      this.channelId,
      this.areaId,
      this.debtLimit,
      this.lastVisitBy,
      this.contactName});

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

class Group {
  Group({
    this.id,
    this.unitTreeGroupCode,
    this.name,
  });

  String? id;
  String? unitTreeGroupCode;
  String? name;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        unitTreeGroupCode: json["unitTreeGroup_Code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unitTreeGroup_Code": unitTreeGroupCode,
        "name": name,
      };
}

class PromotionProductOrder {
  PromotionProductOrder({
    this.product,
    this.unit,
    this.warehouse,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
    this.discount,
    this.discountRate,
    this.note,
    this.type,
  });

  Product? product;
  Unit? unit;
  Warehouse? warehouse;
  double? unitPrice;
  int? quantity;
  double? totalPrice;
  double? discount;
  double? discountRate;
  String? note;
  int? type;

  factory PromotionProductOrder.fromJson(Map<String, dynamic> json) =>
      PromotionProductOrder(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        warehouse: json["warehouse"] == null
            ? null
            : Warehouse.fromJson(json["warehouse"]),
        unitPrice: json["unitPrice"].toDouble(),
        quantity: json["quantity"],
        totalPrice: json["totalPrice"].toDouble(),
        discount: json["discount"].toDouble(),
        discountRate: json["discountRate"].toDouble(),
        note: json["note"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "product": product == null ? null : product!.toJson(),
        "unit": unit == null ? null : unit!.toJson(),
        "warehouse": warehouse == null ? null : warehouse!.toJson(),
        "unitPrice": unitPrice,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "discount": discount,
        "discountRate": discountRate,
        "note": note,
        "type": type,
      };
}

class ProductOrder {
  ProductOrder({
    this.product,
    this.unit,
    this.warehouse,
    this.unitPrice,
    this.quantity,
    this.numberOfPromotionProduct,
    this.isChecked,
    this.totalPrice,
    this.discount,
    this.discountRate,
    this.note,
    this.type,
  }) {
    isChecked = false;
  }

  Product? product;
  Unit? unit;
  Warehouse? warehouse;
  double? unitPrice;
  int? quantity;
  int? numberOfPromotionProduct;
  bool? isChecked;
  double? totalPrice;
  double? discount;
  double? discountRate;
  String? note;
  int? type;

  factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        warehouse: json["warehouse"] == null
            ? null
            : Warehouse.fromJson(json["warehouse"]),
        unitPrice: json["unitPrice"] == null ? 0 : json["unitPrice"].toDouble(),
        quantity: json["quantity"] ?? 0,
        totalPrice:
            json["totalPrice"] == null ? 0 : json["totalPrice"].toDouble(),
        discount: json["discount"] == null ? 0 : json["discount"].toDouble(),
        discountRate:
            json["discountRate"] == null ? 0 : json["discountRate"].toDouble(),
        note: json["note"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "product": product == null ? null : product!.toJson(),
        "unit": unit == null ? null : unit!.toJson(),
        "warehouse": warehouse == null ? null : warehouse!.toJson(),
        "unitPrice": unitPrice,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "discount": discount,
        "discountRate": discountRate,
        "note": note,
        "type": type,
      };
}

class Product {
  Product({
    this.id,
    this.sku,
    this.productName,
    this.retailPrice,
    this.price,
    this.importRetailPrice,
    this.importPrice,
    this.vat,
    this.discountAcc,
    this.priceAcc,
    this.supplierId,
    this.warehouseId,
  });

  String? id;
  String? sku;
  String? productName;
  double? retailPrice;
  double? price;
  double? importRetailPrice;
  double? importPrice;
  double? vat;
  dynamic discountAcc;
  dynamic priceAcc;
  dynamic supplierId;
  dynamic warehouseId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sku: json["sku"],
        productName: json["productName"],
        retailPrice: json["retailPrice"].toDouble(),
        price: json["price"].toDouble(),
        importRetailPrice: json["importRetailPrice"].toDouble(),
        importPrice: json["importPrice"].toDouble(),
        vat: json["vat"].toDouble(),
        discountAcc: json["discountAcc"],
        priceAcc: json["priceAcc"],
        supplierId: json["supplierId"],
        warehouseId: json["warehouseId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "productName": productName,
        "retailPrice": retailPrice,
        "price": price,
        "importRetailPrice": importRetailPrice,
        "importPrice": importPrice,
        "vat": vat,
        "discountAcc": discountAcc,
        "priceAcc": priceAcc,
        "supplierId": supplierId,
        "warehouseId": warehouseId,
      };
}

class Unit {
  Unit({
    this.id,
    this.serial,
    this.unitCode,
    this.unitName,
  });

  String? id;
  dynamic serial;
  String? unitCode;
  String? unitName;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        serial: json["serial"],
        unitCode: json["unitCode"],
        unitName: json["unitName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial": serial,
        "unitCode": unitCode,
        "unitName": unitName,
      };
}

class Warehouse {
  Warehouse({
    this.id,
    this.serial,
    this.warehouseCode,
    this.warehouseName,
    this.warehouseType,
    this.description,
  });

  String? id;
  String? serial;
  String? warehouseCode;
  String? warehouseName;
  String? warehouseType;
  dynamic description;

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        id: json["id"],
        serial: json["serial"],
        warehouseCode: json["warehouseCode"],
        warehouseName: json["warehouseName"],
        warehouseType: json["warehouseType"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial": serial,
        "warehouseCode": warehouseCode,
        "warehouseName": warehouseName,
        "warehouseType": warehouseType,
        "description": description,
      };
}

class OrderEmployee {
  OrderEmployee({
    this.id,
  });

  String? id;

  factory OrderEmployee.fromJson(Map<String, dynamic> json) => OrderEmployee(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class RouteOrder {
  RouteOrder({
    this.id,
  });

  String? id;

  factory RouteOrder.fromJson(Map<String, dynamic> json) => RouteOrder(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
