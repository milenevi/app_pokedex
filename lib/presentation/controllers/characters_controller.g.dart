// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharactersController on _CharactersControllerBase, Store {
  late final _$charactersAtom =
      Atom(name: '_CharactersControllerBase.characters', context: context);

  @override
  ObservableList<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$allCharactersAtom =
      Atom(name: '_CharactersControllerBase.allCharacters', context: context);

  @override
  ObservableList<Character> get allCharacters {
    _$allCharactersAtom.reportRead();
    return super.allCharacters;
  }

  @override
  set allCharacters(ObservableList<Character> value) {
    _$allCharactersAtom.reportWrite(value, super.allCharacters, () {
      super.allCharacters = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_CharactersControllerBase.state', context: context);

  @override
  CharactersState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CharactersState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_CharactersControllerBase.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$hasMoreDataAtom =
      Atom(name: '_CharactersControllerBase.hasMoreData', context: context);

  @override
  bool get hasMoreData {
    _$hasMoreDataAtom.reportRead();
    return super.hasMoreData;
  }

  @override
  set hasMoreData(bool value) {
    _$hasMoreDataAtom.reportWrite(value, super.hasMoreData, () {
      super.hasMoreData = value;
    });
  }

  late final _$currentOffsetAtom =
      Atom(name: '_CharactersControllerBase.currentOffset', context: context);

  @override
  int get currentOffset {
    _$currentOffsetAtom.reportRead();
    return super.currentOffset;
  }

  @override
  set currentOffset(int value) {
    _$currentOffsetAtom.reportWrite(value, super.currentOffset, () {
      super.currentOffset = value;
    });
  }

  late final _$searchQueryAtom =
      Atom(name: '_CharactersControllerBase.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$loadCharactersAsyncAction =
      AsyncAction('_CharactersControllerBase.loadCharacters', context: context);

  @override
  Future<void> loadCharacters({bool refresh = false}) {
    return _$loadCharactersAsyncAction
        .run(() => super.loadCharacters(refresh: refresh));
  }

  late final _$_CharactersControllerBaseActionController =
      ActionController(name: '_CharactersControllerBase', context: context);

  @override
  void retryLoading() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.retryLoading');
    try {
      return super.retryLoading();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setSearchQuery');
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _filterCharacters() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase._filterCharacters');
    try {
      return super._filterCharacters();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearch() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.clearSearch');
    try {
      return super.clearSearch();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
characters: ${characters},
allCharacters: ${allCharacters},
state: ${state},
errorMessage: ${errorMessage},
hasMoreData: ${hasMoreData},
currentOffset: ${currentOffset},
searchQuery: ${searchQuery}
    ''';
  }
}
