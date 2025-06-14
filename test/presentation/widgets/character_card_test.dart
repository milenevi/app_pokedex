import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_app/domain/entities/character.dart';
import 'package:pokedex_app/presentation/widgets/character_card.dart';

class MockCharacter extends Mock implements Character {}

void main() {
  late Character character;

  setUp(() {
    character = Character(
      id: 1,
      name: 'bulbasaur',
      thumbnailUrl: 'https://example.com/bulbasaur.jpg',
      types: ['grass'],
      abilities: ['overgrow'],
      height: 7,
      weight: 69,
      description: 'A grass type Pokémon',
    );
  });

  testWidgets('should display character name and types', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterCard(character: character, onTap: () {})),
      ),
    );

    expect(find.text('BULBASAUR'), findsOneWidget);
    expect(find.text('GRASS'), findsOneWidget);
  });

  testWidgets('should display character image', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterCard(character: character, onTap: () {})),
      ),
    );

    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('should call onTap when tapped', (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CharacterCard(character: character, onTap: () => tapped = true),
        ),
      ),
    );

    await tester.tap(find.byType(CharacterCard));
    expect(tapped, true);
  });

  testWidgets('should show loading indicator while image is loading', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterCard(character: character, onTap: () {})),
      ),
    );

    // The loading indicator should be shown immediately
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error icon when image fails to load', (
    tester,
  ) async {
    character = Character(
      id: 1,
      name: 'bulbasaur',
      thumbnailUrl: 'invalid_url',
      types: ['grass'],
      abilities: ['overgrow'],
      height: 7,
      weight: 69,
      description: 'A grass type Pokémon',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterCard(character: character, onTap: () {})),
      ),
    );

    // Get the CachedNetworkImage widget
    final image = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );

    // Call the errorWidget builder directly
    final errorWidget = image.errorWidget?.call(
      tester.element(find.byType(CachedNetworkImage)),
      'invalid_url',
      Exception('Failed to load image'),
    );

    // Rebuild with the error widget
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: Center(child: errorWidget))),
    );

    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });

  testWidgets('should display error icon with correct color', (tester) async {
    character = Character(
      id: 1,
      name: 'bulbasaur',
      thumbnailUrl: 'invalid_url',
      types: ['grass'],
      abilities: ['overgrow'],
      height: 7,
      weight: 69,
      description: 'A grass type Pokémon',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterCard(character: character, onTap: () {})),
      ),
    );

    // Get the CachedNetworkImage widget
    final image = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );

    // Call the errorWidget builder directly
    final errorWidget = image.errorWidget?.call(
      tester.element(find.byType(CachedNetworkImage)),
      'invalid_url',
      Exception('Failed to load image'),
    );

    // Rebuild with the error widget
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: Center(child: errorWidget))),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
    expect(icon.color, Colors.white);
  });

  testWidgets('should display error icon with correct size', (tester) async {
    character = Character(
      id: 1,
      name: 'bulbasaur',
      thumbnailUrl: 'invalid_url',
      types: ['grass'],
      abilities: ['overgrow'],
      height: 7,
      weight: 69,
      description: 'A grass type Pokémon',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterCard(character: character, onTap: () {})),
      ),
    );

    // Get the CachedNetworkImage widget
    final image = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );

    // Call the errorWidget builder directly
    final errorWidget = image.errorWidget?.call(
      tester.element(find.byType(CachedNetworkImage)),
      'invalid_url',
      Exception('Failed to load image'),
    );

    // Rebuild with the error widget
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: Center(child: errorWidget))),
    );

    final icon = tester.widget<Icon>(find.byIcon(Icons.error_outline));
    expect(icon.size, 30);
  });

  testWidgets('should display character name with correct style', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CharacterCard(character: character, onTap: () {})),
      ),
    );

    final nameText = tester.widget<Text>(find.text('BULBASAUR'));
    expect(nameText.style?.color, Colors.white);
    expect(nameText.style?.fontSize, 16.0);
    expect(nameText.style?.fontWeight, FontWeight.bold);
  });
}
