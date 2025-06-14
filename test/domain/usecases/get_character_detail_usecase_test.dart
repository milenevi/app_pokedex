import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/domain/repositories/character_repository.dart';
import 'package:pokedex_app/domain/usecases/get_character_detail_usecase.dart';
import 'package:pokedex_app/core/util/result.dart';

class MockCharacterRepository extends Mock implements CharacterRepository {}

void main() {
  late GetCharacterDetailUseCase useCase;
  late MockCharacterRepository mockRepository;

  setUp(() {
    mockRepository = MockCharacterRepository();
    useCase = GetCharacterDetailUseCase(mockRepository);
  });

  test('should get character details from repository', () async {
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
      () => mockRepository.getCharacterById(1),
    ).thenAnswer((_) async => Result.success(character));

    final result = await useCase(1);

    expect(result.isSuccess, true);
    expect(result.data, character);
    verify(() => mockRepository.getCharacterById(1)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should throw exception when repository fails', () async {
    when(
      () => mockRepository.getCharacterById(1),
    ).thenThrow(Exception('Failed to load character'));

    expect(() => useCase(1), throwsA(isA<Exception>()));
  });
}
