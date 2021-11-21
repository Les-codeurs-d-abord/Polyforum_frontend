class User {
  final String mail;

  const User(this.mail);

  factory User.fromJson(dynamic json) {
    return User(json['email'] as String);
  }

  @override
  String toString() {
    return '{ $mail }';
  }
}
