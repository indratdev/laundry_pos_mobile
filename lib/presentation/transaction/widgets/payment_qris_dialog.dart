import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:laundry_app/core/componets/spaces.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/extensions/build_context_ext.dart';
import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:laundry_app/presentation/blocs/qris_bloc/qris_bloc.dart';
import 'package:laundry_app/presentation/transaction/widgets/payment_success_dialog.dart';

class PaymentQrisDialog extends StatefulWidget {
  final int price;
  const PaymentQrisDialog({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  State<PaymentQrisDialog> createState() => _PaymentQrisDialogState();
}

class _PaymentQrisDialogState extends State<PaymentQrisDialog> {
  String orderId = '';
  Timer? timer;
  @override
  void initState() {
    print(">> init jalan");
    orderId = DateTime.now().millisecondsSinceEpoch.toString();
    context.read<QrisBloc>().add(QrisEvent.generateQRCode(
          orderId,
          widget.price,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: AppColors.primary,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Pembayaran QRIS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
          ),
          const SpaceHeight(6.0),
          // BlocBuilder<OrderBloc, OrderState>(
          //   builder: (context, state) {
          //     print(">> OrderBloc : ${state}");
          //     return state.maybeWhen(orElse: () {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }, success: (orderResponseModel) {
          //       return Container(
          //         width: context.deviceWidth,
          //         padding: const EdgeInsets.all(14.0),
          //         decoration: const BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular(20.0)),
          //           color: AppColors.white,
          //         ),
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             BlocListener<QrisBloc, QrisState>(
          //               listener: (context, state) {
          //                 print(">> QrisBloc : ${state}");
          //                 state.maybeWhen(orElse: () {
          //                   return;
          //                 }, qrisResponse: (data) {
          //                   const onSec = Duration(seconds: 5);
          //                   timer = Timer.periodic(onSec, (timer) {
          //                     context
          //                         .read<QrisBloc>()
          //                         .add(QrisEvent.checkPaymentStatus(
          //                           orderId,
          //                         ));
          //                   });
          //                 }, success: (message) {
          //                   timer?.cancel();
          //                   // final orderModel = OrderModel(
          //                   //     paymentMethod: paymentMethod,
          //                   //     nominalBayar: total,
          //                   //     orders: data,
          //                   //     totalQuantity: qty,
          //                   //     totalPrice: total,
          //                   //     idKasir: idKasir,
          //                   //     namaKasir: namaKasir,
          //                   //     transactionTime:
          //                   //         DateFormat('yyyy-MM-ddTHH:mm:ss')
          //                   //             .format(DateTime.now()),
          //                   //     isSync: false);

          //                   // ProductLocalDatasource.instance
          //                   //     .saveOrder(orderModel);
          //                   context.pop();
          //                   showDialog(
          //                     context: context,
          //                     builder: (context) =>
          //                         const PaymentSuccessDialog(),
          //                   );
          //                 });
          //               },
          BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            child: Container(
              width: context.deviceWidth,
              padding: const EdgeInsets.all(14.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: AppColors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocConsumer<QrisBloc, QrisState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {
                          return;
                        },
                        qrisResponse: (qrisResponseModel) {
                          const onSec = Duration(seconds: 5);
                          timer = Timer.periodic(onSec, (timer) {
                            context
                                .read<QrisBloc>()
                                .add(QrisEvent.checkPaymentStatus(
                                  orderId,
                                ));
                          });
                        },
                        success: (result) {
                          // ini belum
                          // Future.delayed(Duration.zero, () {
                          //   showDialog(
                          //     context: context,
                          //     builder: (context) => PaymentSuccessDialog(

                          //     ),
                          //   );
                          // });
                        },
                      );
                    },
                    builder: (context, state) {
                      print(">>> state QrisBloc : $state");
                      return state.maybeWhen(
                        orElse: () {
                          return const SizedBox();
                        },
                        qrisResponse: (data) {
                          print(">> view : ${data.actions!.first.url}");
                          return Container(
                            width: 256.0,
                            height: 256.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Image.network(
                                data.actions!.first.url!,
                              ),
                            ),
                          );
                        },
                        loading: () {
                          return Container(
                            width: 256.0,
                            height: 256.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SpaceHeight(5.0),
                  const Text(
                    'Scan QRIS untuk melakukan pembayaran',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
