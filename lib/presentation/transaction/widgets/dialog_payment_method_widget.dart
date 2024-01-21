import 'package:flutter/material.dart';
import 'package:laundry_app/core/componets/buttons.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/core/extensions/int_ext.dart';
import 'package:laundry_app/core/extensions/string_ext.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart';

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
  // double _amountPayment = 0.0;

  TextEditingController amountPaymentController = TextEditingController();

  @override
  void initState() {
    // amountPaymentController.text = widget.orderUser.totalPrice.toString();
    super.initState();
  }

  @override
  void dispose() {
    amountPaymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: const EdgeInsets.symmetric(horizontal: 25),
      child: SimpleDialog(
        title: const Text('Metode Pembayaran'),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Button.filled(
                    color: (widget.orderUser.paymentMethod == "cash")
                        ? AppColors.yellow.withOpacity(.8)
                        : Colors.transparent,
                    onPressed: () {
                      setState(() {
                        widget.orderUser.paymentMethod = "cash";
                      });
                    },
                    label: "Tunai",
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  flex: 1,
                  child: Button.filled(
                    color: (widget.orderUser.paymentMethod == "qris")
                        ? AppColors.yellow.withOpacity(.8)
                        : Colors.transparent,
                    onPressed: () {
                      setState(() {
                        widget.orderUser.paymentMethod = "qris";
                      });
                    },
                    label: "QRIS",
                  ),
                ),
                
              ],
            ),
          ),
          (widget.orderUser.paymentMethod == "cash")
              ? Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 12, 25, 10),
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
                          labelText:
                              widget.orderUser.totalPrice.currencyFormatRp,
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
              : const SizedBox(),
          Container(
            margin: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Button.filled(
              label: "Proses",
              onPressed: () {
                print(">> oooo : ${amountPaymentController.text}");
                widget.orderUser.amountPayment =
                    amountPaymentController.text.toDoubleFromText;
                print(">>> : result : ${widget.orderUser.toMap()}");
              },
            ),
          )
        ],
      ),
    );
  }
}
