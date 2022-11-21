import 'dart:convert';

import 'customer_info_response.dart';


class CustomerSearchResult {
  CustomerSearchResult({
    this.data,
    this.totalCount,
  });

  final List<CustomerInfoRepsonse>? data;
  final int? totalCount;

  factory CustomerSearchResult.fromRawJson(String str) =>
      CustomerSearchResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerSearchResult.fromJson(Map<String, dynamic> json) =>
      CustomerSearchResult(
        data: json["data"] == null
            ? null
            : List<CustomerInfoRepsonse>.from(
                json["data"].map((x) => CustomerInfoRepsonse.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}
