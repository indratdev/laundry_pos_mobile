import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/presentation/home/home_page.dart';

import '../../../core/componets/buttons.dart';
import '../../../core/componets/custom_text_field.dart';
import '../../../core/componets/spaces.dart';
import '../../../data/datasource/auth_local_datasource.dart';
import '../../blocs/login_bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(80.0),
          // Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 130.0),
          //     child: Image.asset(
          //       Assets.images.logo.path,
          //       width: 100,
          //       height: 100,
          //     )),
          const SpaceHeight(24.0),
          const Center(
            child: Text(
              "Laundry POS APP",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SpaceHeight(8.0),
          const Center(
            child: Text(
              "Masuk untuk kasir",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: usernameController,
            label: 'Username',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          // Button.filled(onPressed: (){}, label: 'Masuk',)
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              print(">>> state BlocListener : $state");
              state.maybeWhen(
                orElse: () {},
                success: (authResponseModel) {
                  AuthLocalDatasource().saveAuthData(authResponseModel);
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
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                print(">>> state BlocBuilder : $state");
                state.maybeWhen(
                  orElse: () {
                    // return Button.filled(
                    //   onPressed: () {
                    //     print(">>> print");
                    //     context.read<LoginBloc>().add(
                    //           LoginEvent.login(
                    //             email: usernameController.text,
                    //             password: passwordController.text,
                    //           ),
                    //         );
                    //   },
                    //   label: 'Masuk',
                    // );
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  },
                  error: (message) {
                    return Center(child: Container(child: Text("Gagal")),);
                  },
                );
                return Button.filled(
                  onPressed: () {
                    print(">>> print2");
                    // context.read<LoginBloc>().add(
                    //       LoginEvent.login(
                    //         email: usernameController.text,
                    //         password: passwordController.text,
                    //       ),
                    //     );
                    context.read<LoginBloc>().add(
                          const LoginEvent.login(
                            email: 'indrat@mail.com',
                            password: '123123',
                          ),
                        );
                  },
                  label: 'Masuk',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
