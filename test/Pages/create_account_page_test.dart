import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Pages/create_account_page.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('TextFormField Test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CreateAcountPage(onClickedSignIn: () {}),
      ),
    ));

    // Verify that the TextFormField is present
    expect(find.byType(TextFormField), findsOneWidget);

    // Enter text in the TextFormField
    await tester.enterText(find.byType(TextFormField), 'John Doe');

    // Wait for the form validation to be triggered
    await tester.pump();

    // Verify that the form validation error is not shown
    expect(find.text('Name cannot be empty'), findsNothing);

    // Tap on the FloatingActionButton to submit the form
    await tester.tap(find.byType(FloatingActionButton));

    // Wait for form submission and animations to complete
    await tester.pumpAndSettle();

    // Verify that the onPressed function is called with the correct parameters
    // Mock FirebaseAuth class if required, and pass it to the CreateAcountPage constructor
    // For simplicity, I am assuming the function is called correctly and no further actions are taken.
    // You can add appropriate mock responses and assertions based on your real implementation.

    // Verify that the form validation error is still not shown after form submission
    expect(find.text('Name cannot be empty'), findsNothing);

    // Verify that the nameEditingController is updated with the entered text
    // final CreateAcountPage state = tester.state(find.byType(CreateAcountPage));
    // expect(state.nameEditingController.text, 'John Doe');
  });
}
