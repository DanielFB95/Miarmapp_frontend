import 'dart:convert';

import 'package:flutter_miarma/models/post_response.dart';
import 'package:flutter_miarma/repositories/post_repository/post_repository.dart';
import 'package:flutter_miarma/utils/constants.dart';
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  @override
  Future<List<Post>> fetchPeople() async {
    final response = await _client.get(Uri.parse('${Constant.URL_API_BASE}'));
    if (response.statusCode == 200) {
      return PostResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Fail to load movies');
    }
  }
}
