import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stroll/features/bonfire/ui/widgets/question_card.dart';

void main() {
  group('QuestionCard Tests', () {
    testWidgets('renders QuestionCard with correct text and option', (WidgetTester tester) async {
      const String questionText = 'What is Flutter?';
      const String option = 'A';
      bool isSelected = false;

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuestionCard(
              questionText: questionText,
              option: option,
              onSelectionChanged: (selected) {},
              isSelected: isSelected,
            ),
          ),
        ),
      );

      // Verify the text is displayed
      expect(find.text(questionText), findsOneWidget);
      expect(find.text(option), findsOneWidget);

    });

    testWidgets('toggles selection state when tapped', (WidgetTester tester) async {
      const String questionText = 'What is Flutter?';
      const String option = 'A';
      bool isSelected = false;

      // Create a mock onSelectionChanged callback
      bool selectionChanged = false;
      void onSelectionChanged(bool selected) {
        selectionChanged = selected;
      }

      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuestionCard(
              questionText: questionText,
              option: option,
              onSelectionChanged: onSelectionChanged,
              isSelected: isSelected,
            ),
          ),
        ),
      );

      // Tap the widget to trigger selection change
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      // Verify the selection changed callback was called
      expect(selectionChanged, true);
    });
  });
}
