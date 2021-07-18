import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main(){

testWidgets('finds a Text widget', (WidgetTester tester) async {
  // Build an App with a Text widget that displays the letter 'H'.
  await tester.pumpWidget(const GetMaterialApp(
  title:'Flutter Demo',
  ));

  // Find a widget that displays the letter 'H'.
  expect(find.text('Flutter Demo'), findsOneWidget);
});
}
