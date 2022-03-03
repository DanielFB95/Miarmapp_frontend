import 'dart:convert';

import 'package:flutter_miarma/models/create_post_response.dart';
import 'package:flutter_miarma/models/post_response.dart';
import 'package:flutter_miarma/repositories/post_repository/post_repository.dart';
import 'package:flutter_miarma/utils/constants.dart';
import 'package:flutter_miarma/utils/preferences.dart';
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Post>> fetchPost() async {
    var token = PreferenceUtils.getString("token");
    final response = await _client.get(
        Uri.parse('${Constant.URL_API_BASE}/post/public?page=0'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).content;
    } else {
      throw Exception('Fail to load posts');
    }
  }

  @override
  Future<CreatePostResponse> newPost() async {
    var token = PreferenceUtils.getString("token");

    final response = await _client.post(
        Uri.parse('${Constant.URL_API_BASE}/post/'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 201) {
      return CreatePostResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail new post');
    }
  }
}
