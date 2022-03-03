part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class DoSignUpEvent extends SignUpEvent {
  final SignUpDto signUpDto;

  const DoSignUpEvent(this.signUpDto);
}

class SignUpInitialEvent extends SignUpEvent {
  const SignUpInitialEvent();
}
