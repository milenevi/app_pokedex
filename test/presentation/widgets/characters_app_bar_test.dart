import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/widgets/characters_app_bar.dart';

void main() {
  testWidgets('should display app bar with correct title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(appBar: const CharactersAppBar(isTestMode: true)),
      ),
    );

    expect(find.text('POKÉDEX'), findsOneWidget);
  });

  testWidgets('should display app bar with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(appBar: const CharactersAppBar(isTestMode: true)),
      ),
    );

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, Colors.transparent);
    expect(appBar.elevation, 0);
  });

  testWidgets('should display title with correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(appBar: const CharactersAppBar(isTestMode: true)),
      ),
    );

    final title = tester.widget<Text>(find.text('POKÉDEX'));
    expect(title.style?.color, Colors.white);
    expect(title.style?.fontWeight, FontWeight.bold);
    expect(title.style?.letterSpacing, 1.5);
    expect(title.style?.fontSize, 20);
  });

  testWidgets('should display title with correct alignment', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(appBar: const CharactersAppBar(isTestMode: true)),
      ),
    );

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.centerTitle, true);
  });
}
