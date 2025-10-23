import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/character_model.dart';
import '../data/character_repository.dart';
import '../data/character_service.dart';

/// Provider principal para obtener y manejar la lista de personajes
final characterProvider =
    StateNotifierProvider<CharacterNotifier, AsyncValue<List<Character>>>((ref) {
  final repository = CharacterRepository(CharacterService());
  return CharacterNotifier(repository);
});

/// Provider para manejar favoritos (ids seleccionados)
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<int>>(
  (ref) => FavoritesNotifier(),
);

/// Provider para manejar el término de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Controlador de estado principal para los personajes
class CharacterNotifier extends StateNotifier<AsyncValue<List<Character>>> {
  final CharacterRepository repository;

  CharacterNotifier(this.repository) : super(const AsyncLoading()) {
    loadCharacters();
  }

  /// Carga los personajes desde la API y actualiza el estado
  Future<void> loadCharacters() async {
    try {
      final characters = await repository.getAllCharacters();
      state = AsyncData(characters);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

/// Controlador de estado para manejar los favoritos
class FavoritesNotifier extends StateNotifier<Set<int>> {
  FavoritesNotifier() : super({});

  void toggleFavorite(int id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state}..add(id);
    }
  }

  bool isFavorite(int id) => state.contains(id);
}
