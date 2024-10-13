class UserModel {
  String id;
  String name;
  String phone;
  String age;
  String email;
  String position;
  String role;
  String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.email,
    required this.position,
    required this.role,
    this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      age: json['age'] as String,
      email: json['email'] as String,
      position: json['position'] as String,
      role: json['role'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'age': age,
      'email': email,
      'position': position,
      'role': role,
      'imageUrl': imageUrl,
    };
  }
}
