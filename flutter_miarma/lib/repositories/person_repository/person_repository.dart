import 'package:flutter_miarma/models/person_response.dart';

abstract class PersonRepository {
  Future<Person> fecthPerson();
}
