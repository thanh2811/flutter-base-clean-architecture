import 'dart:convert';

List<Warehouse> warehouseFromJson(String str) => List<Warehouse>.from(json.decode(str).map((x) => Warehouse.fromJson(x)));

String warehouseToJson(List<Warehouse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Warehouse {
  Warehouse({
    this.id,
    this.warehouseName,
    this.warehouseCode,
  });

  String? id;
  String? warehouseName;
  String? warehouseCode;

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["id"],
    warehouseName: json["warehouseName"],
    warehouseCode: json["warehouseCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "warehouseName": warehouseName,
    "warehouseCode": warehouseCode,
  };
}