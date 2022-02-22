import 'package:flutter_miarma/models/post_response.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPeople();
}
