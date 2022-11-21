class AlbumResponse {
  AlbumResponse({
    required this.data,
  });
  late final List<AlbumResponseData> data;

  AlbumResponse.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => AlbumResponseData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AlbumResponseData {
  AlbumResponseData({
    required this.id,
    required this.serial,
    required this.albumCode,
    required this.albumName,
    required this.deptLimit,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.lastModifiedBy,
    required this.lastModifiedDate,
  });
  late final String? id;
  late final String? serial;
  late final String? albumCode;
  late final String? albumName;
  late final bool? deptLimit;
  late final bool? status;
  late final String? createdBy;
  late final String? createdDate;
  late final String? lastModifiedBy;
  late final String? lastModifiedDate;

  AlbumResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serial = json['serial'];
    albumCode = json['albumCode'];
    albumName = json['albumName'];
    deptLimit = json['deptLimit'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    lastModifiedBy = json['lastModifiedBy'];
    lastModifiedDate = json['lastModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['serial'] = serial;
    _data['albumCode'] = albumCode;
    _data['albumName'] = albumName;
    _data['deptLimit'] = deptLimit;
    _data['status'] = status;
    _data['createdBy'] = createdBy;
    _data['createdDate'] = createdDate;
    _data['lastModifiedBy'] = lastModifiedBy;
    _data['lastModifiedDate'] = lastModifiedDate;
    return _data;
  }
}
