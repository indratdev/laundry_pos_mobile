// import 'dart:convert';

// class OrderResponseModel {
//   final bool success;
//   final String message;
  
//   final OrderResponseItem data;

//   OrderResponseModel({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
//     return OrderResponseModel(
//       success: json['success'],
//       message: json['message'],
//       data: OrderResponseItem.fromJson(json['data']),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'success': success,
//       'message': message,
//       'data': data.toMap(),
//     };
//   }

//   // factory OrderResponseModel.fromJson(String str) =>
//   //     OrderResponseModel.fromMap(json.decode(str));

//   // String toJson() => json.encode(toMap());

//   // factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
//   //     OrderResponseModel(
//   //       success: json["success"],
//   //       message: json["message"],
//   //       data: List<OrderResponseItem>.from(
//   //           json["data"].map((x) => OrderResponseItem.fromMap(x))),
//   //     );

//   // Map<String, dynamic> toMap() => {
//   //       "success": success,
//   //       "message": message,
//   //       "data": List<dynamic>.from(data.map((x) => x.toMap())),
//   //     };
// }

// class OrderResponseItem {
//   final String transaction_time;
//   final double total_price;
//   final int total_quantity;
//   final String payment_method;
//   final int customer_id;
//   final double amount_payment;
//   final int cashier_id;
//   final int is_sync;
//   final String cashier_name;
//   final String updated_at;
//   final String created_at;
//   final int id;

//   OrderResponseItem({
//     this.transaction_time = "",
//     this.amount_payment = 0.0,
//     this.cashier_id = 0,
//     this.cashier_name = "",
//     this.created_at = "",
//     this.customer_id = 0,
//     this.id = 0,
//     this.is_sync = 0,
//     this.payment_method = "",
//     this.total_price = 0.0,
//     this.total_quantity = 0,
//     this.updated_at = "",
//   });

//   // factory OrderResponseItem.fromJson(String str) =>
//   //     OrderResponseItem.fromMap(json.decode(str));

//   factory OrderResponseItem.fromJson(Map<String, dynamic> json) {
//     return OrderResponseItem(
//       id: json["id"],
//       amount_payment: json["amount_payment"].toDouble(),
//       cashier_id: json["cashier_id"],
//       cashier_name: json["cashier_name"],
//       customer_id: json["customer_id"],
//       is_sync: json["is_sync"] == 1 ? 1 : 0, // Convert to integer,
//       payment_method: json["payment_method"],
//       total_price: json["total_price"].toDouble(),
//       total_quantity: json["total_quantity"],
//       transaction_time: json["transaction_time"],
//       created_at: json["created_at"],
//       updated_at: json["updated_at"],

//       // success: json['success'],
//       // message: json['message'],
//       // data: OrderResponseItem.fromJson(json['data']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory OrderResponseItem.fromMap(Map<String, dynamic> json) =>
//       OrderResponseItem(
//         id: json["id"],
//         amount_payment: json["amount_payment"],
//         cashier_id: json["cashier_id"],
//         cashier_name: json["cashier_name"],
//         customer_id: json["customer_id"],
//         is_sync: json["is_sync"],
//         payment_method: json["payment_method"],
//         total_price: json["total_price"],
//         total_quantity: json["total_quantity"],
//         transaction_time: json["transaction_time"],
//         created_at: json["created_at"],
//         updated_at: json["updated_at"],

//         // name: json["name"],
//         // email: json["email"] ?? '',
//         // phone: json["phone"] ?? '',
//         // address: json["address"] ?? '',
//         // project_id: json["project_id"] ?? '',
//         // createdAt: DateTime.parse(json["created_at"]),
//         // updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "amount_payment": amount_payment,
//         "cashier_id": cashier_id,
//         "cashier_name": cashier_name,
//         "customer_id": customer_id,
//         "is_sync": is_sync,
//         "payment_method": payment_method,
//         "total_price": total_price,
//         "total_quantity": total_quantity,
//         "transaction_time": transaction_time,
//         "created_at": created_at,
//         "updated_at": updated_at,
//       };
//   // Map<String, dynamic> toLocalMap() => {
//   //       "id": id,
//   //       "name": name,
//   //       "email": email,
//   //       "phone": phone,
//   //       "address": address,
//   //       "project_id": project_id,
//   //     };
// }

// // {
// //     "success": true,
// //     "message": "Order Created",
// //     "data": {
// //         "transaction_time": "2024-01-23 10:30:00",
// //         "total_price": 235000,
// //         "total_quantity": 3,
// //         "payment_method": "cash",
// //         "customer_id": 1,
// //         "amount_payment": 250000,
// //         "cashier_id": 1,
// //         "is_sync": 0,
// //         "cashier_name": "John Doe",
// //         "updated_at": "2024-01-22T07:19:32.000000Z",
// //         "created_at": "2024-01-22T07:19:32.000000Z",
// //         "id": 3
// //     }
// // }