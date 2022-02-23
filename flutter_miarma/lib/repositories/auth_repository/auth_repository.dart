import 'package:flutter_miarma/models/login_dto.dart';
import 'package:flutter_miarma/models/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}
