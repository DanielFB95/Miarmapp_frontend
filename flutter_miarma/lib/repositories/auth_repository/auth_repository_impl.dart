import 'dart:convert';
import 'package:flutter_miarma/models/login_response.dart';
import 'package:flutter_miarma/models/login_dto.dart';
import 'package:flutter_miarma/models/sign_up_dto.dart';
import 'package:flutter_miarma/models/sign_up_response.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_miarma/utils/constants.dart';
import 'package:flutter_miarma/utils/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    var token = PreferenceUtils.getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await http.post(Uri.parse('${Constant.URL_API_BASE}/auth/login'),
            headers: headers,
            //encoding: Encoding.getByName("utf-8"),
            body: jsonEncode(loginDto.toJson()));

    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }

  @override
  Future<SignUpResponse> signUp(SignUpDto signUpDto, [XFile? file]) async {
    final url = Uri.parse('${Constant.URL_API_BASE}/auth/register');

    var body = json.encode({
      "username": signUpDto.username,
      "fullName": signUpDto.fullname,
      "email": signUpDto.email,
      "biography": signUpDto.biography,
      "password": signUpDto.password,
      "password2": signUpDto.password2
    });

    final request = http.MultipartRequest('POST', url)
      ..files.add(http.MultipartFile.fromString('body', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('file', file!.path,
          contentType: MediaType('image', file.mimeType.toString())))
      ..headers.addAll({"Content-Type": "multipart/form-data"});

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    if (response.statusCode == 200) {
      return SignUpResponse.fromJson(responseData);
    } else {
      throw Exception('No se ha podido realizar el registro.');
    }
  }

  /*
  @override
  Future<SignUpResponse> signUp(SignUpDto signUpDto) async {
    final response = await http.post(
        Uri.parse('${Constant.URL_API_BASE}/auth/register'),
        body: jsonEncode(signUpDto.toJson()));

    if (response.statusCode == 200) {
      return SignUpResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to sign in.');
    }
  }*/
}
