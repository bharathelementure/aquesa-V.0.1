import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_auth/controllers/home_controllers/current_date_title_date.dart';
import 'package:otp_auth/utils/dart_utils.dart' as date_util;

void main() {
  group('CurrentDateTitleDate', () {
    testWidgets('displays the correct date', (WidgetTester tester) async {
      // Step 1: Given a current date
      final currentDate = DateTime(2023, 7, 19);

      // Step 2: When the CurrentDateTitleDate widget is built with the current date
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CurrentDateTitleDate(currentDateTime: currentDate),
          ),
        ),
      );

      // Step 3: Then the widget should display the correct date
      expect(
          find.text(
              '${date_util.UtilsDate.months[currentDate.month - 1]} ${currentDate.year}'),
          findsOneWidget);
    });
  });
}
