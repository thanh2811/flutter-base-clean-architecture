import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static String formatDate(String strDate) {
    try {
      var dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.format(DateTime.parse(strDate)).toString();
    } catch (e) {
      return strDate;
    }
  }

  static String formatTime(TimeOfDay strTime) {
    return "${strTime.hour}:${strTime.minute}";
  }

  static String toStringIsoDate(String strDate) {
    try {
      var dateFormat = DateFormat('dd/MM/yyyy');
      var dateFormatIso = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      return dateFormatIso.format(dateFormat.parse(strDate));
    } catch (e) {
      log(e.toString());
      return strDate;
    }
  }

  static String toStringIsoDateTime(String strDate) {
    try {
      var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      var dateFormatIso = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      return dateFormatIso.format(dateFormat.parse(strDate));
    } catch (e) {
      log(e.toString());
      return strDate;
    }
  }

  static String getDateTimeNowIso() {
    var dateFormatIso = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    return dateFormatIso.format(DateTime.now()).toString();
  }

  static String secondToTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds - hours * 3600) ~/ 60;
    int secondMods = seconds - hours * 3600 - minutes * 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secondMods.toString().padLeft(2, '0')}';
  }

  static bool isToday(String strDateTime) {
    if (strDateTime.isEmpty) return false;
    try {
      final now = DateTime.now();
      final dateTime = DateTime.parse(strDateTime);
      final diff = DateTime(dateTime.year, dateTime.month, dateTime.day)
          .difference(DateTime(now.year, now.month, now.day));
      return diff.inMilliseconds == 0;
    } catch (e) {
      return false;
    }
  }

  static bool isSameDay(String strDate1, String strDate2) {
    if (strDate1.isEmpty || strDate2.isEmpty) return false;
    try {
      final date1 = DateTime.parse(strDate1);
      final date2 = DateTime.parse(strDate2);
      final diff = DateTime(date1.year, date1.month, date1.day)
          .difference(DateTime(date2.year, date2.month, date2.day));
      return diff.inMilliseconds == 0;
    } catch (e) {
      return false;
    }
  }

  static String formatMoney(double money) {
    try {
      var moneyFormat = NumberFormat('#,###');
      return moneyFormat.format(money).toString();
    } catch (e) {
      return money.toString();
    }
  }

  static String getDiffDate(DateTime time) {
    // try {
    final DateFormat formatDate = DateFormat('dd/MM/yyyy HH:mm');
    //   final date = DateTime.now();
    //   final duration = date.difference(time);
    //   if (duration.inDays > 0) {
    //     return formatDate.format(time);
    //   } else if (duration.inHours > 0) {
    //     return '${duration.inHours} giờ trước';
    //   } else if (duration.inMinutes > 0) {
    //     return '${duration.inMinutes} phút trước';
    //   } else {
    //     return 'Vừa xong';
    //   }
    // } catch (e) {
    return formatDate.format(time);
    //   }
  }

  static String? textEmptyValidator(
    String? text,
  ) {
    if (text == null || text.isEmpty || text.toString().trim().isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  static String intToHexadecimal(int value) {
    return "#${value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}";
  }

  // static launchUri(String uriPath, UriType uriType, {LaunchMode? mode}) async {
  //   final Uri uri;
  //   switch (uriType) {
  //     case UriType.phone:
  //       uri = Uri(
  //         scheme: 'tel',
  //         path: uriPath,
  //       );
  //       break;
  //     case UriType.email:
  //       uri = Uri(
  //         scheme: 'mailto',
  //         path: uriPath,
  //       );
  //       break;
  //     case UriType.website:
  //       uri = Uri.parse(uriPath);
  //       break;
  //     case UriType.zalo:
  //       uri = Uri(
  //         scheme: 'https://zalo.me/',
  //         path: uriPath,
  //       );
  //       break;
  //     case UriType.sms:
  //       uri = Uri(scheme: 'sms', path: uriPath);
  //   }

  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  //   } else {
  //     toastWarning('Không thể mở đường dẫn tới liên kết này');
  //   }
  // }
}
