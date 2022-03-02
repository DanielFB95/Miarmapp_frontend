part of 'person_bloc.dart';

@immutable
abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class FetchPerson extends PersonEvent {
  const FetchPerson();

  @override
  List<Object> get props => [];
}
