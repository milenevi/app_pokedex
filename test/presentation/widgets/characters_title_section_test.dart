import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/widgets/characters_title_section.dart';

void main() {
  testWidgets('should display default title when no search query', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharactersTitleSection(searchQuery: '')),
      ),
    );

    expect(find.text('POKÉMON COLLECTION'), findsOneWidget);
  });

  testWidgets('should display search results title when search query exists', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharactersTitleSection(searchQuery: 'pikachu')),
      ),
    );

    expect(find.text('RESULTADOS PARA "PIKACHU"'), findsOneWidget);
  });

  testWidgets('should display title with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharactersTitleSection(searchQuery: '')),
      ),
    );

    final title = tester.widget<Text>(find.text('POKÉMON COLLECTION'));

    expect(title.style?.color, const Color(0xFF303943));
    expect(title.style?.fontWeight, FontWeight.bold);
    expect(title.style?.letterSpacing, 1.0);
  });

  testWidgets('should display title with correct size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharactersTitleSection(searchQuery: '')),
      ),
    );

    final title = tester.widget<Text>(find.text('POKÉMON COLLECTION'));

    expect(title.style?.fontSize, 16.0);
  });

  testWidgets('should display title with correct alignment', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharactersTitleSection(searchQuery: '')),
      ),
    );

    final title = tester.widget<Text>(find.text('POKÉMON COLLECTION'));

    expect(title.textAlign, TextAlign.left);
  });
}
