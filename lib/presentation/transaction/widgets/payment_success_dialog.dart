import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/componets/buttons.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/core/extensions/double_ext.dart';
import 'package:laundry_app/data/data/cwb_print.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart'
    as order_request;
import 'package:laundry_app/data/models/response/order_response_model.dart';
import 'package:laundry_app/data/models/response/qris_status_response_model.dart';
import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:laundry_app/presentation/blocs/qris_bloc/qris_bloc.dart';
import 'package:laundry_app/presentation/home/home_page.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

enum PaymentMethod {
  cash,
  qris,
}

class PaymentSuccessDialog extends StatelessWidget {
  PaymentMethod paymentMethod;
  QrisStatusResponseModel? qrisResult;
  order_request.OrderRequestModel? order;

  PaymentSuccessDialog({
    super.key,
    required this.paymentMethod,
    this.qrisResult,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    double heightDivider = MediaQuery.sizeOf(context).height / 25;

    return AlertDialog(
      scrollable: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              height: MediaQuery.sizeOf(context).height / 8,
              child: Image.asset(Variables.doneIcon),
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height / 65),
          const Text(
            'Pembayaran telah sukses dilakukan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: (paymentMethod.name == PaymentMethod.cash.name)
          ? BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  success: (orderResponseModel) {
                    OrderResponseItem headerValue =
                        orderResponseModel.data.order;
                    List<OrderItem> detailValue =
                        orderResponseModel.data.orderItems;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _LabelValue(
                          label: 'METODE PEMBAYARAN',
                          value: headerValue.payment_method.toUpperCase(),
                        ),
                        Divider(height: heightDivider),
                        _LabelValue(
                          label: 'TOTAL TAGIHAN',
                          value: headerValue.total_price.currencyFormatRp,
                        ),
                        Divider(height: heightDivider),
                        _LabelValue(
                          label: 'NOMINAL BAYAR',
                          value:
                              headerValue.payment_method.toUpperCase() == 'QRIS'
                                  ? headerValue.amount_payment.currencyFormatRp
                                  : headerValue.amount_payment.currencyFormatRp,
                        ),
                        Divider(height: heightDivider),
                        _LabelValue(
                          label: 'WAKTU PEMBAYARAN',
                          // value: DateTime.now().toFormattedTime(),
                          value: headerValue.transaction_time,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Button.filled(
                                color: AppColors.hardBlueColor,
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
                                  await PrintBluetoothThermal.writeBytes(
                                      printValue);
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
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _LabelValue(
                  label: 'METODE PEMBAYARAN',
                  value: qrisResult?.paymentType?.toUpperCase() ?? "",
                ),
                Divider(height: heightDivider),
                _LabelValue(
                  label: 'NOMINAL BAYAR',
                  value: double.parse(qrisResult?.grossAmount ?? "0")
                      .currencyFormatRp,
                ),
                Divider(height: heightDivider),
                _LabelValue(
                    label: 'WAKTU PEMBAYARAN',
                    // value: DateTime.now().toFormattedTime(),
                    value: qrisResult?.settlementTime.toString() ?? ""),
                const SizedBox(height: 18),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Button.filled(
                        onPressed: () {
                          context
                              .read<OrderBloc>()
                              .add(const OrderEvent.started());
                          context
                              .read<QrisBloc>()
                              .add(const QrisEvent.started());
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
                              await CwbPrint.instance.printOrderQris(
                            order?.orderItems ?? [],
                            order?.totalQuantity ?? 0,
                            double.tryParse(qrisResult?.grossAmount ?? "0") ??
                                0.0,
                            qrisResult?.paymentType?.toUpperCase() ?? "",
                            double.tryParse(qrisResult?.grossAmount ?? "0") ??
                                0.0,
                            "",
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
