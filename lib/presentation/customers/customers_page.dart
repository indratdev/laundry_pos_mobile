import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';
import 'package:laundry_app/presentation/customers/customer_manage_page.dart';

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
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColors.blueLight.withOpacity(.4),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "CUSTOMER ID : ${customer.id}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${customer.name} | ${customer.email} "),
                                  Text(customer.address ?? ""),
                                ],
                              ),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                            )
                          ],
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
        // onPressed: () {},
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
