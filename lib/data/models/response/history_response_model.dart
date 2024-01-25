import 'dart:convert';

class HistoryResponseModel {
  bool success;
  String message;
  List<HistoryData> data;

  HistoryResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryResponseModel.fromJson(String str) =>
      HistoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryResponseModel.fromMap(Map<String, dynamic> json) =>
      HistoryResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<HistoryData>.from(
            json["data"].map((x) => HistoryData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class HistoryData {
  int id;
  DateTime transactionTime;
  String totalPrice;
  int totalQuantity;
  int cashierId;
  String paymentMethod;
  int customerId;
  String amountPayment;
  int isSync;
  String cashierName;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderItem> orderItems;

  HistoryData({
    required this.id,
    required this.transactionTime,
    required this.totalPrice,
    required this.totalQuantity,
    required this.cashierId,
    required this.paymentMethod,
    required this.customerId,
    required this.amountPayment,
    required this.isSync,
    required this.cashierName,
    required this.createdAt,
    required this.updatedAt,
    required this.orderItems,
  });

  factory HistoryData.fromJson(String str) =>
      HistoryData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryData.fromMap(Map<String, dynamic> json) => HistoryData(
        id: json["id"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        totalPrice: json["total_price"],
        totalQuantity: json["total_quantity"],
        cashierId: json["cashier_id"],
        paymentMethod: json["payment_method"],
        customerId: json["customer_id"],
        amountPayment: json["amount_payment"],
        isSync: json["is_sync"],
        cashierName: json["cashier_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "transaction_time": transactionTime.toIso8601String(),
        "total_price": totalPrice,
        "total_quantity": totalQuantity,
        "cashier_id": cashierId,
        "payment_method": paymentMethod,
        "customer_id": customerId,
        "amount_payment": amountPayment,
        "is_sync": isSync,
        "cashier_name": cashierName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toMap())),
      };
}

class OrderItem {
  int id;
  int orderId;
  int productId;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

// enum PaymentMethod {
//     CASH
// }

// final paymentMethodValues = EnumValues({
//     "cash": PaymentMethod.CASH
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     late Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         reverseMap = map.map((k, v) => MapEntry(v, k));
//         return reverseMap;
//     }
// }
