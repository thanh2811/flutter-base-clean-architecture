class ProductReturnRequest {
  ProductReturnRequest({
    required this.productId,
    required this.unitId,
    required this.warehouseId,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
    required this.discount,
    required this.discountRate,
    required this.note,
    required this.type,
    required this.salesQuantity,
    required this.exportQuantity,
    required this.returnsQuantity,
  });
  late final String productId;
  late final String unitId;
  late final String warehouseId;
  late final double unitPrice;
  late final int quantity;
  late final double totalPrice;
  late final double discount;
  late final double discountRate;
  late final String note;
  late final int type;
  late final int salesQuantity;
  late final int exportQuantity;
  late final int returnsQuantity;

  ProductReturnRequest.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    unitId = json['unitId'];
    warehouseId = json['warehouseId'];
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    discount = json['discount'];
    discountRate = json['discountRate'];
    note = json['note'];
    type = json['type'];
    salesQuantity = json['salesQuantity'];
    exportQuantity = json['exportQuantity'];
    returnsQuantity = json['returnsQuantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['unitId'] = unitId;
    data['warehouseId'] = warehouseId;
    data['unitPrice'] = unitPrice;
    data['quantity'] = quantity;
    data['totalPrice'] = totalPrice;
    data['discount'] = discount;
    data['discountRate'] = discountRate;
    data['note'] = note;
    data['type'] = type;
    data['salesQuantity'] = salesQuantity;
    data['exportQuantity'] = exportQuantity;
    data['returnsQuantity'] = returnsQuantity;
    return data;
  }
}
