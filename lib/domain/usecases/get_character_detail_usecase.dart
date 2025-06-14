import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/domain/repositories/character_repository.dart';
import 'package:pokedex_app/core/util/result.dart';

class GetCharacterDetailUseCase {
  final CharacterRepository repository;

  GetCharacterDetailUseCase(this.repository);

  Future<Result<Character>> call(int id) async {
    return await repository.getCharacterById(id);
  }
}
