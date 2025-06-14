import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/domain/usecases/get_characters.dart';
import 'package:pokedex_app/presentation/controllers/characters_controller.dart';
import 'package:pokedex_app/core/util/result.dart';
import 'package:pokedex_app/core/error/failures.dart';

class MockGetCharacters extends Mock implements GetCharacters {}

void main() {
  late CharactersController controller;
  late MockGetCharacters mockGetCharacters;

  setUp(() {
    mockGetCharacters = MockGetCharacters();
    controller = CharactersController(mockGetCharacters);
  });

  group('loadCharacters', () {
    test('should load characters successfully', () async {
      final characters = [
        Character(
          id: 1,
          name: 'bulbasaur',
          thumbnailUrl: 'https://example.com/bulbasaur.jpg',
          types: ['grass'],
          abilities: ['overgrow'],
          height: 7,
          weight: 69,
          description: 'A grass type Pokémon',
        ),
      ];

      when(
        () => mockGetCharacters(offset: 0, limit: 20),
      ).thenAnswer((_) async => Result.success(characters));

      await controller.loadCharacters();

      expect(controller.state, CharactersState.loaded);
      expect(controller.characters, characters);
      expect(controller.allCharacters, characters);
      verify(() => mockGetCharacters(offset: 0, limit: 20)).called(1);
    });

    test('should handle error when loading characters', () async {
      when(() => mockGetCharacters(offset: 0, limit: 20)).thenAnswer(
        (_) async => Result.failure(ServerFailure('Failed to load characters')),
      );

      await controller.loadCharacters();

      expect(controller.state, CharactersState.error);
      expect(controller.errorMessage, 'Failed to load characters');
      verify(() => mockGetCharacters(offset: 0, limit: 20)).called(1);
    });

    test('should handle empty response', () async {
      when(
        () => mockGetCharacters(offset: 0, limit: 20),
      ).thenAnswer((_) async => Result.success([]));

      await controller.loadCharacters();

      expect(controller.state, CharactersState.loaded);
      expect(controller.characters, isEmpty);
      expect(controller.allCharacters, isEmpty);
      expect(controller.hasMoreData, false);
      verify(() => mockGetCharacters(offset: 0, limit: 20)).called(1);
    });
  });

  group('searchCharacters', () {
    test('should filter characters by name', () async {
      final characters = [
        Character(
          id: 1,
          name: 'bulbasaur',
          thumbnailUrl: 'https://example.com/bulbasaur.jpg',
          types: ['grass'],
          abilities: ['overgrow'],
          height: 7,
          weight: 69,
          description: 'A grass type Pokémon',
        ),
        Character(
          id: 2,
          name: 'charmander',
          thumbnailUrl: 'https://example.com/charmander.jpg',
          types: ['fire'],
          abilities: ['blaze'],
          height: 6,
          weight: 85,
          description: 'A fire type Pokémon',
        ),
      ];

      when(
        () => mockGetCharacters(offset: 0, limit: 20),
      ).thenAnswer((_) async => Result.success(characters));

      await controller.loadCharacters();
      controller.setSearchQuery('bulba');

      expect(controller.state, CharactersState.loaded);
      expect(controller.characters.length, 1);
      expect(controller.characters.first.name, 'bulbasaur');
      expect(controller.searchQuery, 'bulba');
    });

    test('should filter characters by type', () async {
      final characters = [
        Character(
          id: 1,
          name: 'bulbasaur',
          thumbnailUrl: 'https://example.com/bulbasaur.jpg',
          types: ['grass'],
          abilities: ['overgrow'],
          height: 7,
          weight: 69,
          description: 'A grass type Pokémon',
        ),
        Character(
          id: 2,
          name: 'charmander',
          thumbnailUrl: 'https://example.com/charmander.jpg',
          types: ['fire'],
          abilities: ['blaze'],
          height: 6,
          weight: 85,
          description: 'A fire type Pokémon',
        ),
      ];

      when(
        () => mockGetCharacters(offset: 0, limit: 20),
      ).thenAnswer((_) async => Result.success(characters));

      await controller.loadCharacters();
      controller.setSearchQuery('fire');

      expect(controller.state, CharactersState.loaded);
      expect(controller.characters.length, 1);
      expect(controller.characters.first.name, 'charmander');
      expect(controller.searchQuery, 'fire');
    });

    test('should clear search when query is empty', () async {
      final characters = [
        Character(
          id: 1,
          name: 'bulbasaur',
          thumbnailUrl: 'https://example.com/bulbasaur.jpg',
          types: ['grass'],
          abilities: ['overgrow'],
          height: 7,
          weight: 69,
          description: 'A grass type Pokémon',
        ),
      ];

      when(
        () => mockGetCharacters(offset: 0, limit: 20),
      ).thenAnswer((_) async => Result.success(characters));

      await controller.loadCharacters();
      controller.setSearchQuery('bulba');
      controller.clearSearch();

      expect(controller.state, CharactersState.loaded);
      expect(controller.characters, characters);
      expect(controller.searchQuery, '');
    });
  });
}
