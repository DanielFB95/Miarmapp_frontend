import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma/models/create_post_dto.dart';
import 'package:flutter_miarma/models/create_post_response.dart';
import 'package:flutter_miarma/models/post_response.dart';
import 'package:flutter_miarma/repositories/post_repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPost>(_postFetched);
    on<NewPost>(_newPost);
  }

  Future<void> _postFetched(FetchPost event, Emitter<PostState> emit) async {
    try {
      final posts = await postRepository.fetchPost();
      emit(PostFetched(posts));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }

  Future<void> _newPost(NewPost event, Emitter<PostState> emit) async {
    try {
      final newPost =
          await postRepository.newPost(event.createPostDto, event.image);
      emit(NewPostState(newPost));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}
