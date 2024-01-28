import 'package:laundry_app/data/models/response/customer_response_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';

class OrderRequestModel {
  Customer customer;
  int customerID;
  List<OrderItem> orderItems;
  String? transactionTime;
  String cashierName;
  String paymentMethod;
  double amountPayment;
  int totalQuantity;
  double totalPrice;
  int idCashier;
  bool isSync;
  String? status;
  String? statusPayment;

  OrderRequestModel({
    required this.customer,
    this.customerID = 0,
    required this.orderItems,
    this.amountPayment = 0.0,
    this.idCashier = 0,
    this.isSync = false,
    required this.paymentMethod,
    this.totalPrice = 0.0,
    this.totalQuantity = 0,
    this.transactionTime,
    required this.cashierName,
    this.status,
    this.statusPayment,
  });

  Map<String, dynamic> toMap() => {
        "transaction_time": transactionTime,
        "total_price": totalPrice,
        "total_quantity": totalQuantity,
        "payment_method": paymentMethod,
        "customer_id": customerID,
        "amount_payment": amountPayment,
        "cashier_id": idCashier,
        "is_sync": isSync,
        "cashier_name": cashierName,
        "order_items": orderItems.map((item) => item.toMap()).toList(),
        "status": status,
        "status_payment": statusPayment,
      };
}

class OrderItem {
  Product product;
  int quantity;
  int productID;

  OrderItem({
    required this.product,
    this.quantity = 0,
    this.productID = 0,
  });

  Map<String, dynamic> toMap() => {
        "product": product.toMap(),
        "quantity": quantity,
        "product_id": productID,
      };
}


// {
//     "transaction_time": "2024-01-23 10:30:00",
//     "total_price": 235000.0,
//     "total_quantity": 3,
//     "payment_method": "cash",
//     "customer_id": 1,
//     "amount_payment": 250000.0,
//     "cashier_id": 1,
//     "is_sync": 0,
//     "cashier_name": "John Doe",
//     "order_items": [
//         {
//             "product_id": 1,
//             "quantity": 1,
//             "product": {
//                 "name": "Boneka",
//                 "price": 35000,
//                 "working_time": 3,
//                 "category": "satuan",
//                 "image": null
//             }
//         },
//         {
//             "product_id": 2,
//             "quantity": 2,
//             "product": {
//                 "name": "Jaket Kulit",
//                 "price": 100000,
//                 "working_time": 0,
//                 "category": "satuan",
//                 "image": "202401121705028304.jpg"
//             }
//         }
//     ]
// }
