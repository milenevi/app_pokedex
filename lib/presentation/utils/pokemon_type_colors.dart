import 'package:flutter/material.dart';

class PokemonTypeColors {
  static Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow[700]!;
      case 'psychic':
        return Colors.purple;
      case 'ice':
        return Colors.lightBlue;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink;
      case 'normal':
        return Colors.grey[400]!;
      case 'fighting':
        return Colors.orange[800]!;
      case 'flying':
        return Colors.lightBlue[200]!;
      case 'poison':
        return Colors.purple[800]!;
      case 'ground':
        return Colors.brown[300]!;
      case 'rock':
        return Colors.brown;
      case 'bug':
        return Colors.lightGreen;
      case 'ghost':
        return Colors.deepPurple;
      case 'steel':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}
