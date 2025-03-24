import 'package:mobx/mobx.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_character_by_id.dart';

part 'character_detail_controller.g.dart';

class CharacterDetailController = _CharacterDetailControllerBase
    with _$CharacterDetailController;

enum CharacterDetailState { initial, loading, loaded, error }

abstract class _CharacterDetailControllerBase with Store {
  final GetCharacterById getCharacterById;

  _CharacterDetailControllerBase(this.getCharacterById);

  @observable
  Character? character;

  @observable
  CharacterDetailState state = CharacterDetailState.initial;

  @observable
  String errorMessage = '';

  @action
  Future<void> loadCharacter(int id) async {
    state = CharacterDetailState.loading;

    final result = await getCharacterById(id);

    result.fold(
      (loadedCharacter) {
        character = loadedCharacter;
        state = CharacterDetailState.loaded;
      },
      (failure) {
        errorMessage = failure.message;
        state = CharacterDetailState.error;
      },
    );
  }

  @action
  void retry(int id) {
    if (state == CharacterDetailState.error) {
      loadCharacter(id);
    }
  }
}
