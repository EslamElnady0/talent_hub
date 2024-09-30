class PlayerModel {
  String uId;
  String name;
  String position;
  int age;
  String email;
  String image;
  String phone;

  PlayerModel({
    required this.uId,
    required this.name,
    required this.position,
    required this.age,
    required this.email,
    required this.image,
    required this.phone,
  });

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      uId: map['uId'],
      name: map['name'],
      position: map['position'],
      age: map['age'] ?? 0,
      email: map['email'],
      image: map['image'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'position': position,
      'age': age,
      'email': email,
      'image': image,
      'phone': phone,
    };
  }
}
