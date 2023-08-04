import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';
import 'package:otp_auth/Pages/navdrawer.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Mock FirebaseAuth and FirebaseFirestore
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;

  setUp(() {
    // Initialize mock FirebaseAuth and FirebaseFirestore
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
  });

  testWidgets('NavDrawer - Widget Test', (WidgetTester tester) async {
    // Mock current user
    final user = MockUser();
    when(() => user.uid).thenReturn('test_user_id');

    // Set up FirebaseAuth and FirebaseFirestore mocks
    when(() => mockFirebaseAuth.currentUser).thenReturn(user);
    when(() =>
            mockFirebaseFirestore.collection('users').doc('test_user_id').get())
        .thenAnswer((_) => Future.value(MockDocumentSnapshot()
            as FutureOr<DocumentSnapshot<Map<String, dynamic>>>?));

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: NavDrawer(),
      ),
    );

    // Expect to find the user's display name in the drawer header.
    expect(find.text('Test User'),
        findsOneWidget); // Assuming 'Test User' is the display name in the mock data.

    // Expect to find the 'Add Device' ListTile.
    expect(find.text('Add Device'), findsOneWidget);

    // Tap the 'Add Device' ListTile.
    await tester.tap(find.text('Add Device'));
    await tester.pumpAndSettle();

    // Expect navigation to '/qrCodeScanner' route.
    expect(find.text('QR Code Scanner Page'),
        findsOneWidget); // Assuming '/qrCodeScanner' route displays 'QR Code Scanner Page'.

    // Tap the 'Set Daily Limit' ListTile.
    await tester.tap(find.text('Set Daily Limit'));
    await tester.pumpAndSettle();

    // Expect navigation to '/circularsetDailyLimit' route.
    expect(find.text('Circular Set Daily Limit Page'),
        findsOneWidget); // Assuming '/circularsetDailyLimit' route displays 'Circular Set Daily Limit Page'.

    // Tap the 'Today's Consumption' ListTile.
    await tester.tap(find.text('Today\'s Consumption'));
    await tester.pumpAndSettle();

    // Expect navigation to '/setDaily' route.
    expect(find.text('Today\'s Consumption Page'),
        findsOneWidget); // Assuming '/setDaily' route displays 'Today's Consumption Page'.
  });

  testWidgets('NavDrawer - Log Out Test', (WidgetTester tester) async {
    // Mock current user
    final user = MockUser();
    when(() => user.uid).thenReturn('test_user_id');

    // Set up FirebaseAuth and FirebaseFirestore mocks
    when(() => mockFirebaseAuth.currentUser).thenReturn(user);
    when(() =>
            mockFirebaseFirestore.collection('users').doc('test_user_id').get())
        .thenAnswer((_) => Future.value(MockDocumentSnapshot()
            as FutureOr<DocumentSnapshot<Map<String, dynamic>>>?));

    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: NavDrawer(),
      ),
    );

    // Expect to find the 'Log Out' ListTile.
    expect(find.text('Log Out'), findsOneWidget);

    // Tap the 'Log Out' ListTile.
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    // Expect FirebaseAuth.signOut to be called.
    verify(() => mockFirebaseAuth.signOut()).called(1);
  });
}

// Mock classes for FirebaseAuth, FirebaseFirestore, User, and DocumentSnapshot
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockUser extends Mock implements User {}

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}
