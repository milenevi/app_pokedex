import 'package:dio/dio.dart';
import '../../core/error/failures.dart';
import '../../core/util/api_config.dart';
import '../models/character_model.dart';

abstract class PokemonApiDatasource {
  Future<List<CharacterModel>> getCharacters({int offset = 0, int limit = 20});
  Future<CharacterModel> getCharacterById(int id);
  Future<List<CharacterModel>> searchCharacters(String query);
}

class PokemonApiDatasourceImpl implements PokemonApiDatasource {
  final Dio dio;

  PokemonApiDatasourceImpl({required this.dio});

  @override
  Future<List<CharacterModel>> getCharacters({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final response = await dio.get(
        '${ApiConfig.baseUrl}/pokemon',
        queryParameters: {'offset': offset, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final results = response.data['results'] as List<dynamic>;

        // A lista de resultados só contém o nome e URL, então precisamos fazer requisições
        // individuais para obter os detalhes completos de cada pokémon
        final List<CharacterModel> characters = [];

        for (final pokemon in results) {
          final pokemonUrl = pokemon['url'] as String;

          final detailsResponse = await dio.get(pokemonUrl);

          if (detailsResponse.statusCode == 200) {
            final character = CharacterModel.fromJson(detailsResponse.data);
            characters.add(character);
          }
        }

        return characters;
      } else {
        throw ServerFailure('Erro ao buscar pokémons: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkFailure();
      } else {
        throw ServerFailure('Erro na requisição: ${e.message}');
      }
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final response = await dio.get('${ApiConfig.baseUrl}/pokemon/$id');

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data);
      } else {
        throw ServerFailure('Erro ao buscar pokémon: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkFailure();
      } else {
        throw ServerFailure('Erro na requisição: ${e.message}');
      }
    } catch (e) {
      throw UnexpectedFailure();
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    // Implementation needed
    throw UnimplementedError();
  }
}
