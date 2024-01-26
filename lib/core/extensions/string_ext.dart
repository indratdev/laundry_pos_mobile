import 'package:intl/intl.dart';

extension StringExt on String {
  int get toIntegerFromText {
    final cleanedText = replaceAll(RegExp(r'[^0-9]'), '');
    final parsedValue = int.tryParse(cleanedText) ?? 0;
    return parsedValue;
  }

  double get toDoubleFromText {
    final cleanedText = replaceAll(RegExp(r'[^0-9]'), '');
    final parsedValue = double.tryParse(cleanedText) ?? 0.0;
    return parsedValue;
  }

  String get currencyFormatRpFromString {
    if (isEmpty) {
      return '0';
    }

    // Parse the string as a double
    double value = double.tryParse(this) ?? 0;

    // Use the isNegative property on the double
    if (value.isNegative) {
      return '- ${NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(value.abs())}';
    }

    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(value);
  }

  NumberFormat get currencyFormatRp => NumberFormat.decimalPatternDigits(
        locale: 'id',
        decimalDigits: 0,
      );
}
