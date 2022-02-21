import 'package:flutter_miarma/models/post_response.dart';
import 'package:flutter_miarma/repositories/post_repository.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc {
  final _postRepository = PostRepository();
  final _postFecther = PublishSubject<PostResponse>();

  Observable<PostResponse> get allPost => _postFecther.stream;

  fetchAllPost() async {
    PostResponse post = await _postRepository.fecthAllPost();
    _postFecther.sink.add(post);
  }

  dispose() {
    _postFecther.close();
  }
}

final bloc = PostBloc();
