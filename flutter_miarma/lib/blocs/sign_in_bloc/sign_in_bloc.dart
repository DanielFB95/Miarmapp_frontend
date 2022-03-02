import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma/models/sign_in_dto.dart';
import 'package:flutter_miarma/models/sign_in_response.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc(this.authRepository) : super(SignInInitialState()) {
    on<DoSignInEvent>(_doSignIn);
  }

  void _doSignIn(DoSignInEvent event, Emitter<SignInState> emit) async {
    emit(SignInLoadingState());
    try {
      final signInResponse = await authRepository.signIn(event.signInDto);
      emit(SignInSuccessState(signInResponse));
      return;
    } on Exception catch (e) {
      emit(SignInErrorState(e.toString()));
    }
  }
}
