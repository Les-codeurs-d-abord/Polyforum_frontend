import 'package:poly_forum/data/models/user_model.dart';

class AdminUser extends User {
  const AdminUser({
    required email,
    required role,
  }) : super(email: email, role: role);

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      email: json['user']['email'] ?? '',
      role: json['user']['role'] ?? 'ADMIN',
    );
  }
}
