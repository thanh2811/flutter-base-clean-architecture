import 'package:intl/intl.dart';

class ValidationUtils {
  static String formatMoney(double money) {
    try {
      var moneyFormat = NumberFormat('#,###');
      return moneyFormat.format(money).toString();
    } catch (e) {
      return money.toString();
    }
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
}
