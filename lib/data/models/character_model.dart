import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required super.id,
    required super.name,
    required super.description,
    required super.thumbnailUrl,
    required super.abilities,
    required super.height,
    required super.weight,
    required super.types,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    // A PokéAPI não fornece descrições diretamente, então usei o nome como descrição
    final description = json['name'] ?? '';

    // Extrai as habilidades
    final abilities =
        (json['abilities'] as List<dynamic>? ?? [])
            .map((ability) => ability['ability']['name'] as String? ?? '')
            .toList();

    // Extrai os tipos
    final types =
        (json['types'] as List<dynamic>? ?? [])
            .map((type) => type['type']['name'] as String? ?? '')
            .toList();

    // Construímos a URL da imagem baseada no ID
    final id = json['id'] as int;
    final thumbnailUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

    return CharacterModel(
      id: id,
      name: json['name'] ?? '',
      description: description,
      thumbnailUrl: thumbnailUrl,
      abilities: abilities,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      types: types,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'abilities': abilities,
      'height': height,
      'weight': weight,
      'types': types,
    };
  }
}
