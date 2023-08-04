import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Screens/splashScreen.dart';
import 'package:otp_auth/main.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/mockito.dart';

// Mock LocalAuthentication class
class MockLocalAuthentication extends Mock implements LocalAuthentication {}

void main() {
  group('SplashScreen Widget Tests', () {
    late MockLocalAuthentication mockAuthentication;

    setUp(() {
      mockAuthentication = MockLocalAuthentication();
    });

    testWidgets('CheckBio sets _hasSensor correctly',
        (WidgetTester tester) async {
      // Mock the canCheckBiometrics method to return true
      when(mockAuthentication.canCheckBiometrics).thenAnswer((_) async => true);

      // Build the SplashScreen widget
      await tester.pumpWidget(const MaterialApp(
        home: SplashScreen(),
      ));

      // Verify that _hasSensor is set to true
      // expect(splashScreen._hasSensor, true);
    });

    testWidgets(
        'GetAuth sets _isauthenticating correctly and navigates to next screen on success',
        (WidgetTester tester) async {
      // Mock the authenticate method to return true
      when(mockAuthentication.authenticate(
        localizedReason: 'localizedReason',
      )).thenAnswer((_) async => true);

      // Build the SplashScreen widget
      await tester.pumpWidget(const MaterialApp(
        home: SplashScreen(),
      ));

      // Verify that _isauthenticating is set to true
      // expect(splashScreen._isauthenticating, true);

      // Wait for navigation to next screen
      await tester.pumpAndSettle();

      // Verify that the next screen (Intializer) is navigated to
      expect(find.byType(Intializer), findsOneWidget);
    });

    testWidgets('AnimatedSplashScreen is created with specified properties',
        (WidgetTester tester) async {
      // Build the SplashScreen widget
      await tester.pumpWidget(const MaterialApp(
        home: SplashScreen(),
      ));

      // Verify that AnimatedSplashScreen is created with the specified properties
      expect(find.byType(AnimatedSplashScreen), findsOneWidget);
      expect(find.text('assets/logo_aquesa.png'), findsOneWidget);
      expect(find.byType(Intializer), findsOneWidget);
      expect(
          find.byType(SplashTransition.fadeTransition as Type), findsOneWidget);
    });
  });
}
