class UserSSOResponse {
  String? accessToken;
  String? refreshToken;
  UserSSODataResponse? user;

  UserSSOResponse({this.accessToken, this.refreshToken, this.user});

  UserSSOResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null
        ? UserSSODataResponse.fromJson(json['user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserSSODataResponse {
  bool? isGuest;
  bool? iapLock;
  bool? emailIsVerified;
  bool? phoneIsVerified;
  int? coin;
  String? username;
  String? idString;
  String? displayName;
  String? birthday;
  String? avatar;
  String? email;
  String? phone;
  String? deviceID;
  String? idCard;
  String? lastLoginAt;
  String? region;
  String? address;
  String? postalCode;
  String? country;
  String? platformOS;
  String? pushId;

  UserSSODataResponse(
      {this.isGuest,
      this.iapLock,
      this.emailIsVerified,
      this.phoneIsVerified,
      this.coin,
      this.username,
      this.idString,
      this.displayName,
      this.birthday,
      this.avatar,
      this.email,
      this.phone,
      this.deviceID,
      this.idCard,
      this.lastLoginAt,
      this.region,
      this.address,
      this.postalCode,
      this.country,
      this.platformOS,
      this.pushId});

  UserSSODataResponse.fromJson(Map<String, dynamic> json) {
    isGuest = json['isGuest'];
    iapLock = json['iapLock'];
    emailIsVerified = json['emailIsVerified'];
    phoneIsVerified = json['phoneIsVerified'];
    coin = json['coin'];
    username = json['username'];
    idString = json['idString'];
    displayName = json['displayName'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    deviceID = json['deviceID'];
    idCard = json['idCard'];
    lastLoginAt = json['lastLoginAt'];
    region = json['region'];
    address = json['address'];
    postalCode = json['postalCode'];
    country = json['country'];
    platformOS = json['platformOS'];
    pushId = json['pushId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isGuest'] = isGuest;
    data['iapLock'] = iapLock;
    data['emailIsVerified'] = emailIsVerified;
    data['phoneIsVerified'] = phoneIsVerified;
    data['coin'] = coin;
    data['username'] = username;
    data['idString'] = idString;
    data['displayName'] = displayName;
    data['birthday'] = birthday;
    data['avatar'] = avatar;
    data['email'] = email;
    data['phone'] = phone;
    data['deviceID'] = deviceID;
    data['idCard'] = idCard;
    data['lastLoginAt'] = lastLoginAt;
    data['region'] = region;
    data['address'] = address;
    data['postalCode'] = postalCode;
    data['country'] = country;
    data['platformOS'] = platformOS;
    data['pushId'] = pushId;
    return data;
  }
}
