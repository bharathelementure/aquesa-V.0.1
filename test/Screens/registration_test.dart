import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Screens/registration.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('Registration - Widget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Registration(),
      ),
    );

    // Expect to find the TabBar with 'SIGN IN' and 'CREATE ACCOUNT' tabs.
    expect(find.text('SIGN IN'), findsOneWidget);
    expect(find.text('CREATE ACCOUNT'), findsOneWidget);

    // Tap the 'CREATE ACCOUNT' tab.
    await tester.tap(find.text('CREATE ACCOUNT'));
    await tester.pumpAndSettle();

    // Expect to navigate to the 'Create Account' page.
    expect(find.text('Create Account Page'),
        findsOneWidget); // Replace 'Create Account Page' with the actual widget displayed on the 'CREATE ACCOUNT' tab.

    // Tap the 'SIGN IN' tab.
    await tester.tap(find.text('SIGN IN'));
    await tester.pumpAndSettle();

    // Expect to navigate back to the 'Sign In' page.
    expect(find.text('Sign In Page'),
        findsOneWidget); // Replace 'Sign In Page' with the actual widget displayed on the 'SIGN IN' tab.
  });

  testWidgets('Registration - Back Button Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Registration(),
      ),
    );

    // Tap the back button to trigger the 'WillPopScope' handler.
    await tester.pageBack();

    // Expect a toast message with "Press back again to exit".
    expect(find.text('Press back again to exit'), findsOneWidget);

    // Tap the back button again within 2 seconds.
    await tester.pageBack();

    // Expect the app to not exit.
    expect(find.text('Press back again to exit'), findsNothing);

    // Wait for 2 seconds.
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Tap the back button again after 2 seconds.
    await tester.pageBack();

    // Expect the app to exit.
    expect(find.text('Press back again to exit'), findsNothing);
  });
}
