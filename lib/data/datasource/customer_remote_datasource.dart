import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/data/datasource/add_customer_response_model.dart';
import 'package:laundry_app/data/models/request/customer_request_model.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';

import 'auth_local_datasource.dart';

class CustomerRemoteDatasource {
  final urlCustomer = "${Variables.baseUrl}/api/customers";

  Future<Either<String, CustomerResponseModel>> getAllCustomer() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/customers'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      return right(CustomerResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, AddCustomerResponseModel>> addCustomer(
      CustomerRequestModel customerRequestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'authorization': "Bearer ${authData.token}"
    };

    print(">>> url ${urlCustomer}");

    final response = await http.post(
      Uri.parse(urlCustomer),
      headers: headers,
      body: jsonEncode(customerRequestModel.toMap()),
    );

    print(response.body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return right(AddCustomerResponseModel.fromJson(response.body));
    } else {
      print("Error");
      print(response.body);
      return throw left(Exception('Failed to add customer'));
    }
  }
}
