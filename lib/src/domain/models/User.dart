import 'package:indriver_clone_flutter/src/domain/models/Role.dart';

class User {
  int id;
  String name;
  String phone;
  String email;
  dynamic image;
  dynamic notificationToken;
  DateTime createdAt;
  DateTime updatedAt;
  bool isActive;
  List<Role> roles;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
    required this.notificationToken,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
        notificationToken: json["notification_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isActive: json["isActive"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "image": image,
        "notification_token": notificationToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "isActive": isActive,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}
