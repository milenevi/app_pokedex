import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/domain/usecases/get_character_by_id.dart';
import 'package:pokedex_app/presentation/controllers/character_detail_controller.dart';
import 'package:pokedex_app/core/util/result.dart';
import 'package:pokedex_app/core/error/failures.dart';

class MockGetCharacterById extends Mock implements GetCharacterById {}

void main() {
  late CharacterDetailController controller;
  late MockGetCharacterById mockGetCharacterById;

  setUp(() {
    mockGetCharacterById = MockGetCharacterById();
    controller = CharacterDetailController(mockGetCharacterById);
  });

  group('loadCharacter', () {
    test('should load character details successfully', () async {
      final character = Character(
        id: 1,
        name: 'bulbasaur',
        thumbnailUrl: 'https://example.com/bulbasaur.jpg',
        types: ['grass'],
        abilities: ['overgrow'],
        height: 7,
        weight: 69,
        description: 'A grass type Pokémon',
      );

      when(
        () => mockGetCharacterById(1),
      ).thenAnswer((_) async => Result.success(character));

      await controller.loadCharacter(1);

      expect(controller.state, CharacterDetailState.loaded);
      expect(controller.character, character);
      verify(() => mockGetCharacterById(1)).called(1);
    });

    test('should handle error when loading character details', () async {
      when(() => mockGetCharacterById(1)).thenAnswer(
        (_) async => Result.failure(ServerFailure('Failed to load character')),
      );

      await controller.loadCharacter(1);

      expect(controller.state, CharacterDetailState.error);
      expect(controller.errorMessage, 'Failed to load character');
      verify(() => mockGetCharacterById(1)).called(1);
    });
  });
}
