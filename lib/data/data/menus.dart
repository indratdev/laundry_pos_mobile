import 'package:flutter/material.dart';

import '../../core/constants/variables.dart';
import '../../presentation/home/widgets/service_menu_widget.dart';

class Menus {
  List<Widget> serviceMenuList = [
    ServiceMenuWidget(title: "Layanan", iconName: Variables.serviceIcon),
    ServiceMenuWidget(title: "Pelanggan", iconName: Variables.customersIcon),
    ServiceMenuWidget(title: "Riwayat", iconName: Variables.historyIcon),
    ServiceMenuWidget(title: "Laporan", iconName: Variables.reportsIcon),
    ServiceMenuWidget(title: "Kelola", iconName: Variables.settingsIcon),
  ];
}
