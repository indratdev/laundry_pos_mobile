import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';

class TransactionConfirmationPage extends StatefulWidget {
  const TransactionConfirmationPage({
    super.key,
    required this.selectedCustomer,
    required this.orderUser,
  });

  final Customer? selectedCustomer;
  final OrderRequestModel? orderUser;

  @override
  State<TransactionConfirmationPage> createState() =>
      _TransactionConfirmationPageState();
}

class _TransactionConfirmationPageState
    extends State<TransactionConfirmationPage> {
  Set<OrderItem> displayedOrderItem = <OrderItem>{};

  @override
  void initState() {
    // print(">>> init jalan");

    // for (var element in widget.orderUser!.orderItems) {
    //   print(element.product.toMap());
    // }

    beforreee();

    super.initState();
  }

  // beforreee() {
  //   Set<OrderItem> setOrderItem = <OrderItem>{};

  //   for (var element in widget.orderUser!.orderItems) {
  //     print(">>> element : ${element.product.name}");
  //     if (!setOrderItem.contains(element.product.name)) {
  //       setOrderItem.add(element);
  //     }
  //   }

  //   displayedOrderItem = setOrderItem;
  //   print(">>>>>>");
  //   print(displayedOrderItem);
  // }

  beforreee() {
    Set<OrderItem> setOrderItem = <OrderItem>{};

    for (var element in widget.orderUser!.orderItems) {
      print(">>> element : ${element.product.name}");
      if (!setOrderItem.any((item) => item.product == element.product)) {
        setOrderItem.add(element);
      }
    }

    displayedOrderItem = setOrderItem;
    print(">>>>>>");
    print(displayedOrderItem);
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
                color: AppColors.card.withOpacity(.8),
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
                      Text("Nama Pelanggan"),
                      Text(widget.selectedCustomer?.name ?? ""),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Alamat  "),
                      Text(widget.selectedCustomer?.address ?? ""),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Telepon  "),
                      Text(widget.selectedCustomer?.phone ?? ""),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Email  "),
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
                    // itemCount: widget.orderUser?.orderItems.length ?? 0,
                    itemCount: displayedOrderItem.length,
                    itemBuilder: (context, index) {
                      // OrderItem? item = widget.orderUser?.orderItems[index];
                      // int count = widget.orderUser!.orderItems
                      //     .where((product) =>
                      //         product.product.name ==
                      //         widget.orderUser!.orderItems[index].product.name)
                      //     .length;
                      OrderItem? item = displayedOrderItem.toList()[index];
                      int count = displayedOrderItem
                          .toList()
                          .where((product) =>
                              product.product.name == item.product.name)
                          .length;

                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            // color: Colors.red,
                            width: MediaQuery.sizeOf(context).width / 2,
                            child: Text(item.product.name),
                          ),
                          Container(
                            // color: Colors.yellow,
                            width: MediaQuery.sizeOf(context).width / 8,
                            child: Text("x $count"),
                          ),
                          // const Spacer(),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              // color: Colors.yellow,
                              // width: MediaQuery.sizeOf(context).width / 4,
                              child: Text(
                                  "Rp. ${item?.product.price.toString() ?? ""}"),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Divider(color: AppColors.disabled),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Total : Rp. 545.000,00",
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
