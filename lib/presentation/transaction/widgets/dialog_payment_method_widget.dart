import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/componets/buttons.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/core/extensions/int_ext.dart';
import 'package:laundry_app/core/extensions/string_ext.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart';

import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';

import 'package:laundry_app/presentation/transaction/widgets/payment_qris_dialog.dart';

class DialogPaymentMethodWidget extends StatefulWidget {
  OrderRequestModel orderUser;

  DialogPaymentMethodWidget({
    super.key,
    required this.orderUser,
  });

  @override
  State<DialogPaymentMethodWidget> createState() =>
      _DialogPaymentMethodWidgetState();
}

class _DialogPaymentMethodWidgetState extends State<DialogPaymentMethodWidget> {
  TextEditingController amountPaymentController = TextEditingController();

  @override
  void initState() {
    filterOutZeroQuantity();

    super.initState();
  }

  filterOutZeroQuantity() {
    List<OrderItem> filteredOrderItems =
        widget.orderUser.orderItems.where((item) => item.quantity > 0).toList();

    widget.orderUser.orderItems = [];
    widget.orderUser.orderItems.addAll(filteredOrderItems);
  }

  @override
  void dispose() {
    amountPaymentController.dispose();

    super.dispose();
  }

  double removeCurrency(String value) {
    return value.replaceAll('Rp. ', '').replaceAll('.', '').toDoubleFromText;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: (widget.orderUser.paymentMethod == "cash")
          ? const Text('Nominal Pembayaran')
          : const Align(alignment: Alignment.center, child: Text('Scan QRIS')),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Flexible(
              //   flex: 1,
              //   child: Button.filled(
              //     color: (widget.orderUser.paymentMethod == "cash")
              //         ? AppColors.yellow.withOpacity(.8)
              //         : Colors.transparent,
              //     onPressed: () {
              //       setState(() {
              //         widget.orderUser.paymentMethod = "cash";
              //       });
              //     },
              //     label: "Tunai",
              //   ),
              // ),
              // const SizedBox(width: 15),
              // Flexible(
              //   flex: 1,
              //   child: Button.filled(
              //     label: "QRIS",
              //     color: (widget.orderUser.paymentMethod == "qris")
              //         ? AppColors.yellow.withOpacity(.8)
              //         : Colors.transparent,
              //     onPressed: () {
              //       setState(() {
              //         // String orderId =
              //         //     DateTime.now().millisecondsSinceEpoch.toString();
              //         // context.read<QrisBloc>().add(QrisEvent.generateQRCode(
              //         //       orderId,
              //         //       10000,
              //         //     ));

              //         widget.orderUser.paymentMethod = "qris";
              //         Future.delayed(Duration.zero, () {
              //           showDialog(
              //             context: context,
              //             builder: (context) => PaymentQrisDialog(
              //               price: widget.orderUser.totalPrice,
              //             ),
              //           );
              //         });
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
        (widget.orderUser.paymentMethod == "cash")
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 4, 25, 10),
                    child: TextField(
                      controller: amountPaymentController,
                      onChanged: (value) {
                        final int priceValue = value.toIntegerFromText;
                        amountPaymentController.text =
                            priceValue.currencyFormatRp;
                        amountPaymentController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: amountPaymentController.text.length));
                      },
                      decoration: InputDecoration(
                        labelText: widget.orderUser.totalPrice.currencyFormatRp,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : SizedBox(),
        // Container(
        //     margin: const EdgeInsets.fromLTRB(25, 4, 25, 10),
        //     child: Button.filled(
        //       label: "QRIS",
        //       color: (widget.orderUser.paymentMethod == "qris")
        //           ? AppColors.yellow.withOpacity(.8)
        //           : Colors.transparent,
        //       onPressed: () {
        //         setState(() {
        //           // String orderId =
        //           //     DateTime.now().millisecondsSinceEpoch.toString();
        //           // context.read<QrisBloc>().add(QrisEvent.generateQRCode(
        //           //       orderId,
        //           //       10000,
        //           //     ));

        //           widget.orderUser.paymentMethod = "qris";
        //           Future.delayed(Duration.zero, () {
        //             showDialog(
        //               context: context,
        //               builder: (context) => PaymentQrisDialog(
        //                 price: widget.orderUser.totalPrice,
        //               ),
        //             );
        //           });
        //         });
        //       },
        //     ),
        //   ),
        Container(
          margin: const EdgeInsets.fromLTRB(25, 20, 25, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: (widget.orderUser.paymentMethod == "cash")
              ? Button.filled(
                  label: "Proses",
                  onPressed: () {
                    DateTime transactionTime = DateTime.now();
                    widget.orderUser.transactionTime =
                        transactionTime.toString();
                    widget.orderUser.amountPayment =
                        removeCurrency(amountPaymentController.text);
                    BlocProvider.of<OrderBloc>(context)
                        .add(OrderEvent.addOrder(widget.orderUser));
                    Navigator.pop(context);

                    // print(widget.orderUser.amountPayment);
                    // print(removeCurrency(amountPaymentController.text));
                  },
                )
              : Button.filled(
                  label: "Generate QRIS",
                  onPressed: () {
                    setState(() {
                      // String orderId =
                      //     DateTime.now().millisecondsSinceEpoch.toString();
                      // context.read<QrisBloc>().add(QrisEvent.generateQRCode(
                      //       orderId,
                      //       10000,
                      //     ));

                      widget.orderUser.paymentMethod = "qris";
                      Future.delayed(Duration.zero, () {
                        showDialog(
                          context: context,
                          builder: (context) => PaymentQrisDialog(
                            price: widget.orderUser.totalPrice,
                            order: widget.orderUser,
                          ),
                        );
                      });
                    });
                  },
                ),
        )
      ],
    );
  }
}
