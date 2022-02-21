import 'package:flutter_miarma/models/post_response.dart';
import 'package:flutter_miarma/resources/post_api_provider.dart';

class PostRepository {
  final postApiProvider = PostApiProvider();

  Future<PostResponse> fecthAllPost() => postApiProvider.fetchPost();
}
