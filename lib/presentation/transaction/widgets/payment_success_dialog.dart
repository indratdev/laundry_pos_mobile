import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/componets/buttons.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/core/extensions/date_time_ext.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:laundry_app/presentation/home/home_page.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Image.asset(Variables.doneIcon)),
          const SizedBox(height: 24),
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

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _LabelValue(
                    label: 'METODE PEMBAYARAN',
                    value: orderResponseModel.data.payment_method.toUpperCase(),
                  ),
                  const Divider(height: 36.0),
                  _LabelValue(
                    label: 'TOTAL PEMBELIAN',
                    value: orderResponseModel.data.total_price.currencyFormatRp,
                  ),
                  const Divider(height: 36.0),
                  _LabelValue(
                    label: 'NOMINAL BAYAR',
                    value: orderResponseModel.data.payment_method
                                .toUpperCase() ==
                            'QRIS'
                        ? orderResponseModel.data.total_price.currencyFormatRp
                        : orderResponseModel.data.total_price.currencyFormatRp,
                  ),
                  const Divider(height: 36.0),
                  _LabelValue(
                    label: 'WAKTU PEMBAYARAN',
                    value: DateTime.now().toFormattedTime(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Button.filled(
                          onPressed: () {
                            // context
                            //     .read<OrderBloc>()
                            //     .add(const OrderEvent.started());
                            // context.pushReplacement(const DashboardPage());
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage() ,));
                          },
                          label: 'Selesai',
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Button.outlined(
                          onPressed: () async {
                            // final ticket = await CwbPrint.instance.bluetoothStart();
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
