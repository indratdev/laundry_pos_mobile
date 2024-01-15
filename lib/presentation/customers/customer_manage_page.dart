import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/colors.dart';

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
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Ketikan nama anda",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.blueLight),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                      hintText: "Ketikan email anda",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.blueLight),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                      hintText: "Ketikan telepon anda",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.blueLight),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: TextFormField(
                    controller: addressController,
                    // expands: true,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      hintText: "Ketikan alamat anda",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.blueLight),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: (MediaQuery.sizeOf(context).width / 2) - 50,
                      child: ElevatedButton(
                        onPressed: () {
                          clearData();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.sizeOf(context).width / 2) - 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Simpan"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
