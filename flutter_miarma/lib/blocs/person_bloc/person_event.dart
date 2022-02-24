part of 'person_bloc.dart';

@immutable
abstract class PersonEvent extends Equatable {
  const PersonEvent();

  List<Object> get props => [];
}

class FetchPerson extends PersonEvent {
  const FetchPerson();

  List<Object> get props => [];
}
