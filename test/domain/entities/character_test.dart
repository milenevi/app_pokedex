import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/character.dart';

void main() {
  group('Character', () {
    test('should create a character with all properties', () {
      final character = Character(
        id: 1,
        name: 'Pikachu',
        thumbnailUrl: 'https://example.com/pikachu.jpg',
        types: ['electric'],
        height: 40,
        weight: 60,
        abilities: ['static'],
        description: 'Electric mouse',
      );

      expect(character.id, 1);
      expect(character.name, 'Pikachu');
      expect(character.thumbnailUrl, 'https://example.com/pikachu.jpg');
      expect(character.types, ['electric']);
      expect(character.height, 40);
      expect(character.weight, 60);
      expect(character.abilities, ['static']);
      expect(character.description, 'Electric mouse');
    });

    test('should create a character with empty types and abilities', () {
      final character = Character(
        id: 1,
        name: 'Pikachu',
        thumbnailUrl: 'https://example.com/pikachu.jpg',
        types: [],
        height: 40,
        weight: 60,
        abilities: [],
        description: 'Electric mouse',
      );

      expect(character.types, isEmpty);
      expect(character.abilities, isEmpty);
    });

    test('should create a character with null description', () {
      final character = Character(
        id: 1,
        name: 'Pikachu',
        thumbnailUrl: 'https://example.com/pikachu.jpg',
        types: ['electric'],
        height: 40,
        weight: 60,
        abilities: ['static'],
        description: '',
      );

      expect(character.description, isEmpty);
    });

    test('should create a character with multiple types and abilities', () {
      final character = Character(
        id: 1,
        name: 'Charizard',
        thumbnailUrl: 'https://example.com/charizard.jpg',
        types: ['fire', 'flying'],
        height: 170,
        weight: 905,
        abilities: ['blaze', 'solar-power'],
        description: 'Fire dragon',
      );

      expect(character.types, ['fire', 'flying']);
      expect(character.abilities, ['blaze', 'solar-power']);
    });
  });
}
