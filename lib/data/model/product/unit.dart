import 'dart:convert';

List<Unit> unitFromJson(String str) =>
    List<Unit>.from(json.decode(str).map((x) => Unit.fromJson(x)));

String unitToJson(List<Unit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Unit {
  Unit({
    this.id,
    this.unitName,
    this.unitCode,
  });

  String? id;
  String? unitName;
  String? unitCode;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        unitName: json["unitName"],
        unitCode: json["unitCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unitName": unitName,
        "unitCode": unitCode,
      };
}
