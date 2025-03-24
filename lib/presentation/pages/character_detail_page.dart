import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/character.dart';
import '../controllers/character_detail_controller.dart';
import '../widgets/error_view.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Modular.to.pop(),
        ),
        title: Observer(
          builder: (_) {
            final displayName =
                controller.character?.name ?? widget.character?.name ?? '';
            return Text(
              displayName.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
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
                    // Imagem do Pokémon
                    Container(
                      width: double.infinity,
                      color: Colors.black,
                      child: Hero(
                        tag: 'pokemon_image_${character.id}',
                        child: CachedNetworkImage(
                          imageUrl: character.thumbnailUrl,
                          height: 280,
                          fit: BoxFit.contain,
                          placeholder:
                              (context, url) => Container(
                                height: 280,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                height: 280,
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                    // Overlay com o nome do personagem
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.0),
                            ],
                          ),
                        ),
                        child: Text(
                          character.name.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Types
                      const Text(
                        'TYPES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children:
                            character.types
                                .map(
                                  (type) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getTypeColor(type),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      type.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),

                      const SizedBox(height: 24),
                      // Physical characteristics
                      const Text(
                        'PHYSICAL CHARACTERISTICS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.grey[900],
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Text(
                                      'HEIGHT',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(character.height / 10).toStringAsFixed(1)} m',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Card(
                              color: Colors.grey[900],
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Text(
                                      'WEIGHT',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(character.weight / 10).toStringAsFixed(1)} kg',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      // Abilities
                      const Text(
                        'ABILITIES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...character.abilities.map(
                        (ability) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber[700],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                ability.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      // Description
                      const Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        character.description.isNotEmpty
                            ? character.description
                            : 'No description available for this Pokémon.',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
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

// Retorna uma cor baseada no tipo do Pokémon
Color _getTypeColor(String type) {
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
