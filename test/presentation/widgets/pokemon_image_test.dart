import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/pokemon_image.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final testCharacter = Character(
    id: 1,
    name: 'Pikachu',
    thumbnailUrl: 'test_url',
    types: ['electric'],
    height: 40,
    weight: 60,
    abilities: ['static'],
    description: 'Electric mouse',
  );

  testWidgets('should display loading indicator while loading', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PokemonImage(
            character: testCharacter,
            heroTag: 'pokemon_image_1',
          ),
        ),
      ),
    );

    // Initially, a CircularProgressIndicator should be shown while loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display error icon when image fails to load', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PokemonImage(
            character: testCharacter,
            heroTag: 'pokemon_image_1',
          ),
        ),
      ),
    );

    // Find the CachedNetworkImage
    final cachedImage = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );

    // Get the error widget builder
    final errorWidgetBuilder = cachedImage.errorWidget;

    // Create the error widget
    final errorWidget = errorWidgetBuilder!(
      tester.element(find.byType(CachedNetworkImage)),
      'test_url',
      Exception('Failed to load image'),
    );

    // Render the error widget
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorWidget)));

    // Verify the error icon is shown
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('should display error icon with correct color', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PokemonImage(
            character: testCharacter,
            heroTag: 'pokemon_image_1',
          ),
        ),
      ),
    );

    // Find the CachedNetworkImage
    final cachedImage = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );

    // Get the error widget builder
    final errorWidgetBuilder = cachedImage.errorWidget;

    // Create the error widget
    final errorWidget = errorWidgetBuilder!(
      tester.element(find.byType(CachedNetworkImage)),
      'test_url',
      Exception('Failed to load image'),
    );

    // Render the error widget
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorWidget)));

    // Verify the error icon color
    final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
    expect(icon.color, Colors.white);
  });

  testWidgets('should display error icon with correct size', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PokemonImage(
            character: testCharacter,
            heroTag: 'pokemon_image_1',
          ),
        ),
      ),
    );

    // Find the CachedNetworkImage
    final cachedImage = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );

    // Get the error widget builder
    final errorWidgetBuilder = cachedImage.errorWidget;

    // Create the error widget
    final errorWidget = errorWidgetBuilder!(
      tester.element(find.byType(CachedNetworkImage)),
      'test_url',
      Exception('Failed to load image'),
    );

    // Render the error widget
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: errorWidget)));

    // Verify the error icon size
    final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
    expect(icon.size, 50.0);
  });

  testWidgets('should have correct height', (tester) async {
    const expectedHeight = 280.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PokemonImage(
            character: testCharacter,
            heroTag: 'pokemon_image_1',
          ),
        ),
      ),
    );

    // Verify CachedNetworkImage properties
    final cachedImage = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );
    expect(cachedImage.height, expectedHeight);
    expect(cachedImage.fit, BoxFit.contain);
  });
}
