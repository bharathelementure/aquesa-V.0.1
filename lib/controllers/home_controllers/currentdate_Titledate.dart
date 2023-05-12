
import 'package:flutter/material.dart';
import 'package:otp_auth/utils/dart_Utils.dart' as date_util;

class CurrentDateTitleDate extends StatelessWidget {
  const CurrentDateTitleDate({
    super.key,
    required this.currentDateTime,
  });

  final DateTime currentDateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        date_util.UtilsDate.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: const TextStyle(
            color: Color(0xff2A3F74),
            fontSize: 20,
            fontFamily: 'raleway',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
//  date Picker
  /*Widget DatePicker() {
    late DateTimeRange dateRange = DateTimeRange(
        start: DateTime(2021, 11, 5), end: DateTime(2025, 12, 31));
    // start: DateTime.now().subtract(const Duration(days: 7)),
    // end: DateTime.now());

    Future PickDateRange(BuildContext context) async {
      final start = dateRange.start;
      final end = dateRange.end;

      final initialDateRange = DateTimeRange(
          start: DateTime.now().subtract(const Duration(days: 7)),
          end: DateTime.now());
      DateTimeRange? newDateRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          initialDateRange: dateRange);
      if (newDateRange == null) return;
      setState(() {
        dateRange = newDateRange;
      });
    }

    String getForm() {
      if (dateRange == null) {
        return 'Form';
      } else {
        return DateFormat('MM-dd-yyyy').format(dateRange.start);
      }
    }

    String getUntil() {
      if (dateRange == null) {
        return 'Until';
      } else {
        return DateFormat('MM-dd-yyyy').format(dateRange.end);
      }
    }

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
              child: ElevatedButton(
                  onPressed: () => PickDateRange(context),
                  child: Text(
                    getForm(),
                    style: const TextStyle(),
                  ))),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Expanded(
              child: ElevatedButton(
                  onPressed: () => PickDateRange(context),
                  child: Text(
                    getUntil(),
                    style: const TextStyle(),
                  )))
        ],
      ),
    );
  }*/
  // textbutton week month year
  /*Widget monthData() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Week',
                style: TextStyle(
                    fontFamily: 'raleway',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2A3F74)),
              )),
          const SizedBox(
            width: 10,
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Month',
                style: TextStyle(
                    fontFamily: 'raleway',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2A3F74)),
              )),
          const SizedBox(
            width: 10,
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Yearly',
                style: TextStyle(
                    fontFamily: 'raleway',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2A3F74)),
              )),
        ],
      ),
    );
  }*/

  //topView
  /*Widget topView() {
    return Container(
      height: height * 0.35,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xff488BC8).withOpacity(0.7),
                const Color(0xff488BC8).withOpacity(0.5),
                const Color(0xff488BC8).withOpacity(0.3)
              ],
              begin: const FractionalOffset(0, 0),
              end: const FractionalOffset(0, 1),
              stops: const [0, 0.5, 1],
              tileMode: TileMode.clamp),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: Offset(4, 4),
                spreadRadius: 2)
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CurrentDateTitleDate(currentDateTime: currentDateTime),
          HorizontalListView()
        ],
      ),
    );
  }*/
