import 'dart:convert';

import 'package:flutter_miarma/models/person_response.dart';
import 'package:flutter_miarma/repositories/person_repository/person_repository.dart';
import 'package:flutter_miarma/utils/constants.dart';
import 'package:flutter_miarma/utils/preferences.dart';
import 'package:http/http.dart';

class PersonRepositoryImpl extends PersonRepository {
  final Client _client = Client();

  @override
  Future<Person> fecthPerson() async {
    var token = PreferenceUtils.getString("token");
    final response = await _client.get(Uri.parse('${Constant.URL_API_BASE}/me'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      return Person.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load person');
    }
  }
}
