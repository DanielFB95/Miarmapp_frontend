class LoginResponse {
  LoginResponse({
    required this.email,
    required this.fullName,
    required this.avatar,
    required this.role,
    required this.token,
  });
  late final String email;
  late final String fullName;
  late final String avatar;
  late final String role;
  late final String token;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['fullName'] = fullName;
    _data['avatar'] = avatar;
    _data['role'] = role;
    _data['token'] = token;
    return _data;
  }
}
