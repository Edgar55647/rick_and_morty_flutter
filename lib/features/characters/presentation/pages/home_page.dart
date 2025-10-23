import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/character_providers.dart';
import '../widgets/character_card.dart';
import 'detail_page.dart';
import 'favorites_page.dart';

/// Pantalla principal: lista de personajes + buscador + acceso a favoritos
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsync = ref.watch(characterProvider);
    final query = ref.watch(searchQueryProvider);
    final favorites = ref.watch(favoritesProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB2F7EF), Color(0xFF7BDFF2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Rick and Morty Explorer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            elevation: 4,
            centerTitle: true,
            actions: [
             

              //Botón con animación de transición personalizada
              IconButton(
                icon: const Icon(Icons.favorite),
                tooltip: 'Ver favoritos',
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // 🔍 Campo de búsqueda
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar personaje...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) =>
                      ref.read(searchQueryProvider.notifier).state = value,
                ),
              ),
              Expanded(
                child: charactersAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (characters) {
                    final filtered = characters
                        .where((c) => c.name
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();

                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text('No hay personajes 😢'),
                      );
                    }

                    return ListView.builder(
                      cacheExtent: 3000, // mejora scroll
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final character = filtered[index];
                        final isFav = favorites.contains(character.id);
                        return CharacterCard(
                          character: character,
                          isFavorite: isFav,
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
            ],
          ),
        ),
      ),
    );
  }

  /// Crea una ruta personalizada con animación tipo "slide + fade"
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const FavoritesPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); 
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final fadeTween =
            Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}
