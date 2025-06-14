import 'package:flutter/material.dart';
import '../utils/pokemon_type_colors.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;
  final double fontSize;
  final EdgeInsets padding;

  const PokemonTypeChip({
    Key? key,
    required this.type,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: PokemonTypeColors.getTypeColor(type),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
