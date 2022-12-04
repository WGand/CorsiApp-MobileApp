import 'package:http/http.dart' as http;
import 'package:corsiapp/Application/json_decoder.dart';

Future<JsonDecoder> fetchCourse() async {
  final response = await http
      .get(Uri.parse('https://638c1e60eafd555746a0b852.mockapi.io/Course'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return (JsonDecoder(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to htpps');
  }
}