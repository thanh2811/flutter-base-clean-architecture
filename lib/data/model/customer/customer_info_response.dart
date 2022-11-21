class CustomerInfoRepsonse {
  String? id;
  String? customerCode;
  String? customerName;
  CustomerGroup? customerGroup;
  CustomerType? customerType;
  Channel? channel;
  Area? area;
  bool? status;
  bool? isUpdateAddress;
  String? address;
  String? deliveryAddress;
  String? province;
  String? district;
  String? ward;
  String? dob;
  String? contactName;
  String? position;
  String? phone;
  String? email;
  String? avatar;
  String? debtLimit;
  String? cashAcc;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastVisitBy;
  String? lastOrderBy;
  String? lastModifiedDate;
  String? lastVisitTime;

  CustomerInfoRepsonse(
      {this.id,
      this.customerCode,
      this.customerName,
      this.customerGroup,
      this.customerType,
      this.channel,
      this.area,
      this.status,
      this.isUpdateAddress,
      this.address,
      this.deliveryAddress,
      this.province,
      this.district,
      this.ward,
      this.dob,
      this.contactName,
      this.position,
      this.phone,
      this.email,
      this.avatar,
      this.debtLimit,
      this.cashAcc,
      this.createdBy,
      this.createdDate,
      this.lastModifiedBy,
      this.lastVisitBy,
      this.lastOrderBy,
      this.lastVisitTime,
      this.lastModifiedDate});

  CustomerInfoRepsonse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerCode = json['customerCode'];
    customerName = json['customerName'];
    customerGroup = json['customerGroup'] != null
        ? CustomerGroup.fromJson(json['customerGroup'])
        : null;
    customerType = json['customerType'] != null
        ? CustomerType.fromJson(json['customerType'])
        : null;
    channel =
        json['channel'] != null ? Channel.fromJson(json['channel']) : null;
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
    status = json['status'];
    isUpdateAddress = json['isUpdateAddress'];
    address = json['address'];
    deliveryAddress = json['deliveryAddress'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    dob = json['dob'];
    contactName = json['contactName'];
    position = json['position'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
    debtLimit = json['debtLimit'];
    cashAcc = json['cashAcc'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastVisitBy = json['lastVisitBy'];
    lastOrderBy = json['lastOrderBy'];
    lastModifiedDate = json['lastModifiedDate'];
    lastVisitTime = json['lastVisitTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customerCode'] = customerCode;
    data['customerName'] = customerName;
    if (customerGroup != null) {
      data['customerGroup'] = customerGroup?.toJson();
    }
    if (customerType != null) {
      data['customerType'] = customerType?.toJson();
    }
    if (channel != null) {
      data['channel'] = channel?.toJson();
    }
    if (area != null) {
      data['area'] = area?.toJson();
    }
    data['status'] = status;
    data['isUpdateAddress'] = isUpdateAddress;
    data['address'] = address;
    data['deliveryAddress'] = deliveryAddress;
    data['province'] = province;
    data['district'] = district;
    data['ward'] = ward;
    data['dob'] = dob;
    data['contactName'] = contactName;
    data['position'] = position;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['debtLimit'] = debtLimit;
    data['cashAcc'] = cashAcc;
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate;
    data['lastModifiedBy'] = lastModifiedBy;
    data['lastVisitBy'] = lastVisitBy;
    data['lastOrderBy'] = lastOrderBy;
    data['lastModifiedDate'] = lastModifiedDate;
    data['lastVisitTime'] = lastVisitTime;
    return data;
  }
}

class CustomerGroup {
  String? id;
  int? serial;
  String? customerGroupCode;
  String? customerGroupName;
  bool? deptLimit;
  bool? status;

  CustomerGroup(
      {this.id,
      this.serial,
      this.customerGroupCode,
      this.customerGroupName,
      this.deptLimit,
      this.status});

  CustomerGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    customerGroupCode = json['customerGroupCode'];
    customerGroupName = json['customerGroupName'];
    deptLimit = json['deptLimit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serial'] = serial;
    data['customerGroupCode'] = customerGroupCode;
    data['customerGroupName'] = customerGroupName;
    data['deptLimit'] = deptLimit;
    data['status'] = status;
    return data;
  }
}

class CustomerType {
  String? id;
  int? serial;
  String? customerTypeCode;
  String? customerTypeName;
  int? miniumCheckinTime;
  String? compulsoryPhotography;
  String? mandatoryInventoryRecord;
  bool? deptLimit;
  bool? status;

  CustomerType(
      {this.id,
      this.serial,
      this.customerTypeCode,
      this.customerTypeName,
      this.miniumCheckinTime,
      this.compulsoryPhotography,
      this.mandatoryInventoryRecord,
      this.deptLimit,
      this.status});

  CustomerType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    customerTypeCode = json['customerTypeCode'];
    customerTypeName = json['customerTypeName'];
    miniumCheckinTime = json['miniumCheckinTime'];
    compulsoryPhotography = json['compulsoryPhotography'];
    mandatoryInventoryRecord = json['mandatoryInventoryRecord'];
    deptLimit = json['deptLimit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serial'] = serial;
    data['customerTypeCode'] = customerTypeCode;
    data['customerTypeName'] = customerTypeName;
    data['miniumCheckinTime'] = miniumCheckinTime;
    data['compulsoryPhotography'] = compulsoryPhotography;
    data['mandatoryInventoryRecord'] = mandatoryInventoryRecord;
    data['deptLimit'] = deptLimit;
    data['status'] = status;
    return data;
  }
}

class Channel {
  String? id;
  int? serial;
  String? channelCode;
  String? channelName;
  bool? deptLimit;
  bool? status;

  Channel(
      {this.id,
      this.serial,
      this.channelCode,
      this.channelName,
      this.deptLimit,
      this.status});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    channelCode = json['channelCode'];
    channelName = json['channelName'];
    deptLimit = json['deptLimit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serial'] = serial;
    data['channelCode'] = channelCode;
    data['channelName'] = channelName;
    data['deptLimit'] = deptLimit;
    data['status'] = status;
    return data;
  }
}

class Area {
  String? id;
  int? serial;
  String? areaCode;
  String? areaName;
  String? fatherArea;
  bool? deptLimit;
  bool? status;

  Area(
      {this.id,
      this.serial,
      this.areaCode,
      this.areaName,
      this.fatherArea,
      this.deptLimit,
      this.status});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    areaCode = json['areaCode'];
    areaName = json['areaName'];
    fatherArea = json['fatherArea'];
    deptLimit = json['deptLimit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['serial'] = serial;
    data['areaCode'] = areaCode;
    data['areaName'] = areaName;
    data['fatherArea'] = fatherArea;
    data['deptLimit'] = deptLimit;
    data['status'] = status;
    return data;
  }
}
