import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_app/core/constants/colors.dart';
import 'package:laundry_app/data/models/request/customer_request_model.dart';
import 'package:laundry_app/presentation/blocs/customer_bloc/customer_bloc.dart';
import 'package:laundry_app/presentation/home/home_page.dart';
import 'package:laundry_app/presentation/widgets/custom_dialogs.dart';

class CustomerManagePage extends StatefulWidget {
  bool isNew;

  CustomerManagePage({
    super.key,
    this.isNew = true,
  });

  @override
  State<CustomerManagePage> createState() => _CustomerManagePageState();
}

class _CustomerManagePageState extends State<CustomerManagePage> {
  final _formKeyCustomer = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  clearData() {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    addressController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (widget.isNew)
            ? const Text("Tambah Pelanggan")
            : const Text("Ubah Pelanggan"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyCustomer,
          child: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              state.maybeWhen(
                  orElse: () => const CircularProgressIndicator.adaptive(),
                  loading: () => const CircularProgressIndicator.adaptive(),
                  successAddCustomer: (customer) {
                    Future.delayed(Duration.zero, () {
                      return CustomDialogs().showMessageAlert(
                          context,
                          "Data Pelanggan Berhasil ditambahkan",
                          StatusImage.success,
                          () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              )));
                    });
                  });
              return Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap diisi !';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Ketikan nama anda",
                          // hintText: "Ketikan nama anda",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blueLight),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Ketikan email anda",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blueLight),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          labelText: "Ketikan telepon anda",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blueLight),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: TextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harap diisi !';
                          }
                          return null;
                        },
                        // expands: true,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          labelText: "Ketikan alamat anda",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.blueLight),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: (MediaQuery.sizeOf(context).width / 3),
                          child: ElevatedButton(
                            onPressed: () {
                              clearData();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Batal",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: AppColors.middleBlueColor,
                            ),
                            child: const Text(
                              "Simpan",
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKeyCustomer.currentState!.validate()) {
                                CustomerRequestModel data =
                                    CustomerRequestModel(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  address: addressController.text,
                                  project_id: "",
                                );

                                context
                                    .read<CustomerBloc>()
                                    .add(CustomerEvent.addCustomer(data));
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
