import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma/models/post_response.dart';
import 'package:flutter_miarma/repositories/post_repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPost>(_postFetched);
  }

  Future<void> _postFetched(FetchPost event, Emitter<PostState> emit) async {
    try {
      final posts = await postRepository.fetchPeople();
      emit(PostFetched(posts));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}
