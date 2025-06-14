import 'package:flutter/material.dart';

class CharactersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTestMode;

  const CharactersAppBar({Key? key, this.isTestMode = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isTestMode)
            Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png',
              height: 30,
              width: 30,
            )
          else
            const SizedBox(
              height: 30,
              width: 30,
              child: Icon(Icons.catching_pokemon, color: Colors.white),
            ),
          const SizedBox(width: 8),
          const Text(
            'POKÉDEX',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 20,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
