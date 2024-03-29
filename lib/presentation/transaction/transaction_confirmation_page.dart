import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/data/datasource/auth_local_datasource.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart';
import 'package:laundry_app/data/models/response/auth_response_model.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';

class TransactionConfirmationPage extends StatefulWidget {
  final Customer? selectedCustomer;
  final OrderRequestModel? orderUser;
  final Function(OrderRequestModel) onConfirmationOrder;

  const TransactionConfirmationPage({
    super.key,
    required this.selectedCustomer,
    required this.orderUser,
    required this.onConfirmationOrder,
  });

  @override
  State<TransactionConfirmationPage> createState() =>
      _TransactionConfirmationPageState();
}

class _TransactionConfirmationPageState
    extends State<TransactionConfirmationPage> {
  // Set<OrderItem> displayedOrderItem = <OrderItem>{};
  List<OrderItem> displayedOrderItem = [];

  @override
  void initState() {
    initOrder();
    super.initState();
  }

  initOrder() {
    // Menggunakan Set untuk menyimpan data unik berdasarkan nama produk
    Set<String> uniqueProductNames = <String>{};
    Map<String, OrderItem> mergedData = {};

    for (OrderItem orderItem in widget.orderUser!.orderItems) {
      String productName = orderItem.product.name;

      if (uniqueProductNames.contains(productName)) {
        // Jika produk sudah ada, tambahkan quantity
        mergedData[productName]!.quantity += 1;
      } else {
        // Jika produk belum ada, tambahkan data baru ke dalam Map
        uniqueProductNames.add(productName);
        mergedData[productName] = orderItem;
        mergedData[productName]?.quantity = 1;
      }
    }

    // Hasil akhir
    List<OrderItem> result = mergedData.values.toList();
    displayedOrderItem = result;
    log(">>> displayedOrderItem : ${displayedOrderItem.toList()}");

    // set grand total
    widget.orderUser?.totalPrice = grandTotal(widget.orderUser!.orderItems);
    widget.orderUser?.totalQuantity = widget.orderUser?.orderItems.length ?? 0;

    fillCashierName();
    _finalOrder();
  }

  fillCashierName() async {
    AuthResponseModel autData = await AuthLocalDatasource().getAuthData();
    widget.orderUser?.cashierName = autData.user.name;
    widget.orderUser?.idCashier = autData.user.id;
  }

  double priceProduct(int total, double price) {
    return (total * price).toDouble();
  }

  double grandTotal(List<OrderItem> orders) {
    double total = 0.0;
    for (var order in orders) {
      total += order.product.price;
    }
    return total;
  }

  void _finalOrder() {
    widget.onConfirmationOrder(widget.orderUser!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            children: [
              // pelanggan
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.card.withOpacity(.8),
                ),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                child: ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Nama Pelanggan"),
                        Text(widget.selectedCustomer?.name ?? ""),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Alamat  "),
                        Text(widget.selectedCustomer?.address ?? ""),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Telepon  "),
                        Text(widget.selectedCustomer?.phone ?? ""),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("Email  "),
                        Text(widget.selectedCustomer?.email ?? ""),
                      ],
                    ),
                  ],
                ),
              ),
              // detail order
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: displayedOrderItem.length,
                      itemBuilder: (context, index) {
                        OrderItem item = displayedOrderItem[index];
                        String unit =
                            (item.product.category == "kiloan") ? "Kg" : "pcs";

                        return Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              // color: Colors.red,
                              width: MediaQuery.sizeOf(context).width / 2,
                              child: Text(item.product.name),
                            ),
                            SizedBox(
                              // color: Colors.yellow,
                              width: MediaQuery.sizeOf(context).width / 8,
                              child: Text("x ${item.quantity} $unit"),
                            ),
                            // const Spacer(),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(priceProduct(
                                    item.quantity,
                                    item.product.price.toDouble(),
                                  ).currencyFormatRp)),
                            ),
                          ],
                        );
                      },
                    ),
                    const Divider(color: AppColors.disabled),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Total :  ${grandTotal(widget.orderUser!.orderItems).currencyFormatRp}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
