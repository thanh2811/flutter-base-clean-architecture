extension StringExtension on String {
  String toCapitalized() => length > 0
      ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}}"
      : '';

  String toTitleFormat() =>
      replaceAll(' +', ' ').split(' ').map((str) => toCapitalized()).join(' ');
}
