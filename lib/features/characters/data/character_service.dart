import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'character_model.dart';

class CharacterService {
  final String baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return compute(parseCharacters, response.body); //  carga en otro hilo
    } else {
      throw Exception('Error al obtener los personajes');
    }
  }
}

List<Character> parseCharacters(String responseBody) {
  final data = json.decode(responseBody)['results'] as List;
  return data.map((e) => Character.fromJson(e)).toList();
}
