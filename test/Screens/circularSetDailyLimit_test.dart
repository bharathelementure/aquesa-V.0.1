import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/Screens/circularSetDailyLimit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:wave/wave.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('CircularSetDailyLimit - Widget Test',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: CircularSetDailyLimit()));

    // Expect to find the "Set daily limit" text on the screen.
    expect(find.text('Set daily limit'), findsOneWidget);

    // Expect to find the SfRadialGauge widget.
    expect(find.byType(SfRadialGauge), findsOneWidget);

    // Expect to find the SET button on the screen.
    expect(find.text('SET'), findsOneWidget);

    // Test button tap event
    await tester.tap(find.text('SET'));
    await tester.pumpAndSettle();

    // After tapping the button, expect navigation to '/graph' route.
    expect(find.text('Graph Screen'),
        findsOneWidget); // Assuming '/graph' route has a 'Graph Screen' widget.

    // Check if the wave widget is displayed.
    expect(find.byType(WaveWidget), findsOneWidget);
  });

  testWidgets('CircularSetDailyLimit - Slider Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CircularSetDailyLimit()));

    // Check initial slider value
    expect(find.text('100 Litres'),
        findsOneWidget); // Assuming _volumeValue is initialized to 10.

    // Drag the slider to the left to set the value to 50
    await tester.tapAt(const Offset(200, 300));
    await tester.pump();
    await tester.drag(
        find.byType(MarkerType.circle as Type), const Offset(-100, 0));
    await tester.pump();
    expect(find.text('50 Litres'), findsOneWidget);

    // Drag the slider to the right to set the value to 75
    await tester.tapAt(const Offset(200, 300));
    await tester.pump();
    await tester.drag(
        find.byType(MarkerType.circle as Type), const Offset(100, 0));
    await tester.pump();
    expect(find.text('70 Litres'), findsOneWidget);

    // Set the value to maximum (100)
    await tester.tapAt(const Offset(200, 300));
    await tester.pump();
    await tester.drag(
        find.byType(MarkerType.circle as Type), const Offset(300, 0));
    await tester.pump();
    expect(find.text('100 Litres'), findsOneWidget);

    // Set the value to minimum (0)
    await tester.tapAt(const Offset(200, 300));
    await tester.pump();
    await tester.drag(
        find.byType(MarkerType.circle as Type), const Offset(-300, 0));
    await tester.pump();
    expect(find.text('0 Litres'), findsOneWidget);
  });
}
