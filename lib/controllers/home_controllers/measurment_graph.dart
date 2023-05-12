import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MeasurmentGraph extends StatelessWidget {
  const MeasurmentGraph({
    super.key,
    required this.rangeDate,
  });

  final DateTimeRange rangeDate;

  @override
  Widget build(BuildContext context) {
    final bool showTouchTooltip;
    int start = int.parse('${rangeDate.start.day}');
    int end = int.parse('${rangeDate.end.day}');
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
                              '${NumberFormat.simpleCurrency().format(spot.x)}\n'
                              '${spot.y.toInt()}:00',
                              const TextStyle(),
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
                      const FlSpot(0, 6),
                      const FlSpot(1, 5),
                      const FlSpot(2, 6),
                      const FlSpot(4, 5),
                      const FlSpot(6, 4),
                      const FlSpot(8, 6),
                      const FlSpot(9.5, 3),
                      const FlSpot(11, 4)
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
