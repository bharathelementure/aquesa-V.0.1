// ignore_for_file: unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_auth/Pages/navdrawer.dart';
import 'package:otp_auth/controllers/home_controllers/currentdate_Titledate.dart';
import 'package:otp_auth/controllers/home_controllers/measurment_graph.dart';
import 'package:otp_auth/utils/dart_Utils.dart' as date_util;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

// String? stringResponseconsump;
Map? rty;

class _GraphState extends State<Graph> {
  double volumeValue = 10;
  final curr = FirebaseAuth.instance.currentUser;

  DateTimeRange rangeDate = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 7)),
      end: DateTime.now());
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  // List<String> todos = <String>[];

  @override
  void initState() {
    super.initState();
    // final apicons = consumptionApi();
    Future<Object> consumptionApi() async {
      final body = {
        'customerId': curr?.uid,
      };
      final jsonString = json.encode(body);
      final uri = Uri.parse(
          "https://845gpwqyuf.execute-api.ap-south-1.amazonaws.com/totalConsumption");
      final headers = {HttpHeaders.contentTypeHeader: "application/json"};
      final http.Response response =
          await http.post(uri, headers: headers, body: jsonString);
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> resp = json.decode(response.body);
        setState(() {
          rty = resp;
        });
        return resp;
      } else {
        return const CircularProgressIndicator();
      }
    }

    var adf = consumptionApi();
    print(adf);

    print("hii");
    currentMonthList = date_util.UtilsDate.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 45.0 * currentDateTime.day);
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

  //date list with scroll
  Widget DateList() {
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
          rty != null
              ? Text(
                  rty!["tatalconsumption"].toString(),
                  style: const TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Color(0xff2A3F74)),
                )
              : const Text(
                  '00.0',
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Color(0xff2A3F74),
                  ),
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

  @override
  Widget build(BuildContext context) {
    final start = rangeDate.start;
    final end = rangeDate.end;
    // willpopscpe time backpressed
    DateTime timeBackPressed = DateTime.now();

    return WillPopScope(
        onWillPop: () async {
          final differwnce = DateTime.now().difference(timeBackPressed);
          final isExitWarrning = differwnce >= const Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarrning) {
            const message = 'Press back again to exit';
            Fluttertoast.showToast(
                msg: message,
                fontSize: 18,
                backgroundColor: const Color(0xFF2292D7),
                textColor: const Color(0xffFFFFFF));

            return false;
          } else {
            Fluttertoast.cancel();

            return true;
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          drawer: const NavDrawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFFFFFFF),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(
                    Icons.menu,
                    color: Color(0xff2A3F74),
                    size: 27,
                  ));
            }),
            title: Image.asset(
              'assets/logo_aquesa.png',
              color: const Color(0xff2A3F74),
              scale: 2,
            ),
            titleSpacing: 0.2,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF2A3F74),
                    size: 26,
                  ))
            ],
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
                        CurrentDateTitleDate(currentDateTime: currentDateTime),
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
                          child: MeasurmentGraph(rangeDate: rangeDate),
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
                      ],
                    )),
              ),
            ],
          ),
        ));
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
