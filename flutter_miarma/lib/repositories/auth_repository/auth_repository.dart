import 'package:flutter_miarma/models/login_dto.dart';
import 'package:flutter_miarma/models/login_response.dart';
import 'package:flutter_miarma/models/sign_up_dto.dart';
import 'package:flutter_miarma/models/sign_up_response.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  //Future<SignUpResponse> signUp(SignUpDto signUpDto);

  Future<SignUpResponse> signUp(SignUpDto signUpDto, [XFile? file]);
}
