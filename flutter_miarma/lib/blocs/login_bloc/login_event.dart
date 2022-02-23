part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  List<Object> get props => [];
}

class DoLoginEvent extends LoginEvent {
  final LoginDto loginDto;

  const DoLoginEvent(this.loginDto);

  //List<Object> get props => [loginDto];
}
