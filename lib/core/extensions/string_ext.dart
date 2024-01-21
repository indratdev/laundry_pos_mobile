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

  //  String get currencyFormatRp => NumberFormat.currency(
  //       locale: 'id',
  //       symbol: 'Rp. ',
  //       decimalDigits: 0,
  //     ).format(this);
  // String get currencyFormatRp {
  //   if (isEmpty) {
  //     return '0';
  //   }
  //   return NumberFormat.currency(
  //     locale: 'id',
  //     // symbol: 'Rp. ',
  //     decimalDigits: 0,
  //   ).format(this);
  // }

  NumberFormat get currencyFormatRp => NumberFormat.decimalPatternDigits(
        locale: 'id',
        decimalDigits: 0,
      );
}
