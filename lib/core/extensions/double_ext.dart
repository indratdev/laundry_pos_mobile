import 'package:intl/intl.dart';

extension DoubleExt on double {
  String get currencyFormatRp => NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp. ',
        decimalDigits: 0,
      ).format(this);

  // String doubleToCurrency1(double amount) {
  //   var formatter =
  //       NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
  //   return formatter.format(amount);
  // }

  // String get doubleToCurrency {
  //   var formatter =
  //       NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
  //   return formatter.format(this);
  // }
}
