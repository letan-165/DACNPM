class UserSignUpRequest {
  final String username;
  final String name;
  final String password;
  final String email;

  UserSignUpRequest({
    required this.username,
    required this.name,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'password': password,
      'email': email,
    };
  }
}
