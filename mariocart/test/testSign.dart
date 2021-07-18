import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/get_navigation.dart';

//test for Container page sign
void main(){
TextEditingController emailController = TextEditingController();

testWidgets('finds a Text widget', (WidgetTester tester) async {
  // Build an App with a Text widget that displays the letter 'H'.
  await tester.pumpWidget(Container(
  child: Text('Sign in with email and password',textDirection: TextDirection.ltr,),
  ));

  // Find a widget that displays the letter 'H'.
  expect(find.text('Sign in with email and password'), findsOneWidget);
});
}
