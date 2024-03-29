import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/presentation/home/home_page.dart';

import '../../../core/componets/buttons.dart';
import '../../../core/componets/custom_text_field.dart';
import '../../../core/componets/spaces.dart';
import '../../../data/datasource/auth_local_datasource.dart';
import '../../blocs/login_bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<String> loadImage() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Image loaded successfully';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text('Error loading image');
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    Variables.bannerImage,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).viewInsets.bottom,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        const SpaceHeight(12.0),
                        Center(
                          child: Text(
                            Variables.branchName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SpaceHeight(8.0),
                        Center(
                          child: Text(
                            "Masuk untuk kasir",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SpaceHeight(20.0),
                        CustomTextField(
                          controller: usernameController,
                          label: 'Username',
                          hintLabel: 'Username',
                        ),
                        const SpaceHeight(12.0),
                        CustomTextField(
                          controller: passwordController,
                          label: 'Password',
                          hintLabel: 'Password',
                          obscureText: true,
                        ),
                        const SpaceHeight(24.0),
                        BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              success: (authResponseModel) {
                                AuthLocalDatasource()
                                    .saveAuthData(authResponseModel);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              },
                              error: (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor: AppColors.red,
                                  ),
                                );
                              },
                            );
                          },
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () {
                                  return Button.filled(
                                    color: AppColors.hardBlueColor,
                                    onPressed: () {
                                      // context.read<LoginBloc>().add(
                                      //       LoginEvent.login(
                                      //         email: usernameController.text,
                                      //         password: passwordController.text,
                                      //       ),
                                      //     );
                                       context.read<LoginBloc>().add(
                                            LoginEvent.login(
                                              email: "indrat@mail.com",
                                              password: "123123",
                                            ),
                                          );
                                    },
                                    label: 'Masuk',
                                  );
                                },
                                loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
