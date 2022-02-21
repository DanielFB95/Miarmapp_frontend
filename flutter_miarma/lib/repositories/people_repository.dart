import 'package:flutter_miarma/models/people_response.dart';
import 'package:flutter_miarma/resources/people_api_provider.dart';

class PeopleRepository {
  final peopleApiProvider = PeopleApiProvider();

  Future<PeopleResponse> fecthAllPeople() => peopleApiProvider.fetchPeople();
}
