import 'package:http/http.dart' as http;

import 'package:mononocle2/models/word_model.dart';

Future<AllDefinitions> getWord (final String word) async {

  Uri url = Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
  http.Response response = await http.get(url);

  var jsonResponse = "{\"data\":"+response.body+"}";
  //List<Map<String, dynamic>> wordMap = convert.jsonDecode(jsonResponse)["data"];

  var allDefs = AllDefinitions(wordFromJson(response.body));

  return allDefs;
}