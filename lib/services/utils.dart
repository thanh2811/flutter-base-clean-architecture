import 'dart:developer';

import 'package:intl/intl.dart';

class Utils {
  static String formatDate(String strDate) {
    try {
      var dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.format(DateTime.parse(strDate)).toString();
    } catch (e) {
      return strDate;
    }
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
      final diff = dateTime.difference(DateTime(now.year, now.month, now.day));

      return diff.inMilliseconds > 0 &&
          diff.inMilliseconds < 24 * 60 * 60 * 1000;
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
}
