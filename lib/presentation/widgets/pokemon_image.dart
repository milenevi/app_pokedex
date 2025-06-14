import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/character.dart';

class PokemonImage extends StatelessWidget {
  final Character character;
  final double height;
  final String heroTag;

  const PokemonImage({
    Key? key,
    required this.character,
    this.height = 280,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Hero(
        tag: heroTag,
        child: CachedNetworkImage(
          imageUrl: character.thumbnailUrl,
          height: height,
          fit: BoxFit.contain,
          placeholder: (context, url) => SizedBox(
            height: height,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
          errorWidget: (context, url, error) => SizedBox(
            height: height,
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
    );
  }
}
