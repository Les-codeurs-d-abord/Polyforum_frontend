abstract class User {
  final String email;
  final String role;

  const User({
    required this.email,
    required this.role,
  });

  @override
  String toString() {
    return "Email: $email, Role: $role";
  }
}
