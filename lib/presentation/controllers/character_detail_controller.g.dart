// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharacterDetailController on _CharacterDetailControllerBase, Store {
  late final _$characterAtom =
      Atom(name: '_CharacterDetailControllerBase.character', context: context);

  @override
  Character? get character {
    _$characterAtom.reportRead();
    return super.character;
  }

  @override
  set character(Character? value) {
    _$characterAtom.reportWrite(value, super.character, () {
      super.character = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_CharacterDetailControllerBase.state', context: context);

  @override
  CharacterDetailState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CharacterDetailState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
      name: '_CharacterDetailControllerBase.errorMessage', context: context);

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

  late final _$loadCharacterAsyncAction = AsyncAction(
      '_CharacterDetailControllerBase.loadCharacter',
      context: context);

  @override
  Future<void> loadCharacter(int id) {
    return _$loadCharacterAsyncAction.run(() => super.loadCharacter(id));
  }

  late final _$_CharacterDetailControllerBaseActionController =
      ActionController(
          name: '_CharacterDetailControllerBase', context: context);

  @override
  void retry(int id) {
    final _$actionInfo = _$_CharacterDetailControllerBaseActionController
        .startAction(name: '_CharacterDetailControllerBase.retry');
    try {
      return super.retry(id);
    } finally {
      _$_CharacterDetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
character: ${character},
state: ${state},
errorMessage: ${errorMessage}
    ''';
  }
}
