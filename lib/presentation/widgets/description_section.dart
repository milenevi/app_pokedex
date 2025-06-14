import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';

class DescriptionSection extends StatelessWidget {
  final Character character;

  const DescriptionSection({Key? key, required this.character})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'DESCRIPTION',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 8),
        Text(
          character.description.isNotEmpty
              ? character.description
              : 'No description available for this Pokémon.',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
