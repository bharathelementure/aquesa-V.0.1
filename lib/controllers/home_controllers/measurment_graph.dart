// ignore_for_file: unused_local_variable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:otp_auth/controllers/graph_api.dart';

class MeasurmentGraph extends StatefulWidget {
  const MeasurmentGraph({
    super.key,
    required this.rangeDate,
  });

  final DateTimeRange rangeDate;

  @override
  State<MeasurmentGraph> createState() => _MeasurmentGraphState();
}

class _MeasurmentGraphState extends State<MeasurmentGraph> {
  @override
  void initState() {
    // apiConsumption();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool showTouchTooltip;
    int start = int.parse('${widget.rangeDate.start.day}');
    int end = int.parse('${widget.rangeDate.end.day}');
    // final double? interval;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: LineChart(
          swapAnimationCurve: Curves.easeInOut,
          swapAnimationDuration: const Duration(milliseconds: 400),
          LineChartData(
              minX: start.toDouble(),
              maxX: end.toDouble(),
              minY: 0,
              maxY: 6,
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(sideTitles: SideTitles()),
                rightTitles: AxisTitles(sideTitles: SideTitles()),
                topTitles: AxisTitles(sideTitles: SideTitles()),
                // LineTitles.getTitleData(),
              ),
              lineTouchData: LineTouchData(
                  enabled: showTouchTooltip = true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: const Color(0xff2A3F74),
                    getTooltipItems: (touchedSpots) => touchedSpots
                        .map((spot) => LineTooltipItem(
                              '${NumberFormat.compact().format(spot.y * 100)} L',
                              // '${NumberFormat.simpleCurrency().format(spot.x)}',
                              // '${spot.y.toInt()}:00',
                              const TextStyle(color: Color(0xffFFFFFF)),
                            ))
                        .toList(),
                  )),
              gridData: FlGridData(
                drawHorizontalLine: false,
                // drawVerticalLine: false
                /* drawVerticalLine: true,
        getDrawingVerticalLine: (_) => FlLine(
          color: Colors.blue,strokeWidth: 0.5
        )*/
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                    spots: [
                      const FlSpot(0, 5.98),
                      const FlSpot(1, 4.356),
                      const FlSpot(2, 5.093),
                      const FlSpot(3, 2.349),
                      const FlSpot(4, 4.986),
                      const FlSpot(5, 1.341),
                      const FlSpot(6, 3.451),
                      const FlSpot(7, 2.0934),
                      const FlSpot(8, 5.8923),
                      const FlSpot(9, 2.5641),
                      const FlSpot(10, 5.510),
                      const FlSpot(11, 3.462),
                      const FlSpot(12, 5.018),
                      const FlSpot(13, 3.156),
                      const FlSpot(14, 5.0153),
                      const FlSpot(15, 5.2671),
                      const FlSpot(16, 1.561),
                      const FlSpot(17, 5.0821),
                      const FlSpot(18, 3.947),
                      const FlSpot(19, 5.0153),
                      const FlSpot(20, 5.2671),
                      const FlSpot(21, 1.561),
                      const FlSpot(22, 5.0821),
                      const FlSpot(23, 3.947),
                      const FlSpot(24, 5.0153),
                      const FlSpot(25, 5.2671),
                      const FlSpot(26, 1.561),
                      const FlSpot(27, 5.0821),
                      const FlSpot(28, 3.947),
                      const FlSpot(29, 5.0153),
                      const FlSpot(30, 5.2671),
                      const FlSpot(31, 1.561),
                    ],
                    isCurved: true,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    color: const Color(0xff2A3F74),
                    // gradient: LinearGradient(colors: [Color(0x00FFFFFFF),Color(0xffFFFFFF)]),
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                            colors: [
                              const Color(0xff3E8BD4).withOpacity(0),
                              const Color(0xffFBFBFB)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)))
              ])),
    );
  }
}
