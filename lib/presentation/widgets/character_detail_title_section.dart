import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';

class CharacterDetailTitleSection extends StatelessWidget {
  final Character character;

  const CharacterDetailTitleSection({Key? key, required this.character})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      character.name.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
      textAlign: TextAlign.center,
    );
  }
}
