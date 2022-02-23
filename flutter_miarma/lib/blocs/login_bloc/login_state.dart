part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccesState extends LoginState {
  final LoginResponse loginResponse;

  const LoginSuccesState(this.loginResponse);

  List<Object> get props => [loginResponse];
}

class LoginErrorState extends LoginState {
  final String message;

  const LoginErrorState(this.message);

  List<Object> get props => [message];
}
