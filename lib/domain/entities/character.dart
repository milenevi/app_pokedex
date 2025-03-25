class Character {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;
  final List<String> abilities;
  final int height;
  final int weight;
  final List<String> types;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.types,
  });
}
