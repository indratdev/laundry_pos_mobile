import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/componets/buttons.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/data/data/cwb_print.dart';
import 'package:laundry_app/data/models/response/order_response_model.dart';
import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:laundry_app/presentation/home/home_page.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 7,
              child: Image.asset(Variables.doneIcon),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height / 60),
          const Text(
            'Pembayaran telah sukses dilakukan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            success: (orderResponseModel)

                // (data, qty, total, paymentType, nominal, idKasir, nameKasir)
                {
              // context.read<CheckoutBloc>().add(const CheckoutEvent.started());
              OrderResponseItem headerValue = orderResponseModel.data.order;
              List<OrderItem> detailValue = orderResponseModel.data.orderItems;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _LabelValue(
                    label: 'METODE PEMBAYARAN',
                    value: headerValue.payment_method.toUpperCase(),
                  ),
                  const Divider(height: 36.0),
                  _LabelValue(
                    label: 'TOTAL TAGIHAN',
                    value: headerValue.total_price.currencyFormatRp,
                  ),
                  const Divider(height: 36.0),
                  _LabelValue(
                    label: 'NOMINAL BAYAR',
                    value: headerValue.payment_method.toUpperCase() == 'QRIS'
                        ? headerValue.amount_payment.currencyFormatRp
                        : headerValue.amount_payment.currencyFormatRp,
                  ),
                  const Divider(height: 36.0),
                  _LabelValue(
                    label: 'WAKTU PEMBAYARAN',
                    // value: DateTime.now().toFormattedTime(),
                    value: headerValue.transaction_time,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Button.filled(
                          onPressed: () {
                            context
                                .read<OrderBloc>()
                                .add(const OrderEvent.started());
                            // context.pushReplacement(const DashboardPage());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ));
                          },
                          label: 'Selesai',
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Button.outlined(
                          onPressed: () async {
                            final printValue =
                                await CwbPrint.instance.printOrder(
                              detailValue,
                              headerValue.total_quantity,
                              headerValue.total_price,
                              headerValue.payment_method,
                              headerValue.amount_payment,
                              headerValue.cashier_name,
                            );
                            await PrintBluetoothThermal.writeBytes(printValue);
                            // final result =
                            //     await PrintBluetoothThermal.writeBytes(ticket);
                          },
                          label: 'Print',
                          // icon: Assets.icons.print.svg(),
                          icon: const Icon(Icons.print),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;

  const _LabelValue({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
