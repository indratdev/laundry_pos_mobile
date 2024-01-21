import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart';
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

    // set grand total
    widget.orderUser?.totalPrice = grandTotal(widget.orderUser!.orderItems);
    widget.orderUser?.totalQuantity = widget.orderUser?.orderItems.length ?? 0;

    _finalOrder();
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
        child: Column(
          children: [
            // pelanggan
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.card.withOpacity(1),
              ),
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              // color: Colors.amber,
              // height: MediaQuery.sizeOf(context).height / 6.5,
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
              // color: Colors.blue,
              // height: MediaQuery.sizeOf(context).height / 2,
              // margin: EdgeInsets.symmetric(horizontal: 8),
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
                            child: Text("x ${item.quantity}"),
                          ),
                          // const Spacer(),
                          Expanded(
                            child: Container(
                                alignment: Alignment.centerRight,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                // color: Colors.yellow,
                                // width: MediaQuery.sizeOf(context).width / 4,
                                child: Text(priceProduct(item.quantity,
                                        item.product.price.toDouble())
                                    .currencyFormatRp)),
                          )
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
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
