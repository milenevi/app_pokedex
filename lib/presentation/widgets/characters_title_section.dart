import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CharactersTitleSection extends StatelessWidget {
  final String searchQuery;

  const CharactersTitleSection({Key? key, required this.searchQuery})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Observer(
        builder:
            (_) => Text(
              searchQuery.isNotEmpty
                  ? 'RESULTADOS PARA "${searchQuery.toUpperCase()}"'
                  : 'POKÉMON COLLECTION',
              style: const TextStyle(
                color: Color(0xFF303943),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.left,
            ),
      ),
    );
  }
}
