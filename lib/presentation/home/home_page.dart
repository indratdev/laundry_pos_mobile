import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/core/extensions/build_context_ext.dart';

import '../../data/data/menus.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Variables.appName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
              height: MediaQuery.sizeOf(context).height / 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.blueLight.withOpacity(.5),
              ),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.all(12),
                      color: Colors.blue,
                      width: MediaQuery.sizeOf(context).width / 5,
                      child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/LEGO_logo.svg/512px-LEGO_logo.svg.png')),
                  Expanded(
                    child: Container(
                      child: ListTile(
                        title: Text("Title"),
                        subtitle: Text("Subtitle"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.deviceHeight / 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: context.infoContainerWidth,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: context.deviceWidth / 28,
                            backgroundColor: AppColors.light,
                            child: const Icon(Icons.edit_note_rounded),
                          ),
                          Column(
                            children: [
                              Text("Masuk"),
                              Text("1"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: context.infoContainerWidth,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: context.deviceWidth / 28,
                            backgroundColor: AppColors.light,
                            child: Icon(
                              Icons.check_outlined,
                              color: AppColors.green,
                            ),
                          ),
                          Column(
                            children: [
                              Text("Selesai"),
                              Text("3"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: context.infoContainerWidth,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: context.deviceWidth / 28,
                            backgroundColor: AppColors.light,
                            child: const Icon(Icons.timer_sharp,
                                color: Colors.red),
                          ),
                          Column(
                            children: [
                              Text("Terlambat"),
                              Text("2"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                children: Menus().serviceMenuList,
              ),
            ),
            // Spacer(),
            // ElevatedButton(onPressed: () {}, child: Text("Transaksi"))
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 14),
        width: context.deviceWidth / 1.2,
        child: FloatingActionButton.extended(
          elevation: 3,
          backgroundColor: AppColors.yellow,
          onPressed: () {},
          label: const Text(
            "TRANSAKSI",
            style: TextStyle(
              color: AppColors.whiteBriliant,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
