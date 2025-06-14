import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/physical_characteristics_section.dart';
import 'package:pokedex_app/presentation/widgets/characteristic_card.dart';

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

  testWidgets('should display height and weight with labels', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PhysicalCharacteristicsSection(character: character),
        ),
      ),
    );

    expect(find.byType(CharacteristicCard), findsNWidgets(2));
    expect(find.text('Height'), findsOneWidget);
    expect(find.text('Weight'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('60'), findsOneWidget);
  });

  testWidgets('should display section title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PhysicalCharacteristicsSection(character: character),
        ),
      ),
    );

    expect(find.text('Physical Characteristics'), findsOneWidget);
  });

  testWidgets('should display title with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PhysicalCharacteristicsSection(character: character),
        ),
      ),
    );

    final title = tester.widget<Text>(find.text('Physical Characteristics'));

    expect(title.style?.color, Colors.white);
    expect(title.style?.fontWeight, FontWeight.bold);
    expect(title.style?.letterSpacing, 1.0);
    expect(title.style?.fontSize, 16.0);
  });

  testWidgets('should display title with correct alignment', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PhysicalCharacteristicsSection(character: character),
        ),
      ),
    );

    final title = tester.widget<Text>(find.text('Physical Characteristics'));
    expect(title.textAlign, TextAlign.left);
  });

  testWidgets('should display characteristics cards with correct layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PhysicalCharacteristicsSection(character: character),
        ),
      ),
    );

    final row = tester.widget<Row>(find.byType(Row));
    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);

    expect(
      row.children.length,
      3,
    ); // 2 Expanded with CharacteristicCard + 1 SizedBox
    expect(sizedBox.height, 8.0);
  });

  testWidgets('should wrap characteristic cards in Expanded widgets', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PhysicalCharacteristicsSection(character: character),
        ),
      ),
    );

    expect(find.byType(Expanded), findsNWidgets(2));
    expect(
      find.descendant(
        of: find.byType(Expanded),
        matching: find.byType(CharacteristicCard),
      ),
      findsNWidgets(2),
    );
  });
}
