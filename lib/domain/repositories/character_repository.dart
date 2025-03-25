import '../../core/util/result.dart';
import '../entities/character.dart';

abstract class CharacterRepository {
  Future<Result<List<Character>>> getCharacters({
    int offset = 0,
    int limit = 20,
  });
  Future<Result<Character>> getCharacterById(int id);
}
