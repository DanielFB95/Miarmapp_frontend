import 'package:flutter_miarma/models/login_dto.dart';
import 'package:flutter_miarma/models/login_response.dart';
import 'package:flutter_miarma/models/sign_in_dto.dart';
import 'package:flutter_miarma/models/sign_in_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<SignInResponse> signIn(SignInDto signInDto);
}
