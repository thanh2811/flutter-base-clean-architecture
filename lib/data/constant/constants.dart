import 'package:flutter/material.dart';

enum UIState {
  init,
  loading,
  loaded,
  success,
  error,
  end;
}

class OrderTime {
  static const all = 'Chọn thời gian';
  static const today = 'Hôm nay';
  static const thisWeek = 'Tuần này';
  static const thisMonth = 'Tháng này';
  static const lastMonth = 'Tháng trước';
  static const list = [all, today, thisWeek, thisMonth, lastMonth];
}

class OrderType {
  static const purchaseOrder = 'Phiếu đặt hàng';
  static const saleReceipt = 'Phiếu bán hàng';
  static const list = [purchaseOrder, saleReceipt];
}

class ReportTime {
  static const today = 'Hôm nay';
  static const thisMonth = 'Tháng này';
  static const lastMonth = 'Tháng trước';
  static const previousMonth = 'Tháng trước nữa';
  static const custom = 'Tùy chọn thời gian';
  static const list = [today, thisMonth, lastMonth, previousMonth, custom];
}

class TimekeepingTime {
  static const thisMonth = 'Tháng này';
  static const lastMonth = 'Tháng trước';
  static const previousMonth = 'Tháng trước nữa';
  static const list = [thisMonth, lastMonth, previousMonth];
}

class OrderStatus {
  static const all = 'Tất cả trạng thái';
  static const pending = 'Chờ duyệt';
  static const approved = 'Đã duyệt';
  static const sold = 'Đã bán hàng';
  static const shipped = 'Đã xuất hàng';
  static const rejected = 'Từ chối';
  static const returned = 'Đã nhập trả';
  static const list = [
    all,
    pending,
    approved,
    sold,
    shipped,
    rejected,
    returned
  ];
  static List<Color> listColor = [
    Colors.white,
    Colors.orange,
    Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.greenAccent
  ];
}

class CollaboratorState {
  static const String stateNull = "null";
  static const String stateNew = "new";
  static const String stateMemberApproved = "member_approved";
  static const String stateMemberRejected = "member_rejected";
  static const String stateApproved = "approved"; //stt admin vừa mới chấp nhận
  static const String stateRejected = "rejected"; //stt admin vừa mới từ chối
}

class ReportType {
  static const String saleReceipt = "sale_receipt";
  static const String purchaseOrder = "purchase_order";
}

class SharedPreferenceKey {
  static const String xLicenseKey = "xLicenseKey";
  static const String idToken = "idToken";
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String username = "username";
  static const String password = "password";
  static const String rememberMe = "rememberMe";
  static const String userId = "userId";
}
