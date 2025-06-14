import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';
import 'pokemon_type_chip.dart';

class TypesSection extends StatelessWidget {
  final Character character;

  const TypesSection({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TYPES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children:
              character.types
                  .map((type) => PokemonTypeChip(type: type))
                  .toList(),
        ),
      ],
    );
  }
}
