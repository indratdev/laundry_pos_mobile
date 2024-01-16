import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
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
  final _pageController = PageController(viewportFraction: 1.0);

  int step = 1;
  List<dynamic> stepTransaction = ["Pelanggan", "Kategori", "Layanan"];
  Customer? selectedCustomer;

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
    setState(() {
      step += 1;
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

  @override
  Widget build(BuildContext context) {
    List<Widget> listTransactionStep = [
      TransactionCustomerPage(selectedCustomer: selectedCustomer, onCustomerSelected: (value) {
        setState(() {
          selectedCustomer = value;
        });
      },),
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
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 5,
              margin: const EdgeInsets.only(top: 14),
              color: Colors.amber,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 4,
                    margin: const EdgeInsets.all(8.0),
                    child: CircularPercentIndicator(
                      radius: MediaQuery.sizeOf(context).width / 8,
                      lineWidth: MediaQuery.sizeOf(context).width / 30,
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
                    padding: const EdgeInsets.only(left: 10),
                    width: MediaQuery.sizeOf(context).width / 1.55,
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
                        Text("Selanjutnya : ${stepTransaction[step]}"),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
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
            Divider(color: AppColors.disabled),
            Container(
              // margin: const EdgeInsets.symmetric(horizontal: 14),
              height: MediaQuery.sizeOf(context).height / 1.5,
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
      bottomNavigationBar: Row(
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
            child: (step == 1) ? const Text("Kembali") : const Text('Previous'),
          ),
          ElevatedButton(
            onPressed: (step <= stepTransaction.length)
                ? () {
                    nextPage();
                    // print(">>> selected user : ${selectedCustomer?.name ?? ""}");
                  }
                : null,
            child: Text('Lanjut'),
          )
        ],
      ),
    );
  }
}
