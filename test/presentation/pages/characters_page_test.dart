import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mocktail/mocktail.dart' as mock;
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/controllers/characters_controller.dart';
import 'package:pokedex_app/presentation/pages/characters_page.dart';
import 'package:pokedex_app/core/di/app_module.dart';

class MockCharactersController extends mock.Mock
    implements CharactersController {}

class TestModule extends Module {
  final MockCharactersController mockController;

  TestModule(this.mockController);

  @override
  void binds(Injector i) {
    i.addSingleton<CharactersController>(() => mockController);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockCharactersController mockController;

  setUp(() {
    mockController = MockCharactersController();
    mock.when(() => mockController.state).thenReturn(CharactersState.initial);
    mock
        .when(() => mockController.characters)
        .thenReturn(ObservableList<Character>());
    mock.when(() => mockController.searchQuery).thenReturn('');
    mock.when(() => mockController.loadCharacters()).thenAnswer((_) async {});
  });

  tearDown(() {
    Modular.destroy();
  });

  testWidgets('should show loading indicator when state is initial', (
    tester,
  ) async {
    await tester.pumpWidget(
      ModularApp(
        module: TestModule(mockController),
        child: MaterialApp(home: CharactersPage()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error view when state is error and no characters', (
    tester,
  ) async {
    mock.when(() => mockController.state).thenReturn(CharactersState.error);
    mock.when(() => mockController.errorMessage).thenReturn('Test error');

    await tester.pumpWidget(
      ModularApp(
        module: TestModule(mockController),
        child: MaterialApp(home: CharactersPage()),
      ),
    );

    expect(find.text('Test error'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
  });

  testWidgets('should show no results message when search has no results', (
    tester,
  ) async {
    mock.when(() => mockController.state).thenReturn(CharactersState.loaded);
    mock.when(() => mockController.searchQuery).thenReturn('nonexistent');
    mock
        .when(() => mockController.characters)
        .thenReturn(ObservableList<Character>());

    await tester.pumpWidget(
      ModularApp(
        module: TestModule(mockController),
        child: MaterialApp(home: CharactersPage()),
      ),
    );

    expect(
      find.text('Nenhum Pokémon encontrado para "nonexistent"'),
      findsOneWidget,
    );
  });

  testWidgets('should show character grid when characters are loaded', (
    tester,
  ) async {
    final characters = ObservableList<Character>.of([
      Character(
        id: 1,
        name: 'Pikachu',
        thumbnailUrl: 'test_url',
        types: ['electric'],
        height: 40,
        weight: 60,
        abilities: ['static'],
        description: 'Electric mouse',
      ),
    ]);

    mock.when(() => mockController.state).thenReturn(CharactersState.loaded);
    mock.when(() => mockController.characters).thenReturn(characters);

    await tester.pumpWidget(
      ModularApp(
        module: TestModule(mockController),
        child: MaterialApp(home: CharactersPage()),
      ),
    );

    // Just test that the character name and type appear
    expect(find.text('PIKACHU'), findsOneWidget);
    expect(find.text('ELECTRIC'), findsOneWidget);
  });

  testWidgets('should show error message when loading more characters fails', (
    tester,
  ) async {
    final characters = ObservableList<Character>.of([
      Character(
        id: 1,
        name: 'Pikachu',
        thumbnailUrl: 'test_url',
        types: ['electric'],
        height: 40,
        weight: 60,
        abilities: ['static'],
        description: 'Electric mouse',
      ),
    ]);

    mock.when(() => mockController.state).thenReturn(CharactersState.error);
    mock.when(() => mockController.characters).thenReturn(characters);
    mock
        .when(() => mockController.errorMessage)
        .thenReturn('Failed to load more');

    await tester.pumpWidget(
      ModularApp(
        module: TestModule(mockController),
        child: MaterialApp(home: CharactersPage()),
      ),
    );

    expect(
      find.text('Erro ao carregar mais pokémons: Failed to load more'),
      findsOneWidget,
    );
  });
}
