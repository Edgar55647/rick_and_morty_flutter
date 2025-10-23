import 'character_model.dart';
import 'character_service.dart';

class CharacterRepository {
  final CharacterService service;

  CharacterRepository(this.service);

  Future<List<Character>> getAllCharacters() {
    return service.fetchCharacters();
  }
}
