import 'package:flutter_test/flutter_test.dart';
import 'package:day_challenge/app/app.dart';

void main() {
  testWidgets('App startup smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DayChallengeApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
  });
}
