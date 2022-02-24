import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarma/models/person_response.dart';
import 'package:flutter_miarma/repositories/person_repository/person_repository.dart';
import 'package:meta/meta.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository personRepository;

  PersonBloc(this.personRepository) : super(PersonInitial()) {
    on<FetchPerson>(_personFetched);
  }

  void _personFetched(FetchPerson event, Emitter<PersonState> emit) async {
    try {
      final person = await personRepository.fecthPerson();
      emit(PersonFetched(person));
      return;
    } on Exception catch (e) {
      emit(PersonFetchError(e.toString()));
    }
  }
}
