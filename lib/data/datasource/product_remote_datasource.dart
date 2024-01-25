import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'package:image_picker/image_picker.dart';
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/data/datasource/add_product_response_model.dart';
import 'package:laundry_app/data/models/request/product_request_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';

import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/products'),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
      },
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel productRequestModel) async {
    print(">>> jalan");
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/products'));

    request.fields.addAll(productRequestModel.toMap());

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      productRequestModel.image?.path ?? "",
    ));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();
    if (response.statusCode == 201) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }

  Future<Either<String, AddProductResponseModel>> addProductTest(
      ProductRequestModel productRequestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
    };

    final http.MultipartRequest request = _buildAddProductRequest(
        '${Variables.baseUrl}/api/products', productRequestModel, headers);

    try {
      final http.StreamedResponse response = await request.send();
      final String body = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        return right(AddProductResponseModel.fromJson(body));
      } else {
        return left(
            'Failed to add product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return left('Failed to add product. Error: $e');
    }
  }

  http.MultipartFile? _buildMultipartFile(XFile? imageFile, String field) {
    if (imageFile != null && imageFile.path.isNotEmpty) {
      final List<int> fileBytes = File(imageFile.path).readAsBytesSync();
      return http.MultipartFile.fromBytes(
        field,
        fileBytes,
        filename: path.basename(imageFile.path),
      );
    } else {
      print('Warning: Image file is null or path is empty');
      return null;
    }
  }

  http.MultipartRequest _buildAddProductRequest(
    String url,
    ProductRequestModel productRequestModel,
    Map<String, String> headers,
  ) {
    final http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(productRequestModel.toMap());

    final http.MultipartFile? imageMultipartFile =
        _buildMultipartFile(productRequestModel.image, 'image');

    if (imageMultipartFile != null) {
      request.files.add(imageMultipartFile);
    } else {
      print('Image file is not provided.');
    }

    request.headers.addAll(headers);

    return request;
  }

  Future<Either<String, AddProductResponseModel>> addProductTest2(
    ProductRequestModel productRequestModel,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/products'));

    request.fields.addAll(productRequestModel.toMap());

    // Check if the image is provided and not empty before adding it to the request
    if (productRequestModel.image != null &&
        productRequestModel.image!.path.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        productRequestModel.image!.path,
      ));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();
    if (response.statusCode == 201) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
