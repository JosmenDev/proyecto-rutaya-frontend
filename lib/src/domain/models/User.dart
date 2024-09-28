import 'package:indriver_clone_flutter/src/domain/models/Role.dart';

class User {
  int? id;
  String name;
  String phone;
  String? email;
  String? password;
  String? image;
  dynamic? notificationToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Role>? roles;

  User({
    this.id,
    required this.name,
    required this.phone,
    this.email,
    this.password,
    this.image,
    this.notificationToken,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        notificationToken: json["notification_token"],
        roles: json["roles"] != null
            ? List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "image": image,
        "notification_token": notificationToken,
        "roles": roles != null
            ? List<dynamic>.from(roles!.map((x) => x.toJson()))
            : [],
      };
}
