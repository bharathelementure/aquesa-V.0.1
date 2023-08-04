import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:otp_auth/Pages/verifyemailPage.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  group('VerifyEmailPage Widget Tests', () {
    late VerifyEmailPage verifyEmailPage;
    late MockFirebaseAuth mockFirebaseAuth;
    late User currentUser;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      currentUser = MockUser();
      when(() => mockFirebaseAuth.currentUser).thenReturn(currentUser as User? Function());
      verifyEmailPage = VerifyEmailPage();
    });

    testWidgets('VerifyEmailPage shows Graph when email is verified',
        (WidgetTester tester) async {
      // Set the user email as verified
      when(() => currentUser.emailVerified).thenReturn(true as bool Function());

      await tester.pumpWidget(MaterialApp(
        home: verifyEmailPage,
      ));

      // Verify that the Graph widget is displayed
      expect(find.byType(Graph), findsOneWidget);
      expect(find.text('A verification email has been sent to your email'),
          findsNothing);
    });

    testWidgets('VerifyEmailPage sends verification email on initialization',
        (WidgetTester tester) async {
      // Set the user email as not verified initially
      when(() => currentUser.emailVerified).thenReturn(false as bool Function());

      await tester.pumpWidget(MaterialApp(
        home: verifyEmailPage,
      ));

      // Verify that the verification email is sent on initialization
      verify(() => currentUser.sendEmailVerification()).called(1);
    });

    testWidgets('VerifyEmailPage resends email when resend button is tapped',
        (WidgetTester tester) async {
      // Set the user email as not verified initially
      when(() => currentUser.emailVerified).thenReturn(false as bool Function());

      await tester.pumpWidget(MaterialApp(
        home: verifyEmailPage,
      ));

      // Verify that the resend button is initially disabled
      final resendButton = find.byType(ElevatedButton);
      expect(resendButton, findsOneWidget);
      expect(tester.widget<ElevatedButton>(resendButton).enabled, isFalse);

      // Fast-forward time by 5 seconds to enable the resend button
      await tester.pump(const Duration(seconds: 5));

      // Verify that the resend button is enabled after some time
      expect(tester.widget<ElevatedButton>(resendButton).enabled, isTrue);

      // Tap on the resend button
      await tester.tap(resendButton);
      await tester.pumpAndSettle();

      // Verify that the resendVerificationEmail function is called
      verify(() => currentUser.sendEmailVerification()).called(2);
    });

    testWidgets(
        'VerifyEmailPage cancels and signs out when cancel button is tapped',
        (WidgetTester tester) async {
      // Set the user email as not verified initially
      when(() => currentUser.emailVerified).thenReturn(false as bool Function());

      await tester.pumpWidget(MaterialApp(
        home: verifyEmailPage,
      ));

      // Tap on the cancel button
      final cancelButton = find.byType(TextButton);
      expect(cancelButton, findsOneWidget);
      await tester.tap(cancelButton);
      await tester.pumpAndSettle();

      // Verify that the signOut function is called
      verify(() => mockFirebaseAuth.signOut()).called(1);
    });
  });
}

// Mock FirebaseAuth class
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock User class
class MockUser extends Mock implements User {}

// Mock Graph widget
class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
