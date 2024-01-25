import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/data/datasource/auth_remote_datasource.dart';
import 'package:laundry_app/data/datasource/customer_remote_datasource.dart';
import 'package:laundry_app/data/datasource/midtrans_remote_datasource.dart';
import 'package:laundry_app/data/datasource/order_remote_datasource.dart';
import 'package:laundry_app/data/datasource/product_remote_datasource.dart';
import 'package:laundry_app/presentation/auth/login/login_page.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';
import 'package:laundry_app/presentation/blocs/history_bloc/history_bloc.dart';
import 'package:laundry_app/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:laundry_app/presentation/blocs/product_bloc/product_bloc.dart';
import 'package:laundry_app/presentation/blocs/qris_bloc/qris_bloc.dart';

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
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => CustomerBloc(CustomerRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(OrderRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => QrisBloc(MidtransRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.middleBlueColor,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: AppColors.yellow,
            )),
        home: const LoginPage(),
      ),
    );
  }
}
