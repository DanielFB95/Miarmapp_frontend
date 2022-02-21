import 'package:flutter_miarma/models/people_response.dart';
import 'package:flutter_miarma/repositories/people_repository.dart';
import 'package:rxdart/rxdart.dart';

class PeopleBloc {
  final _peopleRepository = PeopleRepository();
  final _peopleFetcher = PublishSubject<PeopleResponse>();

  Observable<PeopleResponse> get allPeople => _peopleFetcher.stream;

  fetchAllPeople() async {
    PeopleResponse people = await _peopleRepository.fecthAllPeople();
    _peopleFetcher.sink.add(people);
  }

  dispose() {
    _peopleFetcher.close();
  }
}

final bloc = PeopleBloc();
