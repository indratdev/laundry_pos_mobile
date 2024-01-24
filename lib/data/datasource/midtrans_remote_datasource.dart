import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:laundry_app/data/datasource/auth_local_datasource.dart';
import 'package:laundry_app/data/models/response/qris_response_model.dart';
import 'package:laundry_app/data/models/response/qris_status_response_model.dart';

class MidtransRemoteDatasource {
  String urlSandBox = "https://api.sandbox.midtrans.com/v2/charge";
  // String urlStatusSandBox =
  //     "https://api.sandbox.midtrans.com/v2/[ORDER_ID]/status";
  // String serverKeySandBox = "SB-Mid-server-eBEW4sxUMQjrWqrGfllsRqE9";

  String generateBasicAuthHeader(String serverKey) {
    final base64Credentials = base64Encode(utf8.encode('$serverKey:'));
    final authHeader = 'Basic $base64Credentials';

    return authHeader;
  }

  Future<QrisResponseModel> generateQRCode(
      String orderId, double grossAmount) async {
    final serverKey = await AuthLocalDatasource().getMitransServerKey();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': generateBasicAuthHeader(serverKey),
      // 'Authorization': generateBasicAuthHeader(serverKeySandBox),
    };

    final body = jsonEncode({
      'payment_type': 'gopay',
      'transaction_details': {
        'gross_amount': grossAmount,
        'order_id': orderId,
      },
    });

    final response = await http.post(
      // Uri.parse('https://api.midtrans.com/v2/charge'),
      Uri.parse(urlSandBox),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return QrisResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to generate QR Code');
    }
  }

  Future<QrisStatusResponseModel> checkPaymentStatus(String orderId) async {
    final serverKey = await AuthLocalDatasource().getMitransServerKey();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      // 'Authorization': generateBasicAuthHeader(serverKeySandBox),
      'Authorization': generateBasicAuthHeader(serverKey),
    };

    final response = await http.get(
      // Uri.parse('https://api.midtrans.com/v2/$orderId/status'),
      Uri.parse('https://api.sandbox.midtrans.com/v2/$orderId/status'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return QrisStatusResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to check payment status');
    }
  }
}
