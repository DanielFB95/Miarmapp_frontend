import 'package:flutter_miarma/models/people_response.dart';
import 'package:http/http.dart' show Client;

class PeopleApiProvider {
  Client client = Client();

  Future<PeopleResponse> fetchPeople() async {
    final response = await client.get("url de la petición");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return PeopleResponse.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
