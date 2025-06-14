import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/description_section.dart';

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

  testWidgets('should display description', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DescriptionSection(character: character)),
      ),
    );

    expect(
      find.text('A mouse-like Pokémon that can generate electricity.'),
      findsOneWidget,
    );
  });

  testWidgets('should display section title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DescriptionSection(character: character)),
      ),
    );

    expect(find.text('DESCRIPTION'), findsOneWidget);
  });

  testWidgets('should display title with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DescriptionSection(character: character)),
      ),
    );

    final title = tester.widget<Text>(find.text('DESCRIPTION'));

    expect(title.style?.color, Colors.white);
    expect(title.style?.fontWeight, FontWeight.bold);
    expect(title.style?.letterSpacing, 1.0);
  });

  testWidgets('should display title with correct size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DescriptionSection(character: character)),
      ),
    );

    final title = tester.widget<Text>(find.text('DESCRIPTION'));

    expect(title.style?.fontSize, 16.0);
  });

  testWidgets('should display title with correct alignment', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DescriptionSection(character: character)),
      ),
    );

    final title = tester.widget<Text>(find.text('DESCRIPTION'));

    expect(title.textAlign, TextAlign.left);
  });

  testWidgets('should display description with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: DescriptionSection(character: character)),
      ),
    );

    final description = tester.widget<Text>(
      find.text('A mouse-like Pokémon that can generate electricity.'),
    );

    expect(description.style?.color, Colors.white70);
    expect(description.style?.fontSize, 16.0);
  });

  testWidgets('should display default message when description is empty', (
    tester,
  ) async {
    final characterWithNoDescription = Character(
      id: 1,
      name: 'Pikachu',
      thumbnailUrl: 'https://example.com/pikachu.png',
      types: ['ELECTRIC'],
      abilities: ['STATIC', 'LIGHTNING_ROD'],
      height: 4,
      weight: 60,
      description: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DescriptionSection(character: characterWithNoDescription),
        ),
      ),
    );

    expect(
      find.text('No description available for this Pokémon.'),
      findsOneWidget,
    );
  });
}
