import 'dart:convert';

class ProductResponseModel {
  final bool success;
  final String message;
  final List<Product> data;

  ProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Product {
  final int? id;
  // final int? productId;
  final String name;
  final String? description;
  final int price;
  final int working_time;
  final String category;
  final String image;
  // final bool isBestSeller;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    // this.productId,
    required this.name,
    this.description,
    required this.price,
    required this.working_time,
    required this.category,
    required this.image,
    // this.isBestSeller = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        // productId: json["product_id"],
        name: json["name"],
        description: json["description"] ?? '',
        price: json["price"],
        working_time: json["working_time"],
        category: json["category"],
        image: json["image"] ?? '',

        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "working_time": working_time,
        "category": category,
        "image": image,
        // "is_best_seller": isBestSeller ? 1 : 0,
        // "product_id": productId,
      };
  Map<String, dynamic> toLocalMap() => {
        "name": name,
        "price": price,
        "working_time": working_time,
        "category": category,
        "image": image,
        // "is_best_seller": isBestSeller ? 1 : 0,
        // "product_id": id,
      };

  Product copyWith({
    int? id,
    // int? productId,
    String? name,
    String? description,
    int? price,
    int? working_time,
    String? category,
    String? image,
    // bool? isBestSeller,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      // productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      working_time: working_time ?? this.working_time,
      category: category ?? this.category,
      image: image ?? this.image,
      // isBestSeller: isBestSeller ?? this.isBestSeller,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.working_time == working_time &&
        other.category == category &&
        other.image == image &&
        // other.isBestSeller == isBestSeller &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        working_time.hashCode ^
        category.hashCode ^
        image.hashCode ^
        // isBestSeller.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
