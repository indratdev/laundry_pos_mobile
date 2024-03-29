import 'dart:convert';

import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';

class OrderResponseModel {
  final bool success;
  final String message;
  final OrderData data;
  // final OrderResponseItem data;

  OrderResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      success: json['success'],
      message: json['message'],
      data: OrderData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      // 'data': data.toMap(),
    };
  }

  // factory OrderResponseModel.fromJson(String str) =>
  //     OrderResponseModel.fromMap(json.decode(str));

  // String toJson() => json.encode(toMap());

  // factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
  //     OrderResponseModel(
  //       success: json["success"],
  //       message: json["message"],
  //       data: List<OrderResponseItem>.from(
  //           json["data"].map((x) => OrderResponseItem.fromMap(x))),
  //     );

  // Map<String, dynamic> toMap() => {
  //       "success": success,
  //       "message": message,
  //       "data": List<dynamic>.from(data.map((x) => x.toMap())),
  //     };
}

class OrderData {
  final OrderResponseItem order;
  final List<OrderItem> orderItems;

  OrderData({
    required this.order,
    required this.orderItems,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: OrderResponseItem.fromJson(json['order']),
      orderItems: List<OrderItem>.from(
        json['order_items'].map((item) => OrderItem.fromJson(item)),
      ),
    );
  }
}

class OrderResponseItem {
  final String transaction_time;
  final double total_price;
  final int total_quantity;
  final String payment_method;
  final int customer_id;
  final double amount_payment;
  final int cashier_id;
  final int is_sync;
  final String cashier_name;
  final String updated_at;
  final String created_at;
  final int id;
  final Customer? customers;
  final String? status;
  final String? statusPayment;

  OrderResponseItem({
    this.transaction_time = "",
    this.amount_payment = 0.0,
    this.cashier_id = 0,
    this.cashier_name = "",
    this.created_at = "",
    this.customer_id = 0,
    this.id = 0,
    this.is_sync = 0,
    this.payment_method = "",
    this.total_price = 0.0,
    this.total_quantity = 0,
    this.updated_at = "",
    this.customers,
    this.status,
    this.statusPayment,
  });

  factory OrderResponseItem.fromJson(Map<String, dynamic> json) {
    return OrderResponseItem(
      id: json["id"],
      amount_payment: json["amount_payment"].toDouble(),
      cashier_id: json["cashier_id"],
      cashier_name: json["cashier_name"],
      customer_id: json["customer_id"],
      is_sync: json["is_sync"] == 1 ? 1 : 0, // Convert to integer,
      payment_method: json["payment_method"],
      total_price: json["total_price"].toDouble(),
      total_quantity: json["total_quantity"],
      transaction_time: json["transaction_time"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
      customers: json["customers"],
      status: json["status"],
      statusPayment: json["status_payment"],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderResponseItem.fromMap(Map<String, dynamic> json) =>
      OrderResponseItem(
        id: json["id"],
        amount_payment: json["amount_payment"],
        cashier_id: json["cashier_id"],
        cashier_name: json["cashier_name"],
        customer_id: json["customer_id"],
        is_sync: json["is_sync"],
        payment_method: json["payment_method"],
        total_price: json["total_price"],
        total_quantity: json["total_quantity"],
        transaction_time: json["transaction_time"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        customers: json["customers"],
        status: json["status"],
        statusPayment: json["status_payment"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount_payment": amount_payment,
        "cashier_id": cashier_id,
        "cashier_name": cashier_name,
        "customer_id": customer_id,
        "is_sync": is_sync,
        "payment_method": payment_method,
        "total_price": total_price,
        "total_quantity": total_quantity,
        "transaction_time": transaction_time,
        "created_at": created_at,
        "updated_at": updated_at,
        "customers": customers,
        "status": status,
        "status_payment": statusPayment,
      };
}

// class OrderItem {
//   int id;
//   int orderId;
//   int productId;
//   int quantity;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Product? product;

//   OrderItem({
//     required this.id,
//     required this.orderId,
//     required this.productId,
//     required this.quantity,
//     required this.createdAt,
//     required this.updatedAt,
//     this.product,
//   });

//   factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
//         id: json["id"],
//         orderId: json["order_id"],
//         productId: json["product_id"],
//         quantity: json["quantity"],
//         product: Product.fromMap(json['product']),
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "order_id": orderId,
//         "product_id": productId,
//         "quantity": quantity,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// OLD
class OrderItem {
  final int productId;
  final int quantity;
  final Product product;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        productId: json['product_id'],
        quantity: json['quantity'],
        // product: Product.fromJson(json['product']),
        product: Product.fromMap(json['product']));
  }
}
