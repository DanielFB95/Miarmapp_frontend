part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class DoSignInEvent extends SignInEvent {
  final SignInDto signInDto;

  const DoSignInEvent(this.signInDto);
}
