import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/controllers/home_controllers/measurment_graph.dart';

void main() {
  group('MeasurmentGraph', () {
    testWidgets('displays the line chart', (WidgetTester tester) async {
      // Create a DateTimeRange for the rangeDate
      final rangeDate = DateTimeRange(
        start: DateTime(2023, 1, 1),
        end: DateTime(2023, 1, 31),
      );

      // Build the MeasurmentGraph widget
      await tester.pumpWidget(
        MaterialApp(
          home: MeasurmentGraph(rangeDate: rangeDate),
        ),
      );

      // Verify that the LineChart is displayed
      expect(find.byType(LineChart), findsOneWidget);
    });
  });
}
