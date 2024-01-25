import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class MenuPrinterContent extends StatelessWidget {
  final BluetoothInfo data;
  final bool isSelected;
  const MenuPrinterContent({
    Key? key,
    required this.data,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: isSelected ? 3.0 : 1.0,
          color: isSelected
              ? AppColors.hardBlueColor.withOpacity(.8)
              : AppColors.white,
        ),
      ),
      child: ListTile(
        title: Text(
          'Nama : ${data.name}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          'Mac Address: ${data.macAdress}',
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        // trailing: (isSelected) ? const Icon(Icons.check) : null,
      ),
    );
  }
}
