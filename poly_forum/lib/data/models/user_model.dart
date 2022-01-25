abstract class User {
  final int id;
  String email;
  String role;

  User({
    required this.id,
    required this.email,
    required this.role,
  });

  @override
  String toString() {
    return "Id: $id, Email: $email, Role: $role";
  }
}
