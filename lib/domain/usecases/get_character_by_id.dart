import '../../core/util/result.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetCharacterById {
  final CharacterRepository repository;

  GetCharacterById(this.repository);

  Future<Result<Character>> call(int id) {
    return repository.getCharacterById(id);
  }
}
