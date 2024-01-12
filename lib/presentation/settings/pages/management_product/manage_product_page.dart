import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/componets/spaces.dart';
import '../../../../data/models/product_category.dart';
import '../../../../data/models/product_model.dart';

class ManageProductPage extends StatefulWidget {
  const ManageProductPage({super.key});

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  final List<ProductModel> products = [
    ProductModel(
      image: '',
      name: 'Vanila Late Vanila itu',
      category: ProductCategory.kiloan,
      price: 200000,
      stock: 10,
    ),
    ProductModel(
      image: '',
      name: 'V60',
      category: ProductCategory.satuan,
      price: 1200000,
      stock: 10,
    ),
    ProductModel(
      image: '',
      name: 'Americano',
      category: ProductCategory.kiloan,
      price: 2100000,
      stock: 10,
    ),
    ProductModel(
      image: '',
      name: 'Cappucino',
      category: ProductCategory.kiloan,
      price: 200000,
      stock: 10,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'List Produk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(20.0),
          // BlocBuilder<ProductBloc, ProductState>(
          //   builder: (context, state) {
          //     return state.maybeWhen(orElse: () {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }, success: (products) {
          //       return ListView.separated(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemCount: products.length,
          //         separatorBuilder: (context, index) => const SpaceHeight(20.0),
          //         itemBuilder: (context, index) => MenuProductItem(
          //           data: products[index],
          //         ),
          //       );
          //     });
          //     // return ListView.separated(
          //     //   shrinkWrap: true,
          //     //   physics: const NeverScrollableScrollPhysics(),
          //     //   itemCount: products.length,
          //     //   separatorBuilder: (context, index) => const SpaceHeight(20.0),
          //     //   itemBuilder: (context, index) => MenuProductItem(
          //     //     data: products[index],
          //     //   ),
          //     // );
          //   },
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // onPressed: () {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return const AddProductPage();
        //   }));
        // },
        child: const Icon(Icons.add),
      ),
    );
  }
}
