import 'dart:convert';

class CustomerResponseModel {
  final bool success;
  final String message;
  final List<Customer> data;

  CustomerResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CustomerResponseModel.fromJson(String str) =>
      CustomerResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerResponseModel.fromMap(Map<String, dynamic> json) =>
      CustomerResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Customer>.from(json["data"].map((x) => Customer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Customer {
  final int? id;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? project_id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Customer({
    this.id,
    required this.name,
    this.email = "",
    this.phone = "",
    this.address = "",
    this.project_id = "",
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(String str) => Customer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        address: json["address"] ?? '',
        project_id: json["project_id"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "project_id": project_id,
      };
  Map<String, dynamic> toLocalMap() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "project_id": project_id,
      };

  Customer copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? project_id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      project_id: project_id ?? this.project_id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Customer &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.address == address &&
        other.project_id == project_id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        project_id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
