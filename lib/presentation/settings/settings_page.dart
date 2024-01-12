import 'package:flutter/material.dart';

import '../../data/data/menus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    Menus menus = Menus(context: context);
    List<Widget> menuList = menus.getSettingMenuList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(10),
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3 / 4,
              children: menuList,
            ),
          ),
        ],
      ),
    );
  }
}
