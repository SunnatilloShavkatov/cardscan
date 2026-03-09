import 'package:cardscan_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders scan demo', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('CardScan Demo'), findsOneWidget);
    expect(find.text('Scan card'), findsOneWidget);
  });
}
