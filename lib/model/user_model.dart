class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String place;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.place,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      place: map['place'] ?? '',
    );
  }
}
