import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laundry_app/core/componets/buttons.dart';
import 'package:laundry_app/core/componets/custom_dropdown.dart';
import 'package:laundry_app/core/componets/custom_text_field.dart';
import 'package:laundry_app/core/componets/image_picker_widget.dart';
import 'package:laundry_app/core/componets/spaces.dart';
import 'package:laundry_app/core/extensions/string_ext.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';
import 'package:laundry_app/presentation/blocs/product_bloc/product_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? workingTimeController;
  TextEditingController? descriptionController;
  String? selectedCategory;

  String category = 'food';

  XFile? imageFile;

  // bool isBestSeller = false;

  // final List<CategoryModel> categories = [
  //   CategoryModel(name: 'Minuman', value: 'drink'),
  //   CategoryModel(name: 'Makanan', value: 'food'),
  //   CategoryModel(name: 'Snack', value: 'snack'),
  // ];

  final List<String> categories = ["kiloan", "satuan"];

  @override
  void initState() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    workingTimeController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
    workingTimeController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Layanan'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          CustomTextField(
            controller: nameController!,
            label: 'Nama Layanan',
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            controller: priceController!,
            label: 'Harga Layanan',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              // final int priceValue = value.toIntegerFromText;
              // priceController.text = priceValue.currencyFormatRp;
              // priceController.selection = TextSelection.fromPosition(
              //     TextPosition(offset: priceController.text.length));
            },
          ),
          const SpaceHeight(20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kategori Layanan",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              RadioListTile(
                title: Text("Kiloan"),
                value: "kiloan",
                groupValue: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text("Satuan"),
                value: "satuan",
                groupValue: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value.toString();
                  });
                },
              ),
            ],
          ),

          const SpaceHeight(12.0),
          ImagePickerWidget(
            label: 'Foto Layanan',
            onChanged: (file) {
              if (file == null) {
                return;
              }
              imageFile = file as XFile?;
            },
          ),
          const SpaceHeight(20.0),
          CustomTextField(
            controller: workingTimeController!,
            label: 'Waktu Pengerjaan',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(20.0),
          //isBestSeller
          // Row(
          //   children: [
          //     Checkbox(
          //       value: isBestSeller,
          //       onChanged: (value) {
          //         setState(() {
          //           isBestSeller = value!;
          //         });
          //       },
          //     ),
          //     const Text('Produk Terlaris'),
          //   ],
          // ),
          const SpaceHeight(20.0),
          // CustomDropdown<CategoryModel>(
          //   value: categories.first,
          //   items: categories,
          //   label: 'Kategori',
          //   onChanged: (value) {
          //     category = value!.value;
          //   },
          // ),
          const SpaceHeight(24.0),
          BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (_) {
                  Navigator.pop(context);
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, success: (_) {
                return Button.filled(
                  onPressed: () {
                    final String name = nameController!.text;
                    final int price = priceController!.text.toIntegerFromText;
                    final int workingTime =
                        workingTimeController!.text.toIntegerFromText;
                    final String description = descriptionController!.text;
                    final Product product = Product(
                        name: name,
                        price: price,
                        working_time: workingTime,
                        description: description,
                        category: category,
                        image: imageFile!.path);
                    context
                        .read<ProductBloc>()
                        .add(ProductEvent.addProduct(product, imageFile!));
                  },
                  label: 'Simpan',
                );
              });
            },
          ),
          const SpaceHeight(30.0),
          Button.outlined(
            onPressed: () {
              Navigator.pop(context);
            },
            label: 'Batal',
          ),
          const SpaceHeight(30.0),
        ],
      ),
    );
  }
}
