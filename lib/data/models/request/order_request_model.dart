import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';

class OrderRequestModel {
  Customer customer;
  List<OrderItem> orderItems;

  String paymentMethod;
  double amountPayment;
  int totalQuantity;
  double totalPrice;
  int idCashier;
  String nameCashier;
  bool isSync;

  OrderRequestModel({
    required this.customer,
    required this.orderItems,
    this.amountPayment = 0.0,
    this.idCashier = 0,
    this.isSync = false,
    required this.nameCashier,
    required this.paymentMethod,
    this.totalPrice = 0.0,
    this.totalQuantity = 0,
  });

  Map<String, dynamic> toMap() => {
        "customer": customer.toMap(),
        // "orderItems": orderItems,
        "orderItems": orderItems.map((item) => item.toMap()).toList(),
        "amountPayment": amountPayment,
        "idCashier": idCashier,
        "isSync": isSync,
        "nameCashier": nameCashier,
        "paymentMethod": paymentMethod,
        "totalPrice": totalPrice,
        "totalQuantity": totalQuantity,
      };
}

class OrderItem {
  Product product;
  int quantity;

  OrderItem({
    required this.product,
    this.quantity = 0,
  });

  Map<String, dynamic> toMap() => {
        "product": product.toMap(),
        "quantity": quantity,
      };
}
