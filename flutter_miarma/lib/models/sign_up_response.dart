class SignUpResponse {
  SignUpResponse({
    required this.id,
    required this.avatar,
    required this.username,
    required this.fullName,
    required this.email,
    required this.role,
    required this.biography,
    required this.birthdate,
    required this.private,
  });
  late final String id;
  late final String avatar;
  late final String username;
  late final String fullName;
  late final String email;
  late final String role;
  late final String biography;
  late final String birthdate;
  late final bool private;

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    username = json['username'];
    fullName = json['fullName'];
    email = json['email'];
    role = json['role'];
    biography = json['biography'];
    birthdate = json['birthdate'];
    private = json['private'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['avatar'] = avatar;
    _data['username'] = username;
    _data['fullName'] = fullName;
    _data['email'] = email;
    _data['role'] = role;
    _data['biography'] = biography;
    _data['birthdate'] = birthdate;
    _data['private'] = private;
    return _data;
  }
}
