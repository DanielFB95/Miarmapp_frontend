import 'package:flutter_miarma/models/create_post_dto.dart';
import 'package:flutter_miarma/models/create_post_response.dart';
import 'package:flutter_miarma/models/post_response.dart';

abstract class PostRepository {
  Future<List<Post>> fetchPost();
  Future<CreatePostResponse> newPost(CreatePostDto createPostDto, String image);
}
