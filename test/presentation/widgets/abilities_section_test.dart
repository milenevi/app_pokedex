import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/abilities_section.dart';

void main() {
  final character = Character(
    id: 1,
    name: 'Pikachu',
    thumbnailUrl: 'https://example.com/pikachu.png',
    types: ['ELECTRIC'],
    abilities: ['STATIC', 'LIGHTNING_ROD'],
    height: 4,
    weight: 60,
    description: 'A mouse-like Pokémon that can generate electricity.',
  );

  testWidgets('should display abilities list', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    expect(find.text('STATIC'), findsOneWidget);
    expect(find.text('LIGHTNING_ROD'), findsOneWidget);
  });

  testWidgets('should display section title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    expect(find.text('Abilities'), findsOneWidget);
  });

  testWidgets('should display title with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    final title = tester.widget<Text>(find.text('Abilities'));

    expect(title.style?.color, Colors.white);
    expect(title.style?.fontWeight, FontWeight.bold);
    expect(title.style?.letterSpacing, 2.0);
  });

  testWidgets('should display title with correct size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    final title = tester.widget<Text>(find.text('Abilities'));

    expect(title.style?.fontSize, 14.0);
  });

  testWidgets('should display title with correct alignment', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    final title = tester.widget<Text>(find.text('Abilities'));

    expect(title.textAlign, TextAlign.left);
  });

  testWidgets('should display abilities with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    final ability = tester.widget<Text>(find.text('STATIC'));

    expect(ability.style?.color, Colors.white.withOpacity(0.7));
    expect(ability.style?.fontSize, 14.0);
    expect(ability.style?.fontWeight, FontWeight.w500);
  });

  testWidgets('should display abilities with correct icon', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    expect(find.byIcon(Icons.star), findsNWidgets(2));
  });

  testWidgets('should display abilities with correct icon color', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.star).first);

    expect(icon.color, Colors.amber[700]);
  });

  testWidgets('should display abilities with correct icon size', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.star).first);

    expect(icon.size, 16.0);
  });

  testWidgets('should display abilities with correct spacing', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: AbilitiesSection(character: character))),
    );

    final column = tester.widget<Column>(
      find.ancestor(of: find.text('STATIC'), matching: find.byType(Column)),
    );

    expect(column.crossAxisAlignment, CrossAxisAlignment.start);
  });

  testWidgets('should not display section when abilities are empty', (
    tester,
  ) async {
    final emptyCharacter = Character(
      id: 1,
      name: 'Pikachu',
      thumbnailUrl: 'https://example.com/pikachu.png',
      types: ['ELECTRIC'],
      abilities: [],
      height: 4,
      weight: 60,
      description: 'A mouse-like Pokémon that can generate electricity.',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AbilitiesSection(character: emptyCharacter)),
      ),
    );

    expect(find.text('Abilities'), findsNothing);
    expect(find.byIcon(Icons.star), findsNothing);
  });
}
