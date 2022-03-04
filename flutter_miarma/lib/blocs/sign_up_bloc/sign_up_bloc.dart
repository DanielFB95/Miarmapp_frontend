import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma/models/sign_up_dto.dart';
import 'package:flutter_miarma/models/sign_up_response.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc(this.authRepository) : super(SignUpInitialState()) {
    on<DoSignUpEvent>(_doSignUp);
    on<SignUpInitialEvent>(_initialSignUp);
  }

  void _doSignUp(DoSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());
    try {
      final signInResponse =
          await authRepository.signUp(event.signUpDto, event.file);
      emit(SignUpSuccessState(signInResponse));
      return;
    } on Exception catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }

  void _initialSignUp(SignUpInitialEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitialState());
    return;
  }
}
