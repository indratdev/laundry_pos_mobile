import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';
import 'package:laundry_app/presentation/blocs/history_bloc/history_bloc.dart';
import 'package:laundry_app/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:laundry_app/presentation/customers/customers_page.dart';
import 'package:laundry_app/presentation/history/history_page.dart';
import 'package:laundry_app/presentation/settings/pages/management_printer/manage_printer_page.dart';
import 'package:laundry_app/presentation/settings/pages/management_product/manage_product_page.dart';
import 'package:laundry_app/presentation/settings/pages/server_key/server_key_page.dart';
import 'package:laundry_app/presentation/settings/settings_page.dart';
import 'package:laundry_app/presentation/status/status_page.dart';
import 'package:laundry_app/presentation/transaction/transaction_page.dart';

import '../../core/constants/variables.dart';
import '../../presentation/home/widgets/service_menu_widget.dart';

class Menus {
  late BuildContext context;

  Menus({required this.context});

  List<Widget> getServiceMenuList() {
    return [
      ServiceMenuWidget(
        title: "Transaksi",
        iconName: Variables.serviceIcon,
        onTap: () {
          context
              .read<CustomerBloc>()
              .add(const CustomerEvent.fetchAllFromState());
          context
              .read<ProductBloc>()
              .add(const ProductEvent.fetchAllFromState());
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionPage(),
              ));
        },
      ),
      ServiceMenuWidget(title: "Pengambilan", iconName: Variables.pickUpIcon),
      ServiceMenuWidget(
        title: "Status",
        iconName: Variables.statusOrderIcon,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StatusPage()));
        },
      ),
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
      ServiceMenuWidget(
        title: "Riwayat",
        iconName: Variables.historyIcon,
        onTap: () {
          BlocProvider.of<HistoryBloc>(context).add(const HistoryEvent.fetch());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HistoryPage()));
        },
      ),
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
            builder: (context) => const ManagePrinterPage(),
          ),
        ),
      ),
      ServiceMenuWidget(
        title: "Server Key",
        iconName: Variables.serverKeyIcon,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ServerKeyPage(),
          ),
        ),
      ),
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
