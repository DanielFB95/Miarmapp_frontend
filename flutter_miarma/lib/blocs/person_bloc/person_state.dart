part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  List<Object> get props => [];
}

class PersonInitial extends PersonState {}

class PersonFetched extends PersonState {
  final Person person;

  const PersonFetched(this.person);

  List<Object> get props => [person];
}

class PersonFetchError extends PersonState {
  final String message;

  const PersonFetchError(this.message);

  List<Object> get props => [message];
}
