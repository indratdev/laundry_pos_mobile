import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';

class TransactionCustomerPage extends StatefulWidget {
  Customer? selectedCustomer;
  final Function(Customer) onCustomerSelected;

  TransactionCustomerPage({
    super.key,
    this.selectedCustomer,
    required this.onCustomerSelected,
  });

  @override
  State<TransactionCustomerPage> createState() =>
      _TransactionCustomerPageState();
}

class _TransactionCustomerPageState extends State<TransactionCustomerPage> {
  void _selectCustomer(Customer selectedCustomer) {
    widget.onCustomerSelected(selectedCustomer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          success: (customers) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.grey,
                ),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  Customer customer = customers[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        widget.selectedCustomer = customer;
                        _selectCustomer(customer);
                      });
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: false,
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
