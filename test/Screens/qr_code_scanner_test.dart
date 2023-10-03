import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Screens/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  group('QrCodeScanner', () {
    testWidgets('Initial state of QR code scanner',
        (WidgetTester tester) async {
      await tester.pumpWidget(const QrCodeScanner());

      expect(find.text('Tap to scan'), findsOneWidget);
      expect(find.text('Barcode Type: null Data: null'), findsNothing);
    });
    testWidgets('QrCodeScanner widget is rendered correctly',
        (WidgetTester tester) async {
      // Build the QrCodeScanner widget
      await tester.pumpWidget(
        const MaterialApp(
          home: QrCodeScanner(),
        ),
      );

      // Verify that the QrCodeScanner widget is rendered
      expect(find.byType(QrCodeScanner), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byKey(const Key('__globalKey__')), findsOneWidget);
      expect(find.byType(QRView), findsOneWidget);
      expect(find.text('Tap to scan'), findsOneWidget);
    });

    testWidgets('Tap on QR code triggers the scan',
        (WidgetTester tester) async {
      // Build the QrCodeScanner widget
      await tester.pumpWidget(
        const MaterialApp(
          home: QrCodeScanner(),
        ),
      );

      // Tap on the QR code
      await tester.tap(find.byKey(const Key('__globalKey__')));

      // Wait for the QR code scan event to be triggered
      await tester.pump();

      // Verify that the scanned QR code result is displayed
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Barcode Type: ${BarcodeFormat.unknown} Data: '),
          findsOneWidget);
    });
  });
}
