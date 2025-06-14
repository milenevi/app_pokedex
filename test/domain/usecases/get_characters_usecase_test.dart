import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/domain/repositories/character_repository.dart';
import 'package:pokedex_app/domain/usecases/get_characters.dart';
import 'package:pokedex_app/core/util/result.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late GetCharacters useCase;
  late MockCharacterRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterRepository();
    useCase = GetCharacters(mockRepository);
  });

  test('should get characters from repository', () async {
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
      () => mockRepository.getCharacters(),
    ).thenAnswer((_) async => Result.success(characters));

    final result = await useCase();

    expect(result.isSuccess, true);
    expect(result.data, characters);
    verify(() => mockRepository.getCharacters()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should throw exception when repository fails', () async {
    when(
      () => mockRepository.getCharacters(),
    ).thenThrow(Exception('Failed to load characters'));

    expect(() => useCase(), throwsA(isA<Exception>()));
  });
}
