import 'package:flutter_test/flutter_test.dart';
import 'package:lab2/main.dart';

void main() {
  testWidgets('Lab 2 HomeScreen loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that HomeScreen loads and exercises are displayed.
    expect(find.text('Lab 2 – Flutter UI Fundamentals'), findsOneWidget);
    expect(find.text('Exercise 3 – Layout Demo'), findsOneWidget);
    expect(find.text('Exercise 4 – App Structure & Theme'), findsOneWidget);
    expect(find.text('Exercise 5 – Common UI Errors'), findsOneWidget);
  });
}

