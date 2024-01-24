import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';

import 'package:laundry_app/data/models/request/order_request_model.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';
import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:laundry_app/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:laundry_app/presentation/transaction/transaction_confirmation_page.dart';
import 'package:laundry_app/presentation/transaction/transaction_customer_page.dart';
import 'package:laundry_app/presentation/transaction/widgets/dialog_payment_method_widget.dart';
import 'package:laundry_app/presentation/transaction/widgets/payment_success_dialog.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _pageController = PageController(viewportFraction: 1.0);

  int step = 1;
  List<dynamic> stepTransaction = [
    "Pelanggan",
    "Layanan",
    "Konfirmasi Layanan"
  ];

  Customer? selectedCustomer;
  OrderRequestModel? orderUser = OrderRequestModel(
    customer: Customer(name: ""),
    orderItems: [],
    cashierName: "",
    paymentMethod: "",
  );

  List<OrderItem>? orderItem = [];

  void nextPage() {
    // Check if PageView is built with _pageController
    if (_pageController.positions.isNotEmpty) {
      _pageController.animateToPage(
        _pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }

    if (orderItem != null || (orderItem?.length ?? 0) > 0) {
      orderUser?.orderItems = orderItem!;
    }

    setState(() {
      if (step != stepTransaction.length) {
        step += 1;
      }
    });
  }

  void previousPage() {
    print(">> page previous :: ${_pageController.page?.toInt()}");
    // Check if PageView is built with _pageController
    if (_pageController.positions.isNotEmpty) {
      _pageController.animateToPage(
        (_pageController.page!.toInt() - 1)
            .clamp(0, stepTransaction.length - 1),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
    setState(() {
      step -= 1;
    });
  }

  int checkQuantity(Product product) {
    int count = 0;

    if (orderUser?.orderItems != null) {
      for (var item in orderItem!) {
        if (item.product.id == product.id) {
          count += 1;
        }
      }
    }

    return count;
  }

  addItem(Product product) {
    orderUser?.orderItems
        .add(OrderItem(product: product, productID: product.id!));
  }

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Pilihan Pembayaran'),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (orderUser?.paymentMethod == "cash")
                        ? AppColors.yellow
                        : null,
                  ),
                  child: const Text("Tunai"),
                  onPressed: () {
                    setState(() {
                      orderUser?.paymentMethod = "cash";
                      print(">>> paymentMethod : ${orderUser?.paymentMethod}");
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (orderUser?.paymentMethod == "qris")
                        ? AppColors.yellow
                        : null,
                  ),
                  child: Text("QRIS"),
                  onPressed: () {
                    setState(() {
                      orderUser?.paymentMethod = "qris";
                      print(">>> paymentMethod : ${orderUser?.paymentMethod}");
                    });
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void showBottomSheetPayment(BuildContext context, OrderRequestModel order) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Tunai'),
              onTap: () {
                // Handle tunai option
                order.paymentMethod = PaymentMethod.cash.name.toString();
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) =>
                        DialogPaymentMethodWidget(orderUser: order));
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('QRIS'),
              onTap: () {
                // Handle QRIS option
                order.paymentMethod = PaymentMethod.qris.name.toString();
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) =>
                        DialogPaymentMethodWidget(orderUser: order));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.sizeOf(context).width / 13;

    List<Widget> listTransactionStep = [
      TransactionCustomerPage(
        selectedCustomer: selectedCustomer,
        onCustomerSelected: (value) {
          setState(() {
            selectedCustomer = value;
            orderUser?.customer = value;
            orderUser?.customerID = value.id ?? 0;
          });
        },
      ),
      BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            success: (products) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  int quantity = checkQuantity(product);
                  return Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(product.category),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: iconSize,
                            onPressed: () {
                              // NEW FUNCTION
                              if (orderUser?.orderItems != null) {
                                // Menentukan indeks elemen yang ingin dihapus (misalnya, indeks pertama)
                                int indexToRemove = orderUser!.orderItems
                                    .indexWhere((element) =>
                                        element.product.id == product.id);
                                // Menghapus elemen pada indeks yang ditemukan
                                if (indexToRemove != -1) {
                                  orderUser!.orderItems.removeAt(indexToRemove);
                                }
                              }

                              setState(() {});
                            },
                            icon:
                                const Icon(Icons.remove_circle_outline_rounded),
                          ),
                          Text(
                            "$quantity  ${(product.category == 'satuan') ? "pcs" : "Kg"}",
                            style: TextStyle(fontSize: iconSize / 1.8),
                          ),
                          IconButton(
                            iconSize: iconSize,
                            onPressed: () {
                              addItem(product);

                              setState(() {});
                            },
                            icon: const Icon(Icons.add_circle_outline_rounded),
                          )
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      TransactionConfirmationPage(
        selectedCustomer: selectedCustomer,
        orderUser: orderUser,
        onConfirmationOrder: (value) {
          orderUser = value;
        },
      ),
    ];

    return Scaffold(
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          state.maybeWhen(
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (message) {
              log(">>> blocbuilder error : $message");
            },
            success: (orderResponseModel) {
              Future.delayed(Duration.zero, () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      PaymentSuccessDialog(paymentMethod: PaymentMethod.cash),
                );
              });
            },
          );
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: MediaQuery.sizeOf(context).height / 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 5,
                      margin: const EdgeInsets.all(12),
                      child: CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: MediaQuery.sizeOf(context).width / 9.5,
                        lineWidth: MediaQuery.sizeOf(context).width / 35,
                        percent: step / stepTransaction.length,
                        center: Text(
                          "$step of ${stepTransaction.length}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        progressColor: AppColors.green,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      width: MediaQuery.sizeOf(context).width / 1.6,
                      child: Column(
                        mainAxisAlignment: (step == stepTransaction.length)
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih ${stepTransaction[step - 1]}",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          (step == stepTransaction.length)
                              ? const SizedBox()
                              : Text("Selanjutnya : ${stepTransaction[step]}"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Badge(
                          label: Text("${orderUser?.orderItems.length ?? 0}"),
                          child: const Icon(Icons.shopping_cart_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.zero,
                  child: PageView(
                    controller: _pageController,
                    padEnds: false,
                    pageSnapping: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: listTransactionStep,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 3,
              child: TextButton(
                onPressed: (step == 1)
                    ? () => Navigator.pop(context)
                    : () => previousPage(),
                // child: (step == 1)
                //     ? const Text("Kembali")
                //     : const Text('Previous'),
                child: const Text("Kembali"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                color: AppColors.middleBlueColor,
                child: TextButton(
                  onPressed: () async {
                    (step == stepTransaction.length)
                        ? showBottomSheetPayment(context, orderUser!)
                        : nextPage();
                  },
                  child: Text(
                    (step == stepTransaction.length) ? 'Proses' : 'Lanjut',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
