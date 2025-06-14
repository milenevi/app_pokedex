import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/types_section.dart';

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

  testWidgets('should display single type', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: TypesSection(character: character))),
    );

    expect(find.text('ELECTRIC'), findsOneWidget);
  });

  testWidgets('should display multiple types', (tester) async {
    final characterWithMultipleTypes = Character(
      id: 1,
      name: 'Bulbasaur',
      thumbnailUrl: 'https://example.com/bulbasaur.png',
      types: ['GRASS', 'POISON'],
      abilities: ['OVERGROW'],
      height: 7,
      weight: 69,
      description: 'A grass/poison type Pokémon.',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TypesSection(character: characterWithMultipleTypes),
        ),
      ),
    );

    expect(find.text('GRASS'), findsOneWidget);
    expect(find.text('POISON'), findsOneWidget);
  });

  testWidgets('should display title when no types', (tester) async {
    final characterWithNoTypes = Character(
      id: 1,
      name: 'Pikachu',
      thumbnailUrl: 'https://example.com/pikachu.png',
      types: [],
      abilities: ['STATIC', 'LIGHTNING_ROD'],
      height: 4,
      weight: 60,
      description: 'A mouse-like Pokémon that can generate electricity.',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: TypesSection(character: characterWithNoTypes)),
      ),
    );

    expect(find.text('TYPES'), findsOneWidget);
  });

  testWidgets('should display types with correct spacing', (tester) async {
    final characterWithMultipleTypes = Character(
      id: 1,
      name: 'Bulbasaur',
      thumbnailUrl: 'https://example.com/bulbasaur.png',
      types: ['GRASS', 'POISON'],
      abilities: ['OVERGROW'],
      height: 7,
      weight: 69,
      description: 'A grass/poison type Pokémon.',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TypesSection(character: characterWithMultipleTypes),
        ),
      ),
    );

    final wrap = tester.widget<Wrap>(find.byType(Wrap));
    expect(wrap.spacing, 8.0);
  });

  testWidgets('should display types with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: TypesSection(character: character))),
    );

    final title = tester.widget<Text>(find.text('TYPES'));
    expect(title.style?.color, Colors.white);
    expect(title.style?.fontWeight, FontWeight.bold);
    expect(title.style?.letterSpacing, 1.0);
  });

  testWidgets('should display types with correct size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: TypesSection(character: character))),
    );

    final title = tester.widget<Text>(find.text('TYPES'));
    expect(title.style?.fontSize, 16.0);
  });
}
