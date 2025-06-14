import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/character_detail_title_section.dart';

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

  testWidgets('should display name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailTitleSection(character: character)),
      ),
    );

    expect(find.text('PIKACHU'), findsOneWidget);
  });

  testWidgets('should display name with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailTitleSection(character: character)),
      ),
    );

    final name = tester.widget<Text>(find.text('PIKACHU'));

    expect(name.style?.color, Colors.white);
    expect(name.style?.fontWeight, FontWeight.bold);
    expect(name.style?.letterSpacing, 1.0);
  });

  testWidgets('should display name with correct size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailTitleSection(character: character)),
      ),
    );

    final name = tester.widget<Text>(find.text('PIKACHU'));

    expect(name.style?.fontSize, 24.0);
  });

  testWidgets('should display name with correct alignment', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterDetailTitleSection(character: character)),
      ),
    );

    final name = tester.widget<Text>(find.text('PIKACHU'));

    expect(name.textAlign, TextAlign.center);
  });

  testWidgets('should display empty text when name is empty', (tester) async {
    final characterWithNoName = Character(
      id: 1,
      name: '',
      thumbnailUrl: 'https://example.com/pikachu.png',
      types: ['ELECTRIC'],
      abilities: ['STATIC', 'LIGHTNING_ROD'],
      height: 4,
      weight: 60,
      description: 'A mouse-like Pokémon that can generate electricity.',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterDetailTitleSection(character: characterWithNoName),
        ),
      ),
    );

    expect(find.text(''), findsOneWidget);
  });
}
