part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final SignUpResponse signInResponse;

  const SignUpSuccessState(this.signInResponse);

  @override
  List<Object> get props => [signInResponse];
}

class SignUpErrorState extends SignUpState {
  final String message;

  const SignUpErrorState(this.message);

  @override
  List<Object> get props => [message];
}
