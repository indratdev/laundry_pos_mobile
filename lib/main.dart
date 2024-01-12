import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/data/datasource/auth_remote_datasource.dart';
import 'package:laundry_app/presentation/auth/login/login_page.dart';
import 'package:laundry_app/presentation/blocs/login_bloc/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
           appBarTheme: AppBarTheme(
            backgroundColor: AppColors.yellow,
          ),
        ),
        home: LoginPage(),
      ),
    );
  }
}