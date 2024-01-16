import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';

class TransactionCustomerPage extends StatefulWidget {
  Customer? selectedCustomer;

  TransactionCustomerPage({
    super.key,
    this.selectedCustomer,
  });

  @override
  State<TransactionCustomerPage> createState() =>
      _TransactionCustomerPageState();
}

class _TransactionCustomerPageState extends State<TransactionCustomerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        print(">>>> state ");
        return state.maybeWhen(
          orElse: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          success: (customers) {
            return Container(
              // alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  Customer customer = customers[index];
                  return InkWell(
                    onTap: () {
                      widget.selectedCustomer = customer;
                      setState(() {});
                    },
                    child: ListTile(
                      title: Text(customer.name),
                      subtitle: Text(customer.address ?? ""),
                      trailing: (widget.selectedCustomer == customer)
                          ? const Icon(Icons.check)
                          : null,
                      tileColor: (widget.selectedCustomer == customer)
                          ? AppColors.yellow.withOpacity(.2)
                          : null,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
