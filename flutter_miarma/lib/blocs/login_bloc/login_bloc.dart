import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma/models/login_dto.dart';
import 'package:flutter_miarma/models/login_response.dart';
import 'package:flutter_miarma/repositories/auth_repository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginInitialState()) {
    on<DoLoginEvent>(_doLoginEvent);
  }

  void _doLoginEvent(DoLoginEvent event, Emitter<LoginState> emitter) async {
    try {
      final loginResponse = await authRepository.login(event.loginDto);
      emit(LoginSuccesState(loginResponse));
    } on Exception catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
