import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';
import 'package:laundry_app/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:laundry_app/presentation/customers/customers_page.dart';
import 'package:laundry_app/presentation/settings/pages/management_product/manage_product_page.dart';
import 'package:laundry_app/presentation/settings/settings_page.dart';

import '../../core/constants/variables.dart';
import '../../presentation/home/widgets/service_menu_widget.dart';

class Menus {
  late BuildContext context;

  Menus({required this.context});

  List<Widget> getServiceMenuList() {
    return [
      ServiceMenuWidget(title: "Layanan", iconName: Variables.serviceIcon),
      ServiceMenuWidget(
        title: "Pelanggan",
        iconName: Variables.customersIcon,
        onTap: () {
          BlocProvider.of<CustomerBloc>(context)
              .add(const CustomerEvent.fetchAllFromState());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CustomersPage()));
        },
      ),
      ServiceMenuWidget(title: "Riwayat", iconName: Variables.historyIcon),
      ServiceMenuWidget(title: "Laporan", iconName: Variables.reportsIcon),
      ServiceMenuWidget(
          title: "Kelola",
          iconName: Variables.settingsIcon,
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SettingPage()))),
    ];
  }

  List<Widget> getSettingMenuList() {
    return [
      ServiceMenuWidget(
        title: "Kelola Produk",
        iconName: Variables.manageProductIcon,
        onTap: () {
          context
              .read<ProductBloc>()
              .add(const ProductEvent.fetchAllFromState());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ManageProductPage()));
        },
      ),
      ServiceMenuWidget(
          title: "Kelola Printer",
          iconName: Variables.managePrinterIcon,
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ManageProductPage()))),
    ];
  }
}


// class Menus {
//   late BuildContext? context;

//   Menus();

//   void init(BuildContext context) {
//     this.context = context;
//   }

//   List<Widget> getServiceMenuList() {
//     if (context == null) {
//       throw Exception(
//           "Menus class not initialized with context. Call init() first.");
//     }

//     return [
//       ServiceMenuWidget(title: "Layanan", iconName: Variables.serviceIcon),
//       ServiceMenuWidget(title: "Pelanggan", iconName: Variables.customersIcon),
//       ServiceMenuWidget(title: "Riwayat", iconName: Variables.historyIcon),
//       ServiceMenuWidget(title: "Laporan", iconName: Variables.reportsIcon),
//       ServiceMenuWidget(
//           title: "Kelola",
//           iconName: Variables.settingsIcon,
//           onTap: () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const SettingPage()))),
//     ];
//   }
// }



// class Menus {
//   List<Widget> serviceMenuList = [
//     ServiceMenuWidget(title: "Layanan", iconName: Variables.serviceIcon),
//     ServiceMenuWidget(title: "Pelanggan", iconName: Variables.customersIcon),
//     ServiceMenuWidget(title: "Riwayat", iconName: Variables.historyIcon),
//     ServiceMenuWidget(title: "Laporan", iconName: Variables.reportsIcon),
//     ServiceMenuWidget(
//       title: "Kelola",
//       iconName: Variables.settingsIcon,
//       onTap: () {
//         Navigator.pushNamed(context, '');
//       },
//       // context: context,
//     ),
//   ];
// }
