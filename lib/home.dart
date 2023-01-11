// ignore_for_file: unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison

import 'package:otp_auth/dart_Utils.dart' as date_util;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otp_auth/Pages/navdrawer.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  DateTimeRange rangeDate = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now());
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todos = <String>[];

  @override
  void initState() {
    super.initState();
    currentMonthList = date_util.UtilsDate.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController = 
    ScrollController(initialScrollOffset:45.0 * currentDateTime.day);
  }

  //month and year
  Widget TitleDate() {
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

  //current date List
  Widget HorizontalListView() {
    return SizedBox(
      width: width,
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) => ViewGradient(index),
      ),
    );
  }

  Widget ViewGradient(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDateTime = currentMonthList[index];
          });
        },
        child: Container(
          width: 80,
          height: 140,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: (currentMonthList[index].day != currentDateTime.day)
                      ? [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.7),
                          Colors.white.withOpacity(0.6)
                        ]
                      : [
                          const Color(0xffED6184),
                          const Color(0xffEF315B),
                          const Color(0xffE2042D)
                        ],
                  begin: const FractionalOffset(0, 0),
                  end: const FractionalOffset(0, 1),
                  stops: const [0, 0.5, 1],
                  tileMode: TileMode.clamp),
              borderRadius: BorderRadius.circular(40),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black12)
              ]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentMonthList[index].day.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 48,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? const Color(0xff465876)
                              : Colors.white),
                ),
                Text(
                  date_util
                      .UtilsDate.weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          (currentMonthList[index].day != currentDateTime.day)
                              ? const Color(0xff465876)
                              : Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //topView
  Widget topView() {
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
        children: [TitleDate(), HorizontalListView()],
      ),
    );
  }

  //date list with scroll
  Widget DateList() {
    /*final dateList = [
      '01',
      '02',
      '03',
      '04',
      '05',
      '06',
      '07',
      '08',
      '09',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30'
    ];*/
    return SizedBox(
        height: 50,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          // separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemCount: currentMonthList.length,
          itemBuilder: (BuildContext context, int index) => PresentDate(index),
        ));
  }

  Widget PresentDate(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: 48,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      // index == 0,
                      (currentMonthList[index].day != currentDateTime.day)
                          ? const Color(0xffD6D6D6)
                          : const Color(0xff3B7AC5),
                  width: 3),
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xffFFFFFF),
            ),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    // dateList[index],
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? const Color(0xff3B7AC5)
                                : const Color(0xff2A3F74)),
                  ),
                  Text(
                    date_util.UtilsDate
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontFamily: 'raleway',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? const Color(0xff3B7AC5)
                                : const Color(0xff2A3F74)),
                  )
                ],
              ),
            ),
          )),
    );
  }

  //Text of liters saved
  Widget LitersOftext() {
    return SizedBox(
        height: 50,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Text(
            '100',
            style: TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: Color(0xff2A3F74)),
          ),
          const SizedBox(width: 7),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Litres',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Raleway',
                    color: Color(0xff2A3F74)),
              ),
              SizedBox(height: 3),
              Text(
                'of 250 litres',
                style: TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff2A3F74)),
              )
            ],
          ),
        ]));
  }

  //water graph
  Widget waterGraph() {
    final bool showTouchTooltip;
    final double? interval;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: LineChart(
          swapAnimationCurve: Curves.easeInOut,
          swapAnimationDuration: const Duration(milliseconds: 400),
          LineChartData(
              minX: 1,
              maxX: 8,
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

// textbutton week month year
  Widget monthData() {
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
  }

// date Picker
  Widget DatePicker() {
    late DateTimeRange dateRange = DateTimeRange(
        start: DateTime(2021, 11, 5),
         end: DateTime(2025, 12, 31));
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
  }

  @override
  Widget build(BuildContext context) {
    final start = rangeDate.start;
    final end = rangeDate.end;
    // final difference = rangeDate.duration;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      drawer: const NavDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Color(0xff2A3F74),
                size: 27,
              ));
        }),
        /*Container(
          padding: const EdgeInsets.only(left: 10, right: 5),
        ),*/
        title: Image.asset(
          'assets/logo_aquesa.png',
          color: const Color(0xff2A3F74),
          scale: 2,
        ),
        titleSpacing: 0.2,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
        children: [
          SafeArea(
            child: Container(
                height: 550,
                color: const Color(0xffFFFFFF),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleDate(),
                    /*const SizedBox(height: 10),
                    Text(DateFormat('d-M-y').format(DateTime.now()),
                    style: const TextStyle(fontFamily: 'raleway',fontSize: 12,fontWeight: FontWeight.w500,
          color: Color(0xFF2A3F74)),),*/
                    const SizedBox(height: 0),
                    DateList(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 3,
                      color: Color(0xffAFD3F1),
                    ),
                    const SizedBox(height: 10),
                    LitersOftext(),
                    SizedBox(
                      height: 280,
                      child: waterGraph(),
                    ),
                    const Divider(
                      thickness: 3,
                      color: Color(0xffAFD3F1),
                    ),
                    const SizedBox(height: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: rangePickDate,
                                child: Text(
                                  '${start.day}-${start.month}-${start.year}',
                                  style: const TextStyle(),
                                ))),
                        const SizedBox(width: 18),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: rangePickDate,
                                child: Text(
                                  '${end.day}-${end.month}-${end.year}',
                                  style: const TextStyle(),
                                )))
                      ],
                    ),
                    /* const SizedBox(height: 2),
                    Text('Difference:  ${difference.inDays}days',
                    style: const TextStyle(fontWeight: FontWeight.w400,
                    fontSize: 17,fontFamily: 'raleway',
                    color:  Color(0xff2A3F74)),)*/
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Future rangePickDate() async {
    DateTimeRange? newDaterange = await showDateRangePicker(
        context: context,
        initialDateRange: rangeDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (newDaterange == null) return;
    setState(() {
      rangeDate = newDaterange;
    });
  }
}

/*
class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  // late SfRangeValues _values;
  bool showAvg = false;
  List<Color> gradientColors = [Color(0xff23b6e6),Color(0xff02d39a)];

  @override
  /*void initState() {
    _values = SfRangeValues(3, 6);
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff72AFDE),body: SafeArea(
        child: Column(children: [AspectRatio(aspectRatio: 2/2,
    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
    color: Color(0xFFFFFFFF)),child: Padding(padding: EdgeInsets.symmetric(vertical: 20,),
    child: LineChart(LineChartData(minX: 1,maxX: 8,minY: 0,maxY: 6,
        titlesData: FlTitlesData(show: true,
        leftTitles: AxisTitles(sideTitles: SideTitles()),
        rightTitles: AxisTitles(sideTitles: SideTitles()),
        topTitles: AxisTitles(sideTitles: SideTitles())),
        // LineTitles.getTitleData(),

        gridData: FlGridData(drawHorizontalLine: false,
            // show: false,
            getDrawingVerticalLine: (value){return FlLine(color: Color(0xff000000),strokeWidth: 1);}
        ),borderData: FlBorderData(show: true,border: Border.all(color: Color(0xff374d),width: 1),),
    lineBarsData: [LineChartBarData(spots: [FlSpot(0, 3),FlSpot(2.6, 2),FlSpot(4.9, 5),
    FlSpot(6.8, 2.5),FlSpot(8, 4),FlSpot(9.5, 3),FlSpot(11, 4)],isCurved: true,
    color: Color(0xff2A3F74),barWidth: 3,belowBarData: BarAreaData(show: true,
            color: Color(0xffFBFBFB).withOpacity(0.5)))]),
      // showAvg? avgChart() : mainChart(),
    ),),),)],)));


      /*Scaffold(resizeToAvoidBottomInset: false,backgroundColor: Color(0xFFFFFFFF),
    body: SingleChildScrollView(reverse: true,child: Stack(children: [
      Container(height: 350, child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [SizedBox(height: 17,),
        SfRangeSelector(initialValues: _values,min: 2.0,max: 10.0,
        showLabels: true,interval: 1,showTicks: true,activeColor: Color(0xFF3E8BD4),
        inactiveColor: Color(0xFFFBFBFB),enableTooltip: true,
        child: SfCartesianChart(margin: EdgeInsets.all(0),
      primaryXAxis: NumericAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false, maximum: 6),
      series: [SplineAreaSeries(dataSource: [Data(x: 120.0, y: 2),
        Data(x: 140.0, y: 3),
        Data(x: 180.0, y: 4),
        Data(x: 200.0, y: 5), Data(x: 220.0, y: 6), Data(x: 240.0, y: 7),
        Data(x: 260.0, y: 8), Data(x: 190.0, y: 9), Data(x: 200.0, y: 10),
        Data(x: 210.0, y: 11), Data(x: 220.0, y: 12), Data(x: 230.0, y: 13),
        Data(x: 240.0, y: 14), Data(x: 250.0, y: 15), Data(x: 260.0, y: 16)],
          xValueMapper: (Data sales, int index) => sales.x,
          yValueMapper: (Data sales, int index) => sales.y,
          dataLabelSettings: DataLabelSettings(isVisible: true)),],),)],),)
    ],),),);*/
  }
 /* LineChartData mainChart() {
    return LineChartData(gridData: FlGridData(show: true,drawVerticalLine: true,
    getDrawingHorizontalLine: (value){
      return FlLine(color: Color(0xff37434d),strokeWidth: 1);
    }),titlesData: FlTitlesData(show: true,bottomTitles: AxisTitles(sideTitles: SideTitles(
      showTitles: true,reservedSize: 22,
       /* textStyle: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 16,color: Color(0xff68737d))*/
    )),leftTitles: AxisTitles(sideTitles: SideTitles(
      showTitles: true,reservedSize: 28,))),borderData: FlBorderData(show: true,
    border: Border.all(color: Color(0xff37434d),width: 2)),minX: 0,maxX: 11,
    minY: 0,maxY: 6,lineBarsData: [LineChartBarData(spots: [FlSpot(0, 3),FlSpot(2.6, 2),
          FlSpot(4.9, 5),FlSpot(6.8, 3.1),FlSpot(8, 4),FlSpot(9.5, 3),FlSpot(11, 4),],
        isCurved: true,barWidth: 5,color: Color(0xff23b6e6),isStrokeCapRound: true,
        dotData: FlDotData(show: true),belowBarData: BarAreaData(show: true,
            color: Colors.blue.withOpacity(0.5)))]);
  }
  LineChartData avgChart() {
    return LineChartData(lineTouchData: LineTouchData(enabled: false),
    gridData: FlGridData(show: true,drawHorizontalLine: true,
    getDrawingVerticalLine: (value){return FlLine(color: Color(0xff37434d),
    strokeWidth: 1);},getDrawingHorizontalLine: (value){return FlLine(color: Color(0xff37434d),strokeWidth: 1);}),
    titlesData: FlTitlesData(show: true,bottomTitles: AxisTitles(sideTitles: SideTitles(
      showTitles: true,reservedSize: 22,)),leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
    reservedSize: 28,
        // textStyle: TextStyle(fontSize: 16,color: Color(0xff68737d),)
    ))),
      borderData: FlBorderData(show: true,border: Border.all(color: Color(0xff37434d),width: 1)),
    minX: 0,maxX: 11,minY: 0,maxY: 6,
    lineBarsData: [LineChartBarData(spots: [ FlSpot(0, 3.44),
      FlSpot(2.6, 3.44),
      FlSpot(4.9, 3.44),
      FlSpot(6.8, 3.44),
      FlSpot(8, 3.44),
      FlSpot(9.5, 3.44),
      FlSpot(11, 3.44),],isCurved: true,
    color: Color(0xff63678d),barWidth: 5,isStrokeCapRound: true,dotData: FlDotData(
          show: false),belowBarData: BarAreaData(show: true,color: Colors.deepPurple))],);
  }*/
}

class LineTitles {
  static getTitleData() => FlTitlesData(
    show: true,bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
  reservedSize: 22,
  )));
}

class Data {
  Data({required this.x,required this.y});
  final double x;
  final double y;
}*/
