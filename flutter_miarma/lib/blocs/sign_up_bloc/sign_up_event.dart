part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class DoSignUpEvent extends SignUpEvent {
  final SignUpDto signUpDto;
  final String file;

  const DoSignUpEvent(this.signUpDto, this.file);
}

class SignUpInitialEvent extends SignUpEvent {
  const SignUpInitialEvent();
}
