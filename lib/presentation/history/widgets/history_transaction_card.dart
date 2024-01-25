import 'package:flutter/material.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/core/extensions/string_ext.dart';
import 'package:laundry_app/data/models/response/history_response_model.dart';

import '../../../core/constants/colors.dart';

class HistoryTransactionCard extends StatelessWidget {
  // final OrderResponseModel data;
  final HistoryData data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({
    super.key,
    required this.data,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 48.0,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            color: AppColors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: ListTile(
        leading: const Icon(Icons.payment),
        title: Text(data.paymentMethod.toUpperCase()),
        subtitle: Text('${data.totalQuantity} items'),
        trailing: Text(
          data.totalPrice.toDoubleFromText.currencyFormatRp,
          style: const TextStyle(
            color: AppColors.green,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
