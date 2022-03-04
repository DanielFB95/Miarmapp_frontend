import 'dart:convert';
import 'package:flutter_miarma/models/create_post_dto.dart';
import 'package:flutter_miarma/models/create_post_response.dart';
import 'package:flutter_miarma/models/post_response.dart';
import 'package:flutter_miarma/repositories/post_repository/post_repository.dart';
import 'package:flutter_miarma/utils/constants.dart';
import 'package:flutter_miarma/utils/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostRepositoryImpl extends PostRepository {
  @override
  Future<List<Post>> fetchPost() async {
    var token = PreferenceUtils.getString("token");
    final response = await http.get(
        Uri.parse('${Constant.URL_API_BASE}/post/public?page=0'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load posts');
    }
  }

  @override
  Future<CreatePostResponse> newPost(
      CreatePostDto createPostDto, String image) async {
    var token = PreferenceUtils.getString("token");
    final url = Uri.parse('${Constant.URL_API_BASE}/post/');

    var body = json.encode({"mensaje": createPostDto.message});

    final request = http.MultipartRequest('POST', url)
      ..files.add(http.MultipartFile.fromString('body', body,
          contentType: MediaType('application', 'json')))
      ..files.add(http.MultipartFile.fromString('file', image,
          contentType: MediaType('image', 'jpg')))
      ..headers.addAll({
        "Content-Type": "multipart(form-data",
        'Authorization': 'Bearer $token'
      });

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 201) {
      return CreatePostResponse.fromJson(json.decode(responsed.body));
    } else {
      throw Exception('Fail new post');
    }
  }
}
