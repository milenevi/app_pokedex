import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/widgets/pokemon_title.dart';

void main() {
  testWidgets('should display character name in uppercase', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTitle(name: 'Pikachu'))),
    );

    expect(find.text('PIKACHU'), findsOneWidget);
  });

  testWidgets('should display name with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTitle(name: 'Pikachu'))),
    );

    final name = tester.widget<Text>(find.text('PIKACHU'));

    expect(name.style?.color, Colors.white);
    expect(name.style?.fontWeight, FontWeight.bold);
    expect(name.style?.letterSpacing, 2.0);
  });

  testWidgets('should display name with correct size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTitle(name: 'Pikachu'))),
    );

    final name = tester.widget<Text>(find.text('PIKACHU'));

    expect(name.style?.fontSize, 24.0);
  });

  testWidgets('should display name with correct alignment', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTitle(name: 'Pikachu'))),
    );

    final name = tester.widget<Text>(find.text('PIKACHU'));

    expect(name.textAlign, TextAlign.center);
  });

  testWidgets('should handle empty name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTitle(name: ''))),
    );

    expect(find.text(''), findsOneWidget);
  });

  testWidgets('should handle null name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTitle(name: ''))),
    );

    expect(find.text(''), findsOneWidget);
  });
}
