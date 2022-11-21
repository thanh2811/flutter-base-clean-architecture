class CheckInResponse {
  CheckInResponse({
    required this.id,
    required this.customerId,
    required this.employeeId,
    required this.albumId,
    required this.image,
    required this.status,
    required this.orderId,
    required this.returnId,
    required this.checkInTime,
    required this.checkOutTime,
    required this.checkInAddress,
    required this.createdBy,
    required this.createdDate,
  });
  late final String id;
  late final String customerId;
  late final String employeeId;
  late final String albumId;
  late final String image;
  late final String status;
  late final String orderId;
  late final String returnId;
  late final String checkInTime;
  late final String checkOutTime;
  late final String checkInAddress;
  late final String createdBy;
  late final String createdDate;

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    employeeId = json['employeeId'];
    albumId = json['albumId'];
    image = json['image'];
    status = json['status'];
    orderId = json['orderId'];
    returnId = json['returnId'];
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    checkInAddress = json['checkInAddress'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['customerId'] = customerId;
    _data['employeeId'] = employeeId;
    _data['albumId'] = albumId;
    _data['image'] = image;
    _data['status'] = status;
    _data['orderId'] = orderId;
    _data['returnId'] = returnId;
    _data['checkInTime'] = checkInTime;
    _data['checkOutTime'] = checkOutTime;
    _data['checkInAddress'] = checkInAddress;
    _data['createdBy'] = createdBy;
    _data['createdDate'] = createdDate;
    return _data;
  }
}
