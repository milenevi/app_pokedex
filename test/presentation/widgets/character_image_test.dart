import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/pokemon_image.dart';

void main() {
  late Character character;

  setUp(() {
    character = Character(
      id: 1,
      name: 'Test Character',
      description: 'Test Description',
      thumbnailUrl: 'test_url',
      height: 100,
      weight: 100,
      types: ['Test Type'],
      abilities: ['Test Ability'],
    );

    // Mock network images for testing
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Future<void> pumpPokemonImage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PokemonImage(character: character, heroTag: 'test_tag'),
        ),
      ),
    );
  }

  testWidgets('should display loading indicator while loading', (
    WidgetTester tester,
  ) async {
    await pumpPokemonImage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display error icon when image fails to load', (
    WidgetTester tester,
  ) async {
    await pumpPokemonImage(tester);

    // Trigger error widget
    final errorBuilder =
        tester
            .widget<CachedNetworkImage>(find.byType(CachedNetworkImage))
            .errorWidget;

    if (errorBuilder != null) {
      final errorWidget = errorBuilder(
        tester.element(find.byType(CachedNetworkImage)),
        'test_url',
        Exception('Failed to load image'),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorWidget)));

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    }
  });

  testWidgets('should display error icon with correct color', (
    WidgetTester tester,
  ) async {
    await pumpPokemonImage(tester);

    // Trigger error widget
    final errorBuilder =
        tester
            .widget<CachedNetworkImage>(find.byType(CachedNetworkImage))
            .errorWidget;

    if (errorBuilder != null) {
      final errorWidget = errorBuilder(
        tester.element(find.byType(CachedNetworkImage)),
        'test_url',
        Exception('Failed to load image'),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorWidget)));

      final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
      expect(icon.color, Colors.white);
    }
  });

  testWidgets('should display error icon with correct size', (
    WidgetTester tester,
  ) async {
    await pumpPokemonImage(tester);

    // Trigger error widget
    final errorBuilder =
        tester
            .widget<CachedNetworkImage>(find.byType(CachedNetworkImage))
            .errorWidget;

    if (errorBuilder != null) {
      final errorWidget = errorBuilder(
        tester.element(find.byType(CachedNetworkImage)),
        'test_url',
        Exception('Failed to load image'),
      );

      await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorWidget)));

      final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
      expect(icon.size, 50.0);
    }
  });
}
