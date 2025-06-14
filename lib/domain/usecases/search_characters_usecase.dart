import 'package:pokedex_app/core/util/result.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/domain/repositories/character_repository.dart';

class SearchCharactersUseCase {
  final CharacterRepository repository;

  SearchCharactersUseCase(this.repository);

  Future<Result<List<Character>>> call(String query) async {
    return repository.getCharacters();
  }
}
