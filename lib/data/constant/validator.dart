class AppValidator{
  static String? textEmptyValidator(
      String? text,
      ) {
    if (text == null || text.isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }
}