import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/widgets/characteristic_card.dart';

void main() {
  Future<void> pumpCharacteristicCard(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacteristicCard(label: 'Test Label', value: 'Test Value'),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('should display label and value', (WidgetTester tester) async {
    await pumpCharacteristicCard(tester);

    expect(find.text('Test Label'), findsOneWidget);
    expect(find.text('Test Value'), findsOneWidget);
  });

  testWidgets('should have correct layout structure', (
    WidgetTester tester,
  ) async {
    await pumpCharacteristicCard(tester);

    final card = find.byType(Card);
    expect(card, findsOneWidget);

    final column = find.descendant(of: card, matching: find.byType(Column));
    expect(column, findsOneWidget);

    final texts = find.descendant(of: column, matching: find.byType(Text));
    expect(texts, findsNWidgets(2));
  });

  testWidgets('should have correct padding', (WidgetTester tester) async {
    await pumpCharacteristicCard(tester);

    final card = find.byType(Card);
    final padding = find.descendant(
      of: card,
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is Padding && widget.padding == const EdgeInsets.all(12),
      ),
    );
    expect(padding, findsOneWidget);
  });

  testWidgets('should display value with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacteristicCard(label: 'Height', value: '4')),
      ),
    );

    final value = tester.widget<Text>(find.text('4'));

    expect(value.style?.color, Colors.white);
    expect(value.style?.fontSize, 16.0);
    expect(value.style?.fontWeight, FontWeight.bold);
  });

  testWidgets('should display label with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacteristicCard(label: 'Height', value: '4')),
      ),
    );

    final label = tester.widget<Text>(find.text('Height'));

    expect(label.style?.color, Colors.white70);
    expect(label.style?.fontSize, 14.0);
    expect(label.style?.fontWeight, FontWeight.w500);
  });

  testWidgets('should have correct card properties', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacteristicCard(label: 'Height', value: '4')),
      ),
    );

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.color, Colors.grey[900]);
    expect(card.elevation, 2.0);
  });

  testWidgets('should have correct spacing between label and value', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacteristicCard(label: 'Height', value: '4')),
      ),
    );

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox.height, 4.0);
  });
}
