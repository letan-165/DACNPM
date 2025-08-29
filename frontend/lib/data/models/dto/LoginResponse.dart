class LoginResponse {
  final String userID;
  final String name;
  final String token;

  LoginResponse({
    required this.userID,
    required this.name,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userID: json['userID'] ?? '',
      name: json['name'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'token': token,
    };
  }
}
