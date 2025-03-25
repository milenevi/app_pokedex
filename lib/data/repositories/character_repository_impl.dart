import '../../core/error/failures.dart';
import '../../core/util/result.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/pokemon_api_datasource.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final PokemonApiDatasource datasource;

  CharacterRepositoryImpl({required this.datasource});

  @override
  Future<Result<List<Character>>> getCharacters({
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final characters = await datasource.getCharacters(
        offset: offset,
        limit: limit,
      );
      return Result.success(characters);
    } on Failure catch (failure) {
      return Result.failure(failure);
    } catch (e) {
      return Result.failure(UnexpectedFailure());
    }
  }

  @override
  Future<Result<Character>> getCharacterById(int id) async {
    try {
      final character = await datasource.getCharacterById(id);
      return Result.success(character);
    } on Failure catch (failure) {
      return Result.failure(failure);
    } catch (e) {
      return Result.failure(UnexpectedFailure());
    }
  }
}
