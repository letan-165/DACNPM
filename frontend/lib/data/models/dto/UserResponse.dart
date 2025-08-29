class UserResponse {
  final String userID;
  final String username;
  final String name;
  final String email;
  final String role;

  UserResponse({
    required this.userID,
    required this.username,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userID: json['userID'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'username': username,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
