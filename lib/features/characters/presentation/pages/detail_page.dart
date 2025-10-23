import 'package:flutter/material.dart';
import '../../data/character_model.dart';

/// Pantalla de detalle que muestra información extendida del personaje.
class DetailPage extends StatelessWidget {
  final Character character;
  const DetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: character.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(character.image),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(height: 20),
              Text('Estado: ${character.status}'),
              Text('Especie: ${character.species}'),
            ],
          ),
        ),
      ),
    );
  }
}
