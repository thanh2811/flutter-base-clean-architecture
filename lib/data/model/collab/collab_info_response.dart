// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class CollaboratorInfo extends Equatable {
  String? id;
  String? memberLogin;
  String? referralCode;
  String? fullname;
  String? email;
  String? mobile;
  String? dateOfBirth;
  String? permanentAddress;
  String? address;
  String? taxCode;
  String? citizenIdentityCard;
  String? dateOfIssue;
  String? placeOfIssue;
  String? image1;
  String? image2;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? type;
  String? requestedTime;
  String? status;
  bool? locked;
  String? check;

  CollaboratorInfo(
      {this.id,
      this.memberLogin,
      this.referralCode,
      this.fullname,
      this.email,
      this.mobile,
      this.dateOfBirth,
      this.permanentAddress,
      this.address,
      this.taxCode,
      this.citizenIdentityCard,
      this.dateOfIssue,
      this.placeOfIssue,
      this.image1,
      this.image2,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.type,
      this.requestedTime,
      this.status,
      this.locked,
      this.check});

  CollaboratorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberLogin = json['memberLogin'];
    referralCode = json['referralCode'];
    fullname = json['fullname'];
    email = json['email'];
    mobile = json['mobile'];
    dateOfBirth = json['dateOfBirth'];
    permanentAddress = json['permanentAddress'];
    address = json['address'];
    taxCode = json['taxCode'];
    citizenIdentityCard = json['citizenIdentityCard'];
    dateOfIssue = json['dateOfIssue'];
    placeOfIssue = json['placeOfIssue'];
    image1 = json['image1'];
    image2 = json['image2'];
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    type = json['type'];
    requestedTime = json['requestedTime'];
    status = json['status'];
    locked = json['locked'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['memberLogin'] = memberLogin;
    data['referralCode'] = referralCode;
    data['fullname'] = fullname;
    data['email'] = email;
    data['mobile'] = mobile;
    data['dateOfBirth'] = dateOfBirth;
    data['permanentAddress'] = permanentAddress;
    data['address'] = address;
    data['taxCode'] = taxCode;
    data['citizenIdentityCard'] = citizenIdentityCard;
    data['dateOfIssue'] = dateOfIssue;
    data['placeOfIssue'] = placeOfIssue;
    data['image1'] = image1;
    data['image2'] = image2;
    data['accountName'] = accountName;
    data['accountNumber'] = accountNumber;
    data['bankName'] = bankName;
    data['type'] = type;
    data['requestedTime'] = requestedTime;
    data['status'] = status;
    data['locked'] = locked;
    data['check'] = check;
    return data;
  }

  @override
  List<Object?> get props => [id, memberLogin];
}
