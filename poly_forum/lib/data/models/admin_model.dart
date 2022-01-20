import 'package:poly_forum/data/models/user_model.dart';

class AdminUser extends User {
  AdminUser({
    required id,
    required email,
    required role,
  }) : super(id: id, email: email, role: role);

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json["id"],
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'ADMIN',
    );
  }
}
