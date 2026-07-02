import 'package:day_challenge/pages/home/widgets/challenge_calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders timeline days and supports selection', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ChallengeCalendarTimeline()),
      ),
    );

    expect(find.text('Mon'), findsOneWidget);
    expect(find.text('12'), findsWidgets);

    await tester.scrollUntilVisible(find.text('Wed').first, 100);
    await tester.tap(find.text('Wed').first);
    await tester.pumpAndSettle();

    expect(find.byType(ChallengeCalendarTimeline), findsOneWidget);
  });
}
