import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';
import 'package:laundry_app/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:laundry_app/presentation/transaction/transaction_customer_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _pageController = PageController(
      // initialPage: 2,
      // viewportFraction: 0.8,
      );

  int step = 1;
  List<dynamic> stepTransaction = ["Pelanggan", "Kategori", "Layanan"];
  Customer? selectedCustomer;

  // void nextPage() {
  //   print(">> page next :: ${_pageController.page!.toInt()}");
  //   setState(() {
  //     step = _pageController.page!.toInt() + 1;
  //   });
  //   _pageController.animateToPage(_pageController.page!.toInt() + 1,
  //       duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  // }

  // void previousPage() {
  //   print(">> page previous :: ${_pageController.page!.toInt()}");
  //   setState(() {
  //     step = _pageController.page!.toInt() - 1;
  //   });

  //   _pageController.animateToPage(_pageController.page!.toInt() - 1,
  //       duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  // }

  // void nextPage() {
  //   print(">> page next :: ${_pageController.page!.toInt()}");
  //   // setState(() {
  //   //   step = _pageController.page!.toInt() + 1;
  //   // });
  //   _pageController.animateToPage(
  //     _pageController.page!.toInt() + 1,
  //     duration: const Duration(milliseconds: 400),
  //     curve: Curves.easeIn,
  //   );
  //   // setState(() {});
  // }

  // void previousPage() {
  //   print(">> page previous :: ${_pageController.page!.toInt()}");
  //   // setState(() {
  //   //   step = (_pageController.page!.toInt() - 1)
  //   //       .clamp(0, stepTransaction.length - 1);
  //   // });

  //   _pageController.animateToPage(
  //     (_pageController.page!.toInt() - 1).clamp(0, stepTransaction.length - 1),
  //     duration: const Duration(milliseconds: 400),
  //     curve: Curves.easeIn,
  //   );
  //   // setState(() {});
  // }

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
    setState(() {});
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listTransactionStep = [
      TransactionCustomerPage(
        selectedCustomer: selectedCustomer,
      ),
      Container(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                // return SizedBox();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              success: (products) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    Product product = products[index];

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
                            // crossAxisAlignment:
                            //     CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove_circle_outline_rounded),
                              ),
                              Text(
                                  "0 ${(product.category == 'satuan') ? "pcs" : "Kg"}"),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_circle_outline_rounded),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      // Container(
      //   color: Colors.blue,
      //   child: const Center(
      //     child: Text(
      //       'BLUE PAGE',
      //       style: TextStyle(
      //         fontSize: 45,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      // Container(
      //   color: Colors.black,
      //   child: const Center(
      //     child: Text(
      //       'BLACK PAGE',
      //       style: TextStyle(
      //         fontSize: 45,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      // Container(
      //   color: Colors.yellow,
      //   child: const Center(
      //     child: Text(
      //       'YELLOW PAGE',
      //       style: TextStyle(
      //         fontSize: 45,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height / 4.5,
            margin: const EdgeInsets.only(top: 14),
            color: Colors.amber,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: CircularPercentIndicator(
                      radius: MediaQuery.sizeOf(context).width / 8,
                      lineWidth: MediaQuery.sizeOf(context).width / 30,
                      // percent: ((_pageController.page?.toInt() ?? 0) +
                      //         1 / stepTransaction.length)
                      //     .abs(),
                      percent: (_pageController.positions.isNotEmpty)
                          ? ((_pageController.page?.toInt() ?? 0) +
                                  1 / stepTransaction.length)
                              .abs()
                          : 0,
                      center: (_pageController.positions.isNotEmpty)
                          ? Text(
                              // "$step of ${stepTransaction.length}",
                              "${_pageController.page?.toInt()} of ${listTransactionStep.length}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : null,
                      progressColor: Colors.green,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: double.infinity,
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pilih ${stepTransaction[step - 1]}",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 5),
                        Text("Selanjutnya : ${stepTransaction[step]}")
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // TransactionCustomerPage(
          //   selectedCustomer: selectedCustomer,
          // ),
          // Flexible(
          //   flex: 7,
          //   child: BlocBuilder<CustomerBloc, CustomerState>(
          //     builder: (context, state) {
          //       print(">>>> state ");
          //       return state.maybeWhen(
          //         orElse: () {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         },
          //         success: (customers) {
          //           return Container(
          //             alignment: Alignment.topCenter,
          //             // margin: const EdgeInsets.symmetric(horizontal: 14),
          //             // color: Colors.blue,
          //             child: ListView.builder(
          //               itemCount: customers.length,
          //               itemBuilder: (context, index) {
          //                 Customer customer = customers[index];
          //                 return InkWell(
          //                   onTap: () {
          //                     selectedCustomer = customer;
          //                     setState(() {});
          //                   },
          //                   child: ListTile(
          //                     title: Text(customer.name),
          //                     subtitle: Text(customer.address ?? ""),
          //                     trailing: (selectedCustomer == customer)
          //                         ? const Icon(Icons.check)
          //                         : null,
          //                     tileColor: (selectedCustomer == customer)
          //                         ? AppColors.yellow.withOpacity(.2)
          //                         : null,
          //                   ),
          //                 );
          //               },
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          // content 2
          Expanded(
            // flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              // height: double.infinity,
              // color: Colors.blue,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: listTransactionStep,
              ),
            ),
          ),
          //end content 2
          // Flexible(
          //   flex: 1,
          //   child: Container(
          //     color: Colors.red,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         ElevatedButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           child: const Text("Kembali"),
          //         ),
          //         ElevatedButton(
          //           onPressed: () {},
          //           child: const Text("Lanjut"),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: previousPage,
            child: Text('Previous'),
          ),
          ElevatedButton(
            onPressed: nextPage,
            child: Text('Next'),
          )
        ],
      ),
    );
  }
}
