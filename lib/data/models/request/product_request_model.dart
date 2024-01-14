

import 'package:image_picker/image_picker.dart';

class ProductRequestModel {
  final String name;
  final int price;
  final int working_time;
  final String category;
  // final int isBestSeller;
  final XFile image;
  ProductRequestModel({
    required this.name,
    required this.price,
    required this.working_time,
    required this.category,
    // required this.isBestSeller,
    required this.image,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'price': price.toString(),
      'working_time': working_time.toString(),
      'category': category,
      // 'isBestSeller': isBestSeller.toString(),
    };
  }
}
