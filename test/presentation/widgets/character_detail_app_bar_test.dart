import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/controllers/character_detail_controller.dart';
import 'package:pokedex_app/presentation/widgets/character_detail_app_bar.dart';

class MockCharacterDetailController extends Mock
    implements CharacterDetailController {}

void main() {
  late CharacterDetailController controller;

  setUp(() {
    controller = MockCharacterDetailController();
    when(() => controller.character).thenReturn(null);
  });

  testWidgets('should display back button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailAppBar(controller: controller)),
      ),
    );

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('should display app bar with black background', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailAppBar(controller: controller)),
      ),
    );

    final appBar = tester.widget<AppBar>(find.byType(AppBar));

    expect(appBar.backgroundColor, Colors.black);
  });

  testWidgets('should display back button with correct color', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailAppBar(controller: controller)),
      ),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.arrow_back));

    expect(icon.color, Colors.white);
  });

  testWidgets('should display back button in IconButton', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailAppBar(controller: controller)),
      ),
    );

    // Find the IconButton widget
    final iconButton = find.byType(IconButton);
    expect(iconButton, findsOneWidget);

    // Find the Icon within the IconButton
    final icon = find.descendant(
      of: iconButton,
      matching: find.byIcon(Icons.arrow_back),
    );
    expect(icon, findsOneWidget);
  });

  testWidgets('should display character name in title', (tester) async {
    when(() => controller.character).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailAppBar(controller: controller)),
      ),
    );

    expect(find.text(''), findsOneWidget);
  });

  testWidgets('should display character name in uppercase', (tester) async {
    when(() => controller.character).thenReturn(
      Character(
        id: 1,
        name: 'Test Character',
        description: 'Test Description',
        thumbnailUrl: 'https://example.com/image.jpg',
        height: 170,
        weight: 70,
        abilities: ['Ability 1', 'Ability 2'],
        types: ['Type 1', 'Type 2'],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailAppBar(controller: controller)),
      ),
    );

    expect(find.text('TEST CHARACTER'), findsOneWidget);
  });
}
