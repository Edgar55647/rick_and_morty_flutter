import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/character_providers.dart';
import '../widgets/character_card.dart';
import 'detail_page.dart';

/// Pantalla que muestra solo los personajes favoritos.
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsync = ref.watch(characterProvider);
    final favorites = ref.watch(favoritesProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFD6E8), Color(0xFFFFAAA5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Mis Favoritos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            elevation: 4,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: charactersAsync.when(
            loading: () =>
                const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (characters) {
              final favList = characters
                  .where((c) => favorites.contains(c.id))
                  .toList();

              if (favList.isEmpty) {
                return const Center(
                  child: Text(
                    'Aún no tienes favoritos 😢',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                cacheExtent: 3000, // mejora el scroll
                itemCount: favList.length,
                itemBuilder: (context, index) {
                  final character = favList[index];
                  return CharacterCard(
                    character: character,
                    isFavorite: true,
                    onFavoriteToggle: () => ref
                        .read(favoritesProvider.notifier)
                        .toggleFavorite(character.id),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(character: character),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
