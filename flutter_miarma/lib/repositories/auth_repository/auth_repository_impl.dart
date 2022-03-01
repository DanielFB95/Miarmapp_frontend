import 'dart:convert';

import 'package:flutter_miarma/models/login_response.dart';
import 'package:flutter_miarma/models/login_dto.dart';
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
}
