import 'package:flutter/material.dart';

class PokemonTitle extends StatelessWidget {
  final String name;

  const PokemonTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withAlpha(230),
            Colors.black.withAlpha(179),
            Colors.black.withAlpha(0),
          ],
        ),
      ),
      child: Text(
        name.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          shadows: [
            Shadow(offset: Offset(1, 1), blurRadius: 3, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
