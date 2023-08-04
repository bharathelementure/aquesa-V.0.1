import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Pages/siginInPage.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
      // navigatorObservers: [mockNavigatorObserver],
    );
  }

  testWidgets('Test email and password input', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(MyPhone(
      onClickedSignUp: () {},
    )));

    // Find the email and password text fields
    final emailFieldFinder = find.byKey(const Key('email'));
    final passwordFieldFinder = find.byKey(const Key('password'));

    // Enter text into email field and verify
    await tester.enterText(emailFieldFinder, 'test@example.com');
    expect(find.text('test@example.com'), findsOneWidget);

    // Enter text into password field and verify
    await tester.enterText(passwordFieldFinder, 'password');
    expect(find.text('password'), findsOneWidget);
  });
}
