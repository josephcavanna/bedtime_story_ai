import 'package:bedtime_story_ai/screens/prompt_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// create widget test for PromptPage
void main() {
  testWidgets('PromptPage has a title, a button, a text field and text output',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: PromptPage()));

    // Verify that widgets are present.
    expect(find.byKey(const Key('promptPageTitle')), findsOneWidget);
    expect(find.text('Tell me a story!'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byKey(const Key('aiOutput')), findsOneWidget);
  });
}