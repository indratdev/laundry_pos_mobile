import 'package:flutter/material.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/core/extensions/string_ext.dart';
import 'package:laundry_app/data/models/response/history_response_model.dart';
import 'package:laundry_app/presentation/history/history_detail_page.dart';

import '../../../core/constants/colors.dart';

class HistoryTransactionCard extends StatelessWidget {
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
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey),
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
      child: InkWell(
        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailPage(selectedCustomer: selectedCustomer, orderUser: orderUser, onConfirmationOrder: onConfirmationOrder),)),
        child: ListTile(
          leading: const Icon(Icons.payment),
          title: Text(data.customers.name),
          subtitle: Text(
              '${data.totalQuantity} items | ${data.paymentMethod.toUpperCase()}'),
          trailing: Text(
            data.totalPrice.currencyFormatRpFromString,
            style: const TextStyle(
              color: AppColors.green,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
