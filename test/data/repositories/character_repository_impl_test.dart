import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/data/datasources/pokemon_api_datasource.dart';
import 'package:pokedex_app/data/models/character_model.dart';
import 'package:pokedex_app/data/repositories/character_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonApiDatasource extends Mock implements PokemonApiDatasource {}

void main() {
  late CharacterRepositoryImpl repository;
  late MockPokemonApiDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockPokemonApiDatasource();
    repository = CharacterRepositoryImpl(datasource: mockDatasource);
  });

  final tCharacterModel = CharacterModel(
    id: 1,
    name: 'Bulbasaur',
    description:
        'A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.',
    thumbnailUrl:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
    abilities: ['overgrow', 'chlorophyll'],
    height: 7,
    weight: 69,
    types: ['grass', 'poison'],
  );

  group('getCharacterById', () {
    test(
      'should return Character when the call to datasource is successful',
      () async {
        // arrange
        when(
          () => mockDatasource.getCharacterById(any()),
        ).thenAnswer((_) async => tCharacterModel);

        // act
        final result = await repository.getCharacterById(1);

        // assert
        expect(result.isSuccess, true);
        expect(result.data?.id, equals(1));
        verify(() => mockDatasource.getCharacterById(1)).called(1);
      },
    );

    test(
      'should return ServerFailure when the call to datasource is unsuccessful',
      () async {
        // arrange
        when(
          () => mockDatasource.getCharacterById(any()),
        ).thenThrow(ServerFailure('Server error'));

        // act
        final result = await repository.getCharacterById(1);

        // assert
        expect(result.isFailure, true);
        expect(result.failure, isA<ServerFailure>());
        verify(() => mockDatasource.getCharacterById(1)).called(1);
      },
    );
  });

  group('getCharacters', () {
    final tCharacterList = [tCharacterModel];

    test(
      'should return list of Characters when the call to datasource is successful',
      () async {
        // arrange
        when(
          () => mockDatasource.getCharacters(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => tCharacterList);

        // act
        final result = await repository.getCharacters();

        // assert
        expect(result.isSuccess, true);
        expect(result.data?.length, equals(1));
        verify(
          () => mockDatasource.getCharacters(offset: 0, limit: 20),
        ).called(1);
      },
    );

    test(
      'should return NetworkFailure when the call to datasource throws NetworkFailure',
      () async {
        // arrange
        when(
          () => mockDatasource.getCharacters(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(NetworkFailure());

        // act
        final result = await repository.getCharacters();

        // assert
        expect(result.isFailure, true);
        expect(result.failure, isA<NetworkFailure>());
        verify(
          () => mockDatasource.getCharacters(offset: 0, limit: 20),
        ).called(1);
      },
    );
  });
}
