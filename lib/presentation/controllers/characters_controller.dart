import 'package:mobx/mobx.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_characters.dart';

part 'characters_controller.g.dart';

class CharactersController = _CharactersControllerBase
    with _$CharactersController;

enum CharactersState { initial, loading, loaded, error }

abstract class _CharactersControllerBase with Store {
  final GetCharacters getCharacters;

  _CharactersControllerBase(this.getCharacters);

  @observable
  ObservableList<Character> characters = ObservableList<Character>();

  @observable
  ObservableList<Character> allCharacters = ObservableList<Character>();

  @observable
  CharactersState state = CharactersState.initial;

  @observable
  String errorMessage = '';

  @observable
  bool hasMoreData = true;

  @observable
  int currentOffset = 0;

  @observable
  String searchQuery = '';

  final int limit = 20;

  @action
  Future<void> loadCharacters({bool refresh = false}) async {
    if (refresh) {
      currentOffset = 0;
      characters.clear();
      allCharacters.clear();
      hasMoreData = true;
      searchQuery = '';
    }

    if (!hasMoreData) return;

    state = CharactersState.loading;

    final result = await getCharacters(offset: currentOffset, limit: limit);

    result.fold(
      (data) {
        if (data.isEmpty) {
          hasMoreData = false;
        } else {
          allCharacters.addAll(data);
          // Se não houver pesquisa, atualize a lista de personagens visíveis
          if (searchQuery.isEmpty) {
            characters.clear();
            characters.addAll(allCharacters);
          } else {
            // Se houver pesquisa, filtre os novos dados e adicione à lista visível
            _filterCharacters();
          }
          currentOffset += limit;
        }
        state = CharactersState.loaded;
      },
      (failure) {
        errorMessage = failure.message;
        state = CharactersState.error;
      },
    );
  }

  @action
  void retryLoading() {
    if (state == CharactersState.error) {
      loadCharacters();
    }
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query.toLowerCase();
    _filterCharacters();
  }

  @action
  void _filterCharacters() {
    if (searchQuery.isEmpty) {
      characters.clear();
      characters.addAll(allCharacters);
      return;
    }

    final filteredList =
        allCharacters.where((pokemon) {
          final nameMatch = pokemon.name.toLowerCase().contains(searchQuery);
          final typeMatch = pokemon.types.any(
            (type) => type.toLowerCase().contains(searchQuery),
          );
          return nameMatch || typeMatch;
        }).toList();

    characters.clear();
    characters.addAll(filteredList);
  }

  @action
  void clearSearch() {
    searchQuery = '';
    _filterCharacters();
  }
}
