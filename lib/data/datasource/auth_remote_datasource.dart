import 'dart:async';
import 'dart:convert';

import '../../core/constants/variables.dart';
import '../models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class AuthRemoteDatasource {
  // Future<Either<String, AuthResponseModel>> login(
  //   String email,
  //   String password,
  // ) async {
  //   final response = await http.post(
  //     Uri.parse('${Variables.baseUrl}/api/login'),
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).timeout(const Duration(seconds: 10));
  //   print(">>> resposne : ${response.statusCode}");

  //   try {
  //     if (response.statusCode == 200) {
  //       return right(AuthResponseModel.fromJson(response.body));
  //     } else {
  //       final Map<String, dynamic> message = jsonDecode(response.body);
  //       return left(message.values.first.toString());
  //     }
  //   } on TimeoutException catch (err) {
  //     print(">>> TimeoutException Remote : $err");
  //     return left("Request Timeout : $err");
  //   } catch (e) {
  //     return left("General Error");
  //   }
  // }

  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    try {
      
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      ).timeout(const Duration(seconds: 60));


      if (response.statusCode == 200) {
        return right(AuthResponseModel.fromJson(response.body));
      } else {
        final Map<String, dynamic> message = jsonDecode(response.body);
        return left(message.values.first.toString());
      }
    } on TimeoutException catch (_) {
      
      return left("Request Timeout");
    } catch (e) {
      
      return left("General Error: $e");
    }
  }

  // Future<Either<String, String>> logout() async {
  //   final authData = await AuthLocalDatasource().getAuthData();
  //   final response = await http.post(
  //     Uri.parse('${Variables.baseUrl}/api/logout'),
  //     headers: {
  //       'Authorization': 'Bearer ${authData.token}',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     return right(response.body);
  //   } else {
  //     return left(response.body);
  //   }
  // }
}
