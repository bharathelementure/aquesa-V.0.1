import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Pages/forgot_password_page.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('ForgotPasswordPage - Widget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ForgotPasswordPage()));

    // Expect to find the "Reset Password" text on the screen.
    expect(find.text('Reset Password'), findsOneWidget);

    // Expect to find the TextFormField for email input.
    expect(find.byType(TextFormField), findsOneWidget);

    // Enter an invalid email address.
    await tester.enterText(find.byType(TextFormField), 'invalid_email');
    await tester.pump();

    // Verify that the validator works and displays an error message.
    expect(find.text('Enter a valid email'), findsOneWidget);

    // Enter a valid email address.
    await tester.enterText(
        find.byType(TextFormField), 'valid_email@example.com');
    await tester.pump();

    // Verify that the error message disappears after entering a valid email.
    expect(find.text('Enter a valid email'), findsNothing);

    // Tap the "Reset password" button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Expect the success toast message.
    expect(find.text('Reset password email sent successfully!'),
        findsOneWidget); // Assuming you display a success toast.

    // Tap the "Reset password" button with an invalid email again.
    await tester.enterText(find.byType(TextFormField), 'invalid_email');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Expect the error toast message.
    expect(find.text('Invalid email format. Please enter a valid email.'),
        findsOneWidget); // Assuming you display an error toast for invalid emails.
  });

  testWidgets('ForgotPasswordPage - Email Verification Test',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: ForgotPasswordPage()));

    // Enter a valid email address.
    await tester.enterText(
        find.byType(TextFormField), 'valid_email@example.com');
    await tester.pump();

    // Tap the "Reset password" button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Expect the email to be sent successfully (mock FirebaseAuth.instance).
    // Replace the 'your_email_verification_page' with the page displayed after sending the email.
    expect(find.text('Enter your verification code'), findsOneWidget);

    // Test the navigation after successful email sending (mock FirebaseAuth.instance).
    // Replace 'YourVerificationPage' with the actual widget displayed after successful email verification.
    expect(find.text('YourVerificationPage'), findsOneWidget);

    // Now, let's test the error case where sending the email fails (mock FirebaseAuth.instance).
    // Replace 'FailedToResetPasswordPage' with the actual widget displayed when sending the email fails.
    expect(find.text('FailedToResetPasswordPage'),
        findsNothing); // Expect the failed widget to be hidden initially.

    // Tap the "Reset password" button again with an invalid email.
    await tester.enterText(find.byType(TextFormField), 'invalid_email');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // Expect the failed widget to be shown when sending the email fails.
    expect(find.text('FailedToResetPasswordPage'), findsOneWidget);
  });
}
