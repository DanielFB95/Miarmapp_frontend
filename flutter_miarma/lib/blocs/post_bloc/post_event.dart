part of 'post_bloc.dart';

@immutable
abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPost extends PostEvent {
  const FetchPost();

  @override
  List<Object> get props => [];
}

class FetchPostError extends PostEvent {
  const FetchPostError();
}

class NewPost extends PostEvent {
  final CreatePostDto createPostDto;
  final String image;

  const NewPost(this.createPostDto, this.image);

  @override
  List<Object> get props => [createPostDto, image];
}
