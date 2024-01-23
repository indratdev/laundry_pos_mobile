import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:laundry_app/core/constants/variables.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart';
import 'package:laundry_app/data/models/response/order_response_model.dart';

class OrderRemoteDataSource {
  final urlOrder = "${Variables.baseUrl}/api/orders";
  // Future<Either<String, ProductResponseModel>> getProducts() async {
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final response = await http.get(
  //     Uri.parse('${Variables.baseUrl}/api/products'),
  //     headers: {
  //       'Authorization': 'Bearer ${authData.token}',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return right(ProductResponseModel.fromJson(response.body));
  //   } else {
  //     return left(response.body);
  //   }
  // }

  // Future<Either<String, AddProductResponseModel>> addOrder(
  //     OrderRequestModel orderRequestModel) async {
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final Map<String, String> headers = {
  //     'Authorization': 'Bearer ${authData.token}',
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('${Variables.baseUrl}/api/orders'));

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
  // create facility
  // Future<Either<String, OrderResponseModel>> addOrder(
  //     String token, OrderRequestModel orderRequestModel) async {
  //   print(">>> masuk");
  //   log(">>> datas : ${orderRequestModel.toMap()}");
  //   print(">>> url : ${urlOrder}");
  //   // final data = {
  //   //   orderRequestModel.toMap(),
  //   // };

  //   // print(">>> data : ${data}");

  //   // final response = await http.post(
  //   //   Uri.parse(urlOrder),
  //   //   headers: {
  //   //     'Content-Type': 'application/json; charset=UTF-8',
  //   //     'authorization': "Bearer $token"
  //   //   },
  //   //   body: jsonEncode(orderRequestModel.toMap()),
  //   //   // body: orderRequestModel.toMap(),
  //   // );

  //   // print(">>> Raw response body: ${response.body}");

  //   // Map<String, dynamic> json;
  //   // try {
  //   //   json = jsonDecode(response.body);
  //   // } catch (e) {
  //   //   print(">>> JSON decoding error: $e");
  //   // }

  //   // // Map<String, dynamic> json = jsonDecode(response.body);

  //   // print(">>> Response code: ${response.statusCode}");

  //   // if (response.statusCode == 200) {
  //   //   // var dataModel = json["data"];
  //   //   OrderResponseModel result = OrderResponseModel.fromMap(json);
  //   //   return Right(result);
  //   // } else {
  //   //   return Left("Error : ${json["error"]["message"]}");
  //   // }

  //   final response = await http.post(
  //     Uri.parse(urlOrder),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'authorization': "Bearer $token"
  //     },
  //     body: jsonEncode(orderRequestModel.toMap()),
  //   );

  //   print(">>> Raw response body: ${response.body}");

  //   Map<String, dynamic>? json = null; // Initialize to null

  //   try {
  //     json = jsonDecode(response.body);
  //   } catch (e) {
  //     print(">>> JSON decoding error: $e");
  //   }

  //   print(">>> Response code: ${response.statusCode}");

  //   if (response.statusCode == 200) {
  //     if (json != null) {
  //       OrderResponseModel result = OrderResponseModel.fromMap(json);
  //       return Right(result);
  //     } else {
  //       return Left("Error: Unable to decode JSON response");
  //     }
  //   } else {
  //     if (json != null &&
  //         json.containsKey("error") &&
  //         json["error"].containsKey("message")) {
  //       return Left("Error: ${json["error"]["message"]}");
  //     } else {
  //       return Left("Error: ${response.statusCode}");
  //     }
  //   }
  // }

  // create categoryRoom
  Future<Either<String, OrderResponseModel>> addOrder(
      String token, OrderRequestModel model) async {
    final response = await http.post(
      Uri.parse(urlOrder),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'authorization': "Bearer $token"
      },
      body: jsonEncode(model.toMap()),
    );

    log(">>> response : ${response.body}");
    log(">>> response : ${response.statusCode}");

    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      OrderResponseModel result = OrderResponseModel.fromJson(json);
      return Right(result);
    } else {
      return Left("Error : ${json["error"]["message"]}");
    }
  }
}
