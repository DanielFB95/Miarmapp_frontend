part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final SignInResponse signInResponse;

  const SignInSuccessState(this.signInResponse);

  @override
  List<Object> get props => [signInResponse];
}

class SignInErrorState extends SignInState {
  final String message;

  const SignInErrorState(this.message);

  @override
  List<Object> get props => [message];
}
