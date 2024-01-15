class CustomerRequestModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String project_id;

  CustomerRequestModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.project_id,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'project_id': project_id,
    };
  }
}
