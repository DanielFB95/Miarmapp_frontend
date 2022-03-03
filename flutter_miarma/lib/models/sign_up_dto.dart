class SignUpDto {
  SignUpDto({
    required this.username,
    required this.fullname,
    required this.email,
    required this.biography,
    required this.password,
    required this.password2,
  });
  late final String username;
  late final String fullname;
  late final String email;
  late final String biography;
  late final String password;
  late final String password2;

  SignUpDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    biography = json['biography'];
    password = json['password'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['fullname'] = fullname;
    _data['email'] = email;
    _data['biography'] = biography;
    _data['password'] = password;
    _data['password2'] = password2;
    return _data;
  }
}
