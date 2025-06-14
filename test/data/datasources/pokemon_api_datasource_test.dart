import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:pokedex_app/core/error/failures.dart';
import 'package:pokedex_app/core/util/api_config.dart';
import 'package:pokedex_app/data/datasources/pokemon_api_datasource.dart';
import 'package:pokedex_app/data/models/character_model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late PokemonApiDatasourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = PokemonApiDatasourceImpl(dio: mockDio);
  });

  group('getCharacters', () {
    test('should return list of characters when API call succeeds', () async {
      final detailsResponse = Response(
        data: {
          "id": 1,
          "name": "bulbasaur",
          "height": 7,
          "weight": 69,
          "types": [
            {
              "type": {"name": "grass"},
            },
          ],
          "abilities": [
            {
              "ability": {"name": "overgrow"},
            },
          ],
          "sprites": {
            "other": {
              "official-artwork": {
                "front_default": "https://example.com/bulbasaur.jpg",
              },
            },
          },
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      final response = Response(
        data: {
          "count": 1118,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/",
            },
          ],
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(
        () => mockDio.get(
          '${ApiConfig.baseUrl}/pokemon',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => response);
      when(
        () => mockDio.get('https://pokeapi.co/api/v2/pokemon/1/'),
      ).thenAnswer((_) async => detailsResponse);

      final result = await datasource.getCharacters();

      expect(result, isA<List<CharacterModel>>());
      expect(result.length, 1);
      verify(
        () => mockDio.get(
          '${ApiConfig.baseUrl}/pokemon',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
      verify(
        () => mockDio.get('https://pokeapi.co/api/v2/pokemon/1/'),
      ).called(1);
    });

    test('should throw ServerFailure when API call fails', () async {
      when(
        () => mockDio.get(
          '${ApiConfig.baseUrl}/pokemon',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Failed to load characters',
        ),
      );

      expect(() => datasource.getCharacters(), throwsA(isA<ServerFailure>()));
    });
  });

  group('getCharacterById', () {
    test('should return character when API call succeeds', () async {
      final response = Response(
        data: {
          "id": 1,
          "name": "bulbasaur",
          "height": 7,
          "weight": 69,
          "types": [
            {
              "type": {"name": "grass"},
            },
          ],
          "abilities": [
            {
              "ability": {"name": "overgrow"},
            },
          ],
          "sprites": {
            "other": {
              "official-artwork": {
                "front_default": "https://example.com/bulbasaur.jpg",
              },
            },
          },
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(
        () => mockDio.get('${ApiConfig.baseUrl}/pokemon/1'),
      ).thenAnswer((_) async => response);

      final result = await datasource.getCharacterById(1);

      expect(result, isA<CharacterModel>());
      expect(result.id, 1);
      expect(result.name, 'bulbasaur');
      expect(result.types, ['grass']);
      expect(result.abilities, ['overgrow']);
      verify(() => mockDio.get('${ApiConfig.baseUrl}/pokemon/1')).called(1);
    });

    test('should throw ServerFailure when API call fails', () async {
      when(() => mockDio.get('${ApiConfig.baseUrl}/pokemon/1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Failed to load character',
        ),
      );

      expect(
        () => datasource.getCharacterById(1),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
