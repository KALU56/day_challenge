import 'package:flutter_test/flutter_test.dart';
import 'package:day_challenge/app/app.dart';

void main() {
  testWidgets('App startup smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DayChallengeApp());

    // Verify that the startup screen renders correctly.
    expect(find.text('DayChallenge App Startup'), findsOneWidget);
  });
}
