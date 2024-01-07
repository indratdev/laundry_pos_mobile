import 'dart:convert';


import '../../core/constants/variables.dart';
import '../models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';


class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    print(">>> resposne : ${response.statusCode}");
    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      final Map<String, dynamic> message = jsonDecode(response.body);
      return left(message.values.first.toString());
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
