

import 'package:laundry_app/data/models/response/product_response_model.dart';
import 'dart:convert';

class AddProductResponseModel {
  final bool success;
  final String message;
  final Product data;

  AddProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddProductResponseModel.fromJson(String str) =>
      AddProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProductResponseModel.fromMap(Map<String, dynamic> json) =>
      AddProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: Product.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}
