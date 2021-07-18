import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/get_navigation.dart';


void main(){
TextEditingController emailController = TextEditingController();

testWidgets('finds a Text widget', (WidgetTester tester) async {
  // Build an App with a Text widget that displays the letter 'H'.
  await tester.pumpWidget(
      MediaQuery(data: MediaQueryData(), child:Directionality(
          textDirection: TextDirection.ltr,
          child:Scaffold(

          body:MediaQuery(data:MediaQueryData(),child:TextField(
  controller: emailController,
      )) ))));

  // Find a widget that displays the letter 'H'.
  expect(find.text(emailController.text), findsOneWidget);
});
}

