class SignInDto {
  SignInDto({
    required this.username,
    required this.fullname,
    required this.email,
    required this.birthdate,
    required this.biography,
    required this.password,
    required this.password2,
  });
  late final String username;
  late final String fullname;
  late final String email;
  late final String birthdate;
  late final String biography;
  late final String password;
  late final String password2;

  SignInDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    email = json['email'];
    birthdate = json['birthdate'];
    biography = json['biography'];
    password = json['password'];
    password2 = json['password2'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['fullname'] = fullname;
    _data['email'] = email;
    _data['birthdate'] = birthdate;
    _data['biography'] = biography;
    _data['password'] = password;
    _data['password2'] = password2;
    return _data;
  }
}
