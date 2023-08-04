import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Pages/authPage.dart';
import 'package:otp_auth/Pages/createAccountPage.dart';
import 'package:otp_auth/Screens/registration.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('AuthPage shows Registration when isLogin is true',
      (WidgetTester tester) async {
    // Build our AuthPage with isLogin set to true
    await tester.pumpWidget(const MaterialApp(
      home: AuthPage(),
    ));

    // Verify that the Registration widget is displayed
    expect(find.byType(Registration), findsOneWidget);
    expect(find.byType(CreateAcountPage), findsNothing);

    // Tap on the "Sign Up" button to toggle isLogin to false
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    // Verify that the CreateAcountPage widget is displayed
    expect(find.byType(CreateAcountPage), findsOneWidget);
    expect(find.byType(Registration), findsNothing);
  });

  testWidgets('AuthPage shows CreateAcountPage when isLogin is false',
      (WidgetTester tester) async {
    // Build our AuthPage with isLogin set to false
    await tester.pumpWidget(const MaterialApp(
      home: AuthPage(),
    ));

    // Verify that the CreateAcountPage widget is displayed
    expect(find.byType(CreateAcountPage), findsOneWidget);
    expect(find.byType(Registration), findsNothing);

    // Tap on the "Login" button to toggle isLogin to true
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that the Registration widget is displayed
    expect(find.byType(Registration), findsOneWidget);
    expect(find.byType(CreateAcountPage), findsNothing);
  });
}
