import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_app/core/util/result.dart';
import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/domain/repositories/character_repository.dart';
import 'package:pokedex_app/domain/usecases/search_characters_usecase.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late SearchCharactersUseCase useCase;
  late MockCharacterRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterRepository();
    useCase = SearchCharactersUseCase(mockRepository);
  });

  test('should search characters from repository', () async {
    final characters = [
      Character(
        id: 25,
        name: 'pikachu',
        thumbnailUrl: 'https://example.com/pikachu.jpg',
        types: ['electric'],
        abilities: ['static'],
        height: 4,
        weight: 60,
        description: 'An electric type Pokémon',
      ),
    ];

    when(
      () => mockRepository.getCharacters(),
    ).thenAnswer((_) async => Result.success(characters));

    final result = await useCase('pikachu');

    expect(result.isSuccess, true);
    expect(result.data, equals(characters));
    verify(() => mockRepository.getCharacters()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should handle failure from repository', () async {
    when(() => mockRepository.getCharacters()).thenAnswer(
      (_) async => Result.failure(ServerFailure('Failed to search')),
    );

    final result = await useCase('pikachu');

    expect(result.isFailure, true);
    expect(result.failure, isA<ServerFailure>());
    expect(
      (result.failure as ServerFailure).message,
      equals('Failed to search'),
    );
  });
}
