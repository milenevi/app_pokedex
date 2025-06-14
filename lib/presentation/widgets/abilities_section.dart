import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';

class AbilitiesSection extends StatelessWidget {
  final Character character;

  const AbilitiesSection({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (character.abilities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Abilities',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 8),
        ...character.abilities.map(
          (ability) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(Icons.star, size: 16, color: Colors.amber[700]),
                const SizedBox(width: 8),
                Text(
                  ability,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
