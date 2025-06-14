import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controllers/character_detail_controller.dart';

class CharacterDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final CharacterDetailController controller;

  const CharacterDetailAppBar({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Modular.to.pop(),
      ),
      title: Observer(
        builder: (_) {
          final displayName = controller.character?.name ?? '';
          return Text(
            displayName.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
