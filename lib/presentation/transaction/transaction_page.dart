import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';

import 'package:laundry_app/data/models/request/order_request_model.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';
import 'package:laundry_app/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:laundry_app/presentation/transaction/transaction_confirmation_page.dart';
import 'package:laundry_app/presentation/transaction/transaction_customer_page.dart';
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
      nameCashier: "",
      paymentMethod: "");

  List<OrderItem>? orderItem = [];

  void nextPage() {
    print(">> page next :: ${_pageController.page?.toInt()}");
    // Check if PageView is built with _pageController
    if (_pageController.positions.isNotEmpty) {
      _pageController.animateToPage(
        _pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }

    print(">>> orderUser?.orderItems : ${orderUser?.orderItems.length}");
    print(">>> orderItems : ${orderItem?.length}");

    if (orderItem != null || (orderItem?.length ?? 0) > 0) {
      print(">>>> jalan dong");
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

  // addOrRemoveOrder(int productId, Product product, bool isIncrement) {
  //   OrderItem? foundOrderItem = orderUser?.orderItems.firstWhere(
  //     (orderItem) => orderItem.product.id == productId,
  //     // orElse: () => null,
  //   );

  //   // OrderItem? foundOrderItem = orderItem?.firstWhere(
  //   //   (element) => element.product.id == productId,
  //   //   orElse: () => null,
  //   // );

  //   if (foundOrderItem != null) {
  //     // OrderItem ditemukan, Anda dapat mengakses atau melakukan sesuatu dengan objek ini
  //     print(
  //         "Found OrderItem: ${foundOrderItem.product.name}, Quantity: ${foundOrderItem.quantity}");
  //   } else {
  //     // OrderItem tidak ditemukan
  //     print("OrderItem not found for product ID $productId");
  //     if (isIncrement) {
  //       print(">>> ini jalan");
  //       // orderUser?.orderItems.add(OrderItem(
  //       //     product: product, quantity: 1, price: product.price.toDouble()));
  //     }
  //     print(">>> data baru");
  //     print(">>> ${orderUser?.orderItems.length}");
  //     print(">>> ${orderUser?.orderItems.first.product}");
  //   }
  // }

  // int checkQuantity(Product product) {
  //   OrderItem? result =
  //       orderItem?.where((element) => element.product.id == product.id).first;
  //   return result?.quantity ?? 0;
  // }
  // int checkQuantity(Product product) {
  //   OrderItem? result;
  //   print(">>> orderItem : ${orderItem?.length}");
  //   if (orderItem?.length != 0) {
  //     result = orderItem?.firstWhere(
  //       (value) => value.product.id == product.id,
  //       // orElse: () => null,
  //     );
  //   }

  //   return result?.quantity ?? 0;
  // }

  // OLD
  // int checkQuantity(Product product) {
  //   print("M=== ${product.name}  ============");
  //   int count = 0;

  //   if (orderItem != null) {
  //     for (var item in orderItem!) {
  //       if (item.product.id == product.id) {
  //         count += 1;
  //       }
  //     }
  //   }
  //   print("end===============");
  //   return count;
  // }

  int checkQuantity(Product product) {
    print("M=== ${product.name}  ============");
    int count = 0;

    if (orderUser?.orderItems != null) {
      for (var item in orderItem!) {
        if (item.product.id == product.id) {
          count += 1;
        }
      }
    }
    print("end===============");
    return count;
  }

  addItem(Product product) {
    print(">>> addItem runingg...");

    orderUser?.orderItems.add(OrderItem(product: product));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listTransactionStep = [
      TransactionCustomerPage(
        selectedCustomer: selectedCustomer,
        onCustomerSelected: (value) {
          setState(() {
            selectedCustomer = value;
            orderUser?.customer = value;
          });
        },
      ),
      Container(
        child: BlocBuilder<ProductBloc, ProductState>(
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  print(">>> kurangin ${product.id} ");

                                  // OLD FUNCTION ------------------
                                  // if (orderItem != null) {
                                  //   // Menentukan indeks elemen yang ingin dihapus (misalnya, indeks pertama)
                                  //   int indexToRemove = orderItem!.indexWhere(
                                  //       (element) =>
                                  //           element.product.id == product.id);
                                  //   // Menghapus elemen pada indeks yang ditemukan
                                  //   if (indexToRemove != -1) {
                                  //     orderItem!.removeAt(indexToRemove);
                                  //   }
                                  // }

                                  // setState(() {
                                  //   if (orderItem != null) {
                                  //     for (var element in orderItem!) {
                                  //       print(element.product.toMap());
                                  //     }
                                  //   }
                                  // });

                                  // NEW FUNCTION
                                  if (orderUser?.orderItems != null) {
                                    // Menentukan indeks elemen yang ingin dihapus (misalnya, indeks pertama)
                                    int indexToRemove = orderUser!.orderItems
                                        .indexWhere((element) =>
                                            element.product.id == product.id);
                                    // Menghapus elemen pada indeks yang ditemukan
                                    if (indexToRemove != -1) {
                                      orderUser!.orderItems
                                          .removeAt(indexToRemove);
                                    }
                                  }

                                  setState(() {
                                    // if (orderUser?.orderItems != null) {
                                    //   for (var element in orderItem!) {
                                    //     print(element.product.toMap());
                                    //   }
                                    // }
                                  });
                                },
                                icon: Icon(Icons.remove_circle_outline_rounded),
                              ),
                              Text(
                                  // "${orderItem?.firstWhere((element) => element.product.id == product.id)}  ${(product.category == 'satuan') ? "pcs" : "Kg"}"),
                                  "$quantity  ${(product.category == 'satuan') ? "pcs" : "Kg"}"),
                              // "00"),

                              IconButton(
                                onPressed: () {
                                  print(">>> tambahin ");
                                  // print(product.toMap());
                                  // addOrRemoveOrder(
                                  //     product.id!.toInt(), product, true);
                                  // // Assuming the product is part of the orderItems list in the OrderRequestModel
                                  // int index = orderUser?.orderItems.indexWhere(
                                  //         (item) =>
                                  //             item.product.id == product.id) ??
                                  //     -1;
                                  // if (index != -1) {
                                  //   setState(() {
                                  //     orderUser!.orderItems[index].quantity +=
                                  //         1;
                                  //   });
                                  // }

                                  // orderItem!.add(OrderItem(product: product));

                                  // print(">>> prodcut ::: ${product.toMap()}");

                                  addItem(product);

                                  setState(() {
                                    print(
                                        ">>> orderUser?.orderItems ::: ${orderUser?.orderItems.length}");
                                    if (orderUser?.orderItems != null) {
                                      for (var element in orderItem!) {
                                        print(element.product.toMap());
                                      }
                                    }
                                  });
                                },
                                icon: Icon(Icons.add_circle_outline_rounded),
                              )
                            ],
                          ),
                        ),
                      ],
                    );

                    // return Row(
                    //   children: [
                    //     Expanded(
                    //       child: ListTile(
                    //         title: Text(product.name),
                    //         subtitle: Text(product.category),
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Container(
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         // crossAxisAlignment:
                    //         //     CrossAxisAlignment.center,
                    //         children: [
                    //           IconButton(
                    //             onPressed: () {},
                    //             icon: Icon(Icons.remove_circle_outline_rounded),
                    //           ),
                    //           Text(
                    //               "0 ${(product.category == 'satuan') ? "pcs" : "Kg"}"),
                    //           IconButton(
                    //             onPressed: () {},
                    //             icon: Icon(Icons.add_circle_outline_rounded),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // );
                  },
                );
              },
            );
          },
        ),
      ),
      // Container(
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: ListView.builder(
      //           // physics: AlwaysScrollableScrollPhysics(),
      //           padding: EdgeInsets.zero,
      //           shrinkWrap: true,
      //           itemCount: orderUser?.orderItems.length ?? 0,
      //           // itemCount: orderItem?.length ?? 0,
      //           itemBuilder: (context, index) {
      //             OrderItem? item = orderUser?.orderItems[index];
      //             // OrderItem? item = orderItem?[index];
      //             return Container(
      //               height: MediaQuery.sizeOf(context).height / 10,
      //               margin: const EdgeInsets.all(8),
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(8),
      //                 border: Border.all(),
      //               ),
      //               child: Row(
      //                 children: [
      //                   Container(
      //                     // color: Colors.blue,
      //                     width: MediaQuery.sizeOf(context).width / 4,
      //                     child: CircleAvatar(
      //                       child: Icon(Icons.abc),
      //                     ),
      //                   ),
      //                   Container(
      //                     // color: Colors.amber,
      //                     width: MediaQuery.sizeOf(context).width / 2.5,
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(item?.product.name ?? ""),
      //                         Text("Total : ${item?.quantity ?? 0}"),
      //                       ],
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: Container(
      //                       // color: Colors.amber,
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text("Rp. 100.000"),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             );
      //           },
      //         ),
      //       ),

      //       /// OLD ------------------------------

      //       Container(
      //         // alignment: Alignment.centerLeft,
      //         color: Colors.amber,
      //         width: double.infinity,
      //         height: MediaQuery.sizeOf(context).height / 25,
      //         child: FittedBox(
      //           fit: BoxFit.fitHeight,
      //           child: Text(
      //             "Total : Rp. 545.000,00",
      //             textAlign: TextAlign.left,
      //             style: TextStyle(
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.w600,
      //                 fontStyle: FontStyle.normal),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      TransactionConfirmationPage(
          selectedCustomer: selectedCustomer, orderUser: orderUser),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 7,
              margin: const EdgeInsets.only(top: 14),
              color: Colors.amber,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 4.5,
                    margin: const EdgeInsets.all(4.0),
                    child: CircularPercentIndicator(
                      radius: MediaQuery.sizeOf(context).width / 9.5,
                      lineWidth: MediaQuery.sizeOf(context).width / 42,
                      percent: step / stepTransaction.length,
                      center: Text(
                        "$step of ${stepTransaction.length}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      progressColor: Colors.green,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    width: MediaQuery.sizeOf(context).width / 1.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Container(
                          alignment: Alignment.centerRight,
                          // padding: const EdgeInsets.fromLTRB(0, 15, 5, 0),
                          child: const Badge(
                            label: Text("3"),
                            child: Icon(Icons.shopping_cart_rounded),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Divider(color: AppColors.disabled),
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 14),
              height: MediaQuery.sizeOf(context).height / 1.3,
              margin: EdgeInsets.zero,
              // color: Colors.blue,
              child: PageView(
                controller: _pageController,
                padEnds: false,
                pageSnapping: true,
                physics: const NeverScrollableScrollPhysics(),
                children: listTransactionStep,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: (step == stepTransaction.length)
          ? Container(
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: AppColors.red,
                    width: MediaQuery.sizeOf(context).width / 3,
                    child: TextButton(
                      onPressed: () {
                        previousPage();
                      },
                      child: const Text("Kembali"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      color: AppColors.yellow,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Proses"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: (step == 1)
                      ? () {
                          Navigator.pop(context);
                        }
                      : () {
                          previousPage();
                        },
                  child: (step == 1)
                      ? const Text("Kembali")
                      : const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    nextPage();
                    // print(">>> selected user : ${selectedCustomer?.name ?? ""}");
                  },
                  child: const Text('Lanjut'),
                )
              ],
            ),
    );
  }
}
