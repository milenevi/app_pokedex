import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/presentation/widgets/search_field.dart';

void main() {
  late TextEditingController defaultController;

  setUp(() {
    defaultController = TextEditingController();
  });

  tearDown(() {
    defaultController.dispose();
  });

  Future<void> pumpSearchField(
    WidgetTester tester, {
    TextEditingController? controller,
    void Function(String)? onChanged,
    String? hintText,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchField(
            controller: controller ?? defaultController,
            onChanged: onChanged ?? (_) {},
            hintText: hintText ?? 'Search Pokémon',
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('should have correct layout and decoration', (
    WidgetTester tester,
  ) async {
    await pumpSearchField(tester);

    // Check for search icon
    final searchIcon = tester.widget<Icon>(find.byType(Icon));
    expect(searchIcon.icon, Icons.search);
    expect(searchIcon.size, 26);
    expect(searchIcon.color, Colors.black.withAlpha(153));

    // Check TextField decoration
    final textField = tester.widget<TextField>(find.byType(TextField));
    final decoration = textField.decoration as InputDecoration;

    expect(decoration.hintText, 'Search Pokémon');
    expect(decoration.border, InputBorder.none);
    expect(decoration.contentPadding, EdgeInsets.zero);
    expect(decoration.isDense, true);

    // Check container styling
    final container = tester.widget<Container>(find.byType(Container));
    final boxDecoration = container.decoration as BoxDecoration;
    expect(boxDecoration.color, const Color(0xFFF6F6F6));
  });

  testWidgets('should display search field with correct hint text', (
    tester,
  ) async {
    await pumpSearchField(tester, hintText: 'Buscar pokémon');
    expect(find.text('Buscar pokémon'), findsOneWidget);
  });

  testWidgets('should clear text when clear button is tapped', (tester) async {
    defaultController.text = 'test';
    await pumpSearchField(tester);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    expect(defaultController.text, isEmpty);
  });

  testWidgets('should call onChanged when text changes', (tester) async {
    String? changedText;
    await pumpSearchField(tester, onChanged: (value) => changedText = value);

    await tester.enterText(find.byType(TextField), 'test');
    await tester.pump();

    expect(changedText, equals('test'));
  });

  testWidgets('should show clear button when text is not empty', (
    tester,
  ) async {
    defaultController.text = 'test';
    await pumpSearchField(tester);

    expect(find.byIcon(Icons.clear), findsOneWidget);
  });

  testWidgets('should not show clear button when text is empty', (
    tester,
  ) async {
    await pumpSearchField(tester);
    expect(find.byIcon(Icons.clear), findsNothing);
  });

  testWidgets('should update text when controller changes', (
    WidgetTester tester,
  ) async {
    final customController = TextEditingController();
    await pumpSearchField(tester, controller: customController);

    customController.text = 'test';
    await tester.pump();

    expect(find.text('test'), findsOneWidget);
    customController.dispose();
  });

  testWidgets('should have correct decoration', (tester) async {
    await pumpSearchField(tester);

    final container =
        find.byType(Container).evaluate().first.widget as Container;
    final boxDecoration = container.decoration as BoxDecoration;

    expect(boxDecoration.color, const Color(0xFFF6F6F6));
  });

  testWidgets('should have correct style', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchField(controller: defaultController, onChanged: (_) {}),
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));

    expect(textField.style?.color, Colors.black87);
    expect(textField.style?.fontSize, 16.0);
  });
}
