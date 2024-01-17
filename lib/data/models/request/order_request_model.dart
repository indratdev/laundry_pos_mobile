import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';

class OrderRequestModel {
  Customer customer;
  List<OrderItem> orderItems;

  OrderRequestModel({
    required this.customer,
    required this.orderItems,
  });

  Map<String, dynamic> toMap() => {
        "customer": customer.toMap(),
        "orderItems": orderItems,
      };
}

class OrderItem {
  Product product;
  int quantity;
  double price;

  OrderItem({
    required this.product,
    required this.quantity,
    required this.price,
  });
}
