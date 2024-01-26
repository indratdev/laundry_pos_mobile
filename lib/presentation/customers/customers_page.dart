import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';
import 'package:laundry_app/presentation/customers/customer_manage_page.dart';
import 'package:laundry_app/presentation/customers/widgets/detail_customer_widget.dart';

import '../../../../core/componets/spaces.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Pelanggan'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'List Pelanggan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(20.0),
          BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                success: (customers) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: customers.length,
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(10.0),
                    itemBuilder: (context, index) {
                      Customer customer = customers[index];
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) =>
                                  DetailCustomerWidget(
                                    customer: customer,
                                  ));
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return Container(
                          //       width: MediaQuery.sizeOf(context).width - 100,
                          //       height: MediaQuery.sizeOf(context).height / 8,
                          //       color: Colors.amber,
                          //       child: Stack(
                          //         children: [
                          //           Container(
                          //             padding: const EdgeInsets.all(14),
                          //             color: Colors.transparent,
                          //             width: MediaQuery.sizeOf(context).width /
                          //                 1.2,
                          //             height:
                          //                 MediaQuery.sizeOf(context).height / 4,
                          //             child: Card(
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(4),
                          //               ),
                          //               clipBehavior:
                          //                   Clip.antiAliasWithSaveLayer,
                          //               child: Container(
                          //                 margin: EdgeInsets.all(12),
                          //                 child: Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: <Widget>[
                          //                     // Add padding around the row widget
                          //                     Row(
                          //                       crossAxisAlignment:
                          //                           CrossAxisAlignment.start,
                          //                       children: <Widget>[
                          //                         // Add an image widget to display an image
                          //                         Image.asset(
                          //                           Variables.bannerImage,
                          //                           height: 100,
                          //                           width: 100,
                          //                           fit: BoxFit.cover,
                          //                         ),
                          //                         // Add some spacing between the image and the text
                          //                         Container(width: 20),
                          //                         // Add an expanded widget to take up the remaining horizontal space
                          //                         Expanded(
                          //                           child: Column(
                          //                             crossAxisAlignment:
                          //                                 CrossAxisAlignment
                          //                                     .start,
                          //                             children: <Widget>[
                          //                               //
                          //                               Container(height: 5),

                          //                               Text(
                          //                                 "${customer.name}",
                          //                               ),

                          //                               Container(height: 5),

                          //                               Text(
                          //                                   "${customer.email}"),
                          //                               Text(
                          //                                   "${customer.phone}"),

                          //                               Container(height: 10),

                          //                               Text(
                          //                                 "${customer.address}",
                          //                                 maxLines: 2,
                          //                                 overflow: TextOverflow
                          //                                     .ellipsis,
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           Positioned(
                          //             top: 0,
                          //             right: -15,
                          //             child: RawMaterialButton(
                          //               onPressed: () {},
                          //               elevation: 2.0,
                          //               fillColor: AppColors.red,
                          //               // padding: const EdgeInsets.all(15.0),
                          //               shape: const CircleBorder(),
                          //               child: Icon(
                          //                 color: AppColors.white,
                          //                 Icons.close,
                          //                 size:
                          //                     MediaQuery.sizeOf(context).width /
                          //                         20,
                          //               ),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // );
                          // showDialog(
                          //   barrierDismissible: false,
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       backgroundColor: Colors.transparent,

                          //       contentPadding: const EdgeInsets.all(0),
                          //       content: SizedBox(
                          //         // height:
                          //         //     MediaQuery.sizeOf(context).height / 3.5,
                          //         // width: MediaQuery.sizeOf(context).width / 2,
                          //         child: Stack(
                          //           children: [
                          //             Container(
                          //               padding: const EdgeInsets.all(14),
                          //               color: Colors.transparent,
                          //               child: Card(
                          //                 shape: RoundedRectangleBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(4),
                          //                 ),
                          //                 clipBehavior:
                          //                     Clip.antiAliasWithSaveLayer,
                          //                 child: Container(
                          //                   margin: EdgeInsets.all(12),
                          //                   child: Column(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.start,
                          //                     children: <Widget>[
                          //                       Row(
                          //                         crossAxisAlignment:
                          //                             CrossAxisAlignment.start,
                          //                         children: <Widget>[
                          //                           // Add an image widget to display an image
                          //                           Image.asset(
                          //                             Variables.bannerImage,
                          //                             height: 100,
                          //                             width: 100,
                          //                             fit: BoxFit.cover,
                          //                           ),
                          //                           // Add some spacing between the image and the text
                          //                           Container(width: 20),
                          //                           // Add an expanded widget to take up the remaining horizontal space
                          //                           Expanded(
                          //                             child: Column(
                          //                               crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                               children: <Widget>[
                          //                                 Container(height: 5),
                          //                                 Text(
                          //                                   "${customer.name}",
                          //                                 ),
                          //                                 Container(height: 5),
                          //                                 Text(
                          //                                     "${customer.email}"),
                          //                                 Text(
                          //                                     "${customer.phone}"),
                          //                                 Container(height: 10),
                          //                                 Text(
                          //                                   "${customer.address}",
                          //                                   maxLines: 2,
                          //                                   overflow:
                          //                                       TextOverflow
                          //                                           .ellipsis,
                          //                                 ),
                          //                               ],
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             Positioned(
                          //               top: 0,
                          //               right: -15,
                          //               child: RawMaterialButton(
                          //                 onPressed: () =>
                          //                     Navigator.pop(context),
                          //                 elevation: 2.0,
                          //                 fillColor: AppColors.red,
                          //                 shape: const CircleBorder(),
                          //                 child: Icon(
                          //                   color: AppColors.white,
                          //                   Icons.close,
                          //                   size: MediaQuery.of(context)
                          //                           .size
                          //                           .width /
                          //                       20,
                          //                 ),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.blueLight.withOpacity(.4),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  "${customer.name} | ${customer.email} ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      customer.address ?? "",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(customer.phone ?? ""),
                                  ],
                                ),
                                trailing:
                                    const Icon(Icons.arrow_forward_ios_rounded),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CustomerManagePage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
