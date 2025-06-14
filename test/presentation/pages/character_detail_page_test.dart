import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/controllers/character_detail_controller.dart';
import 'package:pokedex_app/presentation/pages/character_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Mock network image widget for testing
class FakeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;

  const FakeNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      height: height ?? 200,
      child: const Placeholder(),
    );
  }
}

class MockCharacterDetailController extends Mock
    implements CharacterDetailController {
  final _state = mobx.Observable(CharacterDetailState.loaded);
  final _character = mobx.Observable<Character?>(null);
  final _errorMessage = mobx.Observable('');

  @override
  CharacterDetailState get state => _state.value;
  set state(CharacterDetailState value) => _state.value = value;

  @override
  Character? get character => _character.value;
  set character(Character? value) => _character.value = value;

  @override
  String get errorMessage => _errorMessage.value;
  set errorMessage(String value) => _errorMessage.value = value;
}

class TestModule extends Module {
  final CharacterDetailController controller;

  TestModule(this.controller);

  @override
  void binds(Injector i) {
    i.addInstance<CharacterDetailController>(controller);
  }
}

void main() {
  late MockCharacterDetailController controller;
  late Character testCharacter;

  setUp(() {
    controller = MockCharacterDetailController();
    testCharacter = Character(
      id: 1,
      name: 'Test Character',
      description: 'Test Description',
      thumbnailUrl: 'test_url',
      height: 100,
      weight: 100,
      types: ['Test Type'],
      abilities: ['Test Ability'],
    );

    // Setup default mock behavior
    when(() => controller.loadCharacter(any())).thenAnswer((_) async {});
    when(() => controller.retry(any())).thenAnswer((_) async {});
    controller.state = CharacterDetailState.loaded;
    controller.character = testCharacter;
    controller.errorMessage = '';
  });

  Future<void> pumpCharacterDetailPage(WidgetTester tester) async {
    final module = TestModule(controller);
    await tester.pumpWidget(
      ModularApp(
        module: module,
        child: MaterialApp(home: CharacterDetailPage(characterId: 1)),
      ),
    );
    await tester.pump();
  }

  testWidgets('should display character name', (WidgetTester tester) async {
    await pumpCharacterDetailPage(tester);
    expect(
      find.text('TEST CHARACTER'),
      findsNWidgets(2),
    ); // Name appears in both app bar and title
  });

  testWidgets('should display character types', (WidgetTester tester) async {
    await pumpCharacterDetailPage(tester);
    expect(find.text('TEST TYPE'), findsOneWidget);
  });

  testWidgets('should display character abilities', (
    WidgetTester tester,
  ) async {
    await pumpCharacterDetailPage(tester);
    expect(
      find.text('Test Ability'),
      findsOneWidget,
    ); // Abilities are not transformed to uppercase
  });

  testWidgets('should display character height and weight', (
    WidgetTester tester,
  ) async {
    await pumpCharacterDetailPage(tester);
    expect(
      find.text('100'),
      findsNWidgets(2),
    ); // Height and weight values without units
  });

  testWidgets('should display character description', (
    WidgetTester tester,
  ) async {
    await pumpCharacterDetailPage(tester);
    expect(
      find.text('Test Description'),
      findsOneWidget,
    ); // Description is not transformed to uppercase
  });

  testWidgets('should show loading indicator when loading', (
    WidgetTester tester,
  ) async {
    controller.state = CharacterDetailState.loading;
    controller.character = null;

    await pumpCharacterDetailPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error view when error occurs', (
    WidgetTester tester,
  ) async {
    controller.state = CharacterDetailState.error;
    controller.character = null;
    controller.errorMessage = 'Test Error';

    await pumpCharacterDetailPage(tester);
    expect(find.text('Test Error'), findsOneWidget);
  });
}
