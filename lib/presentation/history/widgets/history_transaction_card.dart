import 'package:flutter/material.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/data/models/response/order_response_model.dart';

import '../../../core/constants/colors.dart';

class HistoryTransactionCard extends StatelessWidget {
  final OrderResponseModel data;
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
        leading: Icon(Icons.payment),
        title: Text(data.data.order.payment_method),
        subtitle: Text('${data.data.order.total_quantity} items'),
        trailing: Text(
          data.data.order.total_price.currencyFormatRp,
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
