import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../domain/entities/character.dart';
import '../controllers/character_detail_controller.dart';
import '../widgets/error_view.dart';
import '../widgets/character_detail_app_bar.dart';
import '../widgets/pokemon_image.dart';
import '../widgets/pokemon_title.dart';
import '../widgets/types_section.dart';
import '../widgets/physical_characteristics_section.dart';
import '../widgets/abilities_section.dart';
import '../widgets/description_section.dart';

class CharacterDetailPage extends StatefulWidget {
  final int characterId;
  final Character? character;

  const CharacterDetailPage({
    Key? key,
    required this.characterId,
    this.character,
  }) : super(key: key);

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  final CharacterDetailController controller =
      Modular.get<CharacterDetailController>();

  @override
  void initState() {
    super.initState();
    controller.loadCharacter(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CharacterDetailAppBar(controller: controller),
      body: Observer(
        builder: (_) {
          if (controller.state == CharacterDetailState.loading &&
              widget.character == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (controller.state == CharacterDetailState.error &&
              controller.character == null) {
            return ErrorView(
              message: controller.errorMessage,
              onRetry: () => controller.retry(widget.characterId),
            );
          }

          final character = controller.character ?? widget.character!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    PokemonImage(
                      character: character,
                      heroTag: 'pokemon_image_${character.id}',
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: PokemonTitle(name: character.name),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypesSection(character: character),
                      const SizedBox(height: 24),
                      PhysicalCharacteristicsSection(character: character),
                      const SizedBox(height: 24),
                      AbilitiesSection(character: character),
                      const SizedBox(height: 24),
                      DescriptionSection(character: character),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
