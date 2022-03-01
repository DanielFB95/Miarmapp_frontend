import 'dart:convert';

import 'package:flutter_miarma/models/login_response.dart';
import 'package:flutter_miarma/models/login_dto.dart';
import 'package:flutter_miarma/models/sign_in_dto.dart';
import 'package:flutter_miarma/models/sign_in_response.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_miarma/utils/constants.dart';
import 'package:flutter_miarma/utils/preferences.dart';
import 'package:http/http.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    var token = PreferenceUtils.getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await Future.delayed(const Duration(milliseconds: 4000), () {
      return _client.post(Uri.parse('${Constant.URL_API_BASE}/auth/login'),
          headers: headers, body: jsonEncode(loginDto.toJson()));
    });
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }

  @override
  Future<SignInResponse> signIn(SignInDto signInDto) async {
    //var token = PreferenceUtils.getString("token");
    final response =
        await _client.post(Uri.parse('${Constant.URL_API_BASE}/auth/register'),
            //headers: {'Authorization': 'Bearer $token'},
            body: jsonEncode(signInDto.toJson()));

    if (response.statusCode == 200) {
      return SignInResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to sign in.');
    }
  }
}
