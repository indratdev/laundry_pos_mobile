import 'dart:convert';

import 'package:laundry_app/data/models/response/customer_response_model.dart';

class AddCustomerResponseModel {
  final bool success;
  final String message;
  final Customer data;

  AddCustomerResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddCustomerResponseModel.fromJson(String str) =>
      AddCustomerResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddCustomerResponseModel.fromMap(Map<String, dynamic> json) =>
      AddCustomerResponseModel(
        success: json["success"],
        message: json["message"],
        data: Customer.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}
