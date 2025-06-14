import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/widgets/pokemon_type_chip.dart';

void main() {
  testWidgets('should display type name in uppercase', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTypeChip(type: 'grass'))),
    );

    expect(find.text('GRASS'), findsOneWidget);
  });

  testWidgets('should have correct background color for grass type', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTypeChip(type: 'grass'))),
    );

    final container = tester.widget<Container>(
      find.ancestor(of: find.text('GRASS'), matching: find.byType(Container)),
    );

    expect(container.decoration, isA<BoxDecoration>());
    expect((container.decoration as BoxDecoration).color, Colors.green);
  });

  testWidgets('should have correct background color for fire type', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTypeChip(type: 'fire'))),
    );

    final container = tester.widget<Container>(
      find.ancestor(of: find.text('FIRE'), matching: find.byType(Container)),
    );

    expect(container.decoration, isA<BoxDecoration>());
    expect((container.decoration as BoxDecoration).color, Colors.red);
  });

  testWidgets('should have correct background color for water type', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTypeChip(type: 'water'))),
    );

    final container = tester.widget<Container>(
      find.ancestor(of: find.text('WATER'), matching: find.byType(Container)),
    );

    expect(container.decoration, isA<BoxDecoration>());
    expect((container.decoration as BoxDecoration).color, Colors.blue);
  });

  testWidgets('should have correct background color for electric type', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTypeChip(type: 'electric'))),
    );

    final container = tester.widget<Container>(
      find.ancestor(
        of: find.text('ELECTRIC'),
        matching: find.byType(Container),
      ),
    );

    expect(container.decoration, isA<BoxDecoration>());
    expect((container.decoration as BoxDecoration).color, Colors.yellow[700]);
  });

  testWidgets('should have correct background color for unknown type', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PokemonTypeChip(type: 'unknown'))),
    );

    final container = tester.widget<Container>(
      find.ancestor(of: find.text('UNKNOWN'), matching: find.byType(Container)),
    );

    expect(container.decoration, isA<BoxDecoration>());
    expect((container.decoration as BoxDecoration).color, Colors.grey);
  });
}
