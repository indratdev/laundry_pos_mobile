import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/data/datasource/add_product_response_model.dart';
import 'package:laundry_app/data/models/request/product_request_model.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';

import 'auth_local_datasource.dart';

class CustomerRemoteDatasource {
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

  // Future<Either<String, AddProductResponseModel>> addProduct(
  //     ProductRequestModel productRequestModel) async {
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final Map<String, String> headers = {
  //     'Authorization': 'Bearer ${authData.token}',
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('${Variables.baseUrl}/api/products'));
  //   request.fields.addAll(productRequestModel.toMap());
  //   request.files.add(await http.MultipartFile.fromPath(
  //       'image', productRequestModel.image.path));
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   final String body = await response.stream.bytesToString();

  //   if (response.statusCode == 201) {
  //     return right(AddProductResponseModel.fromJson(body));
  //   } else {
  //     return left(body);
  //   }
  // }
}
