import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/core/extensions/build_context_ext.dart';
import 'package:laundry_app/data/datasource/auth_local_datasource.dart';
import 'package:laundry_app/data/models/response/auth_response_model.dart';
import 'package:laundry_app/presentation/widgets/custom_dialogs.dart';

import '../../data/data/menus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<AuthResponseModel?> userLoginFuture;

  @override
  void initState() {
    userLoginFuture = getUserLogin();
    super.initState();
  }

  Future<AuthResponseModel?> getUserLogin() async {
    return await AuthLocalDatasource().getAuthData();
  }

  signOut() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Menus menus = Menus(context: context);
    List<Widget> menuList = menus.getServiceMenuList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(Variables.appName),
        actions: [
          IconButton(
            onPressed: () {
              CustomDialogs.showConfirmation(
                  context, "Apakah Anda Yakin Keluar ?", () => signOut());
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: FutureBuilder(
          future: getUserLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            } else {
              AuthResponseModel? userLogin = snapshot.data;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                    height: MediaQuery.sizeOf(context).height / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.blueLight.withOpacity(.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(12),
                          width: MediaQuery.sizeOf(context).width / 7,
                          child: Image.asset(
                            Variables.personIcon,
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("${userLogin?.user.name}"),
                            subtitle: Text(
                              "${userLogin?.user.roles}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // color: Colors.green,
                    height: context.deviceHeight / 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: context.infoContainerWidth,
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: context.deviceWidth / 28,
                                    backgroundColor: AppColors.light,
                                    child: const Icon(Icons.edit_note_rounded),
                                  ),
                                ),
                                const Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Antrian",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("1"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: context.infoContainerWidth,
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: context.deviceWidth / 28,
                                    backgroundColor: AppColors.light,
                                    child: const Icon(
                                      Icons.check_outlined,
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Diproses",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("3"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            // padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            height: context.infoContainerWidth,
                            decoration: BoxDecoration(
                                color: AppColors.yellow,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: context.deviceWidth / 28,
                                    backgroundColor: AppColors.light,
                                    child: const Icon(Icons.timer_sharp,
                                        color: Colors.red),
                                  ),
                                ),
                                const Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Selesai",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("2"),
                                    ],
                                  ),
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
                      childAspectRatio: 3 / 3,
                      children: menuList,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
