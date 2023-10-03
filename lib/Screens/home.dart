import 'dart:convert';
import 'dart:io';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:otp_auth/Pages/navdrawer.dart';
import 'package:otp_auth/controllers/home_controllers/current_date_title_date.dart';
import 'package:otp_auth/controllers/home_controllers/measurment_graph.dart';
import 'package:otp_auth/utils/dart_utils.dart' as date_util;

import '../controllers/pop_notification.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

String? stringResponseconsump;
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
  DatePickerController controllerDate = DatePickerController();
  DateTime selectedValue = DateTime.now();
  // List<String> todos = <String>[];\

  // api
  Future<Object> consumptionApi() async {
    try {
      final body = {'customerId': "${curr!.uid},$selectedValue"};
      final jsonString = json.encode(body);
      final uri = Uri.parse(
          "https://845gpwqyuf.execute-api.ap-south-1.amazonaws.com/totalConsumption");
      final header = {HttpHeaders.contentTypeHeader: "application/json"};
      final http.Response response =
          await http.post(uri, headers: header, body: jsonString);
      if (response.statusCode == 200) {
        debugPrint(response.body);
        Map<String, dynamic> resp = json.decode(response.body);
        setState(() {
          rty = resp;
        });
        return resp;
      } else {
        // Api request fail with status code non-200
        Fluttertoast.showToast(msg: '${response.statusCode}');
        throw Exception(
            'Api request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is SocketException) {
        // error related to no internet
        debugPrint('No internet connection');
        Fluttertoast.showToast(msg: 'No Internet connection');
        return "No internet connection";
      }
      return const CircularProgressIndicator();
    }
  }

// Localy host api
  Future<void> apiConsumption() async {
    try {
      final rdata = {"customer_id": "${curr!.uid},$selectedValue"};
      final jsonString = json.encode(rdata);
      final uri = Uri.parse("http://192.168.0.136:8000/devID");

      http.Response response;
      response = await http.post(uri, body: jsonString);

      if (response.statusCode == 200) {
        setState(() {
          stringResponseconsump = response.body;
        });
        debugPrint(stringResponseconsump);
        debugPrint("API request successful");
      } else {
        debugPrint(
            "API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("An error occurred: $e");
      if (e is SocketException) {
        debugPrint("No internet connection");
        // Handle no internet connection here
      } else {
        // Handle other exceptions here
      }
    }
  }

  // Called when the dependency of this state object changes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rty;
    apiConsumption();
    // consumptionApi();
  }

  // Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(covariant Graph oldWidget) {
    super.didUpdateWidget(oldWidget);
    rty;
    apiConsumption();
    // consumptionApi();
  }

  @override
  void initState() {
    super.initState();
    apiConsumption();
    // consumptionApi();
    rty;
    // final apicons = consumptionApi();
    /*Future<Object> consumptionApi() async {
      final body = {
        'customerId': "${curr!.uid},$currentDateTime",
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
    }*/

    // var adf = consumptionApi();
    // print(adf);

    debugPrint("hii");
    currentMonthList = date_util.UtilsDate.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 45.0 * currentDateTime.day);
  }

  //current date List
  //date list with scroll
  Widget dateList() {
    return SizedBox(
        height: 50,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: currentMonthList.length,
          itemBuilder: (BuildContext context, int index) => presentDate(index),
        ));
  }

  Widget presentDate(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: GestureDetector(
          onTap: () {
            setState(() {
              (currentDateTime = currentMonthList[index]);
              // consumptionApi();
              apiConsumption();
              rty = (rty);
              debugPrint('select data => $currentDateTime');
            });
          },
          child: Container(
            width: 48,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(
                  color: (currentMonthList[index].day < currentDateTime.day)
                      ? const Color(0xffD6D6D6)
                      : (currentMonthList[index].day != currentDateTime.day)
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
                    '${currentMonthList[index].day} ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'inter',
                        color:
                            (currentMonthList[index].day < currentDateTime.day)
                                ? const Color(0xff3B7AC5)
                                : (currentMonthList[index].day !=
                                        currentDateTime.day)
                                    ? const Color(0xffD6D6D6)
                                    : const Color(0xff2A3F74)),
                  ),
                  Text(
                    // weekday
                    date_util.UtilsDate
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontFamily: 'raleway',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color:
                            (currentMonthList[index].day < currentDateTime.day)
                                ? const Color(0xff3B7AC5)
                                : (currentMonthList[index].day !=
                                        currentDateTime.day)
                                    ? const Color(0xffD6D6D6)
                                    : const Color(0xff2A3F74)),
                  )
                ],
              ),
            ),
          )),
    );
  }

  //Text of liters saved
  Widget litersOfText() {
    return SizedBox(
        height: 50,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            // rty != null ? rty!["tatalconsumption"].toString() : "00.0",
            stringResponseconsump != null ? "$stringResponseconsump" : "00.0",
            style: const TextStyle(
                fontFamily: 'inter',
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: Color(0xff2A3F74)),
          ),
          const SizedBox(width: 7),
          /*const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
          ),*/
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
            actions: const [
              PopUpMen(
                  color: Color(0xFFEDEBEB),
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF2A3F74),
                    size: 26,
                  ),
                  menuList: [
                    PopupMenuItem(
                        child: ListTile(
                      leading: Text(
                        'No Notifications',
                        style: TextStyle(
                            color: Color(0xFF7B7A7A),
                            fontFamily: 'raleway',
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ))
                  ]),
              // IconButton(
              //     onPressed: () {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text('There\'s No Notifications')));
              //     },
              //     icon: const Icon(
              //       Icons.notifications_outlined,
              //       color: Color(0xFF2A3F74),
              //       size: 26,
              //     ))
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () {
              // consumptionApi();
              apiConsumption();
              return Future<void>.delayed(const Duration(seconds: 3));
            },
            child: ListView(
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
                          CurrentDateTitleDate(
                              currentDateTime: currentDateTime),
                          const SizedBox(height: 0),
                          // DateTimeLine(
                          //     width: 50,
                          //     color: Colors.lightGreen,
                          //     onSelected: (value) {
                          //       setState(() {
                          //         selectedValue = value;
                          //       });
                          //     },
                          //     hintText: rty!["tatalconsumption"].toString()),
                          // DateList(),
                          DatePicker(
                            DateTime.now().subtract(const Duration(days: 6)),
                            width: 46,
                            height: 76,
                            controller: controllerDate,
                            initialSelectedDate: DateTime.now(),
                            inactiveDates: [
                              DateTime.now().add(const Duration(days: 1)),
                            ],
                            daysCount: 8,
                            deactivatedColor: Colors.grey,
                            onDateChange: (date) {
                              setState(() {
                                selectedValue = date;
                                // consumptionApi();
                                apiConsumption();
                                rty = (rty);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 3,
                            color: Color(0xffAFD3F1),
                          ),
                          const SizedBox(height: 10),
                          litersOfText(),
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
          )),
    );
  }

  Future rangePickDate() async {
    DateTimeRange? newDaterange = await showDateRangePicker(
      context: context,
      initialDateRange: rangeDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (newDaterange == null) return;
    setState(() {
      rangeDate = newDaterange;
    });
  }
}
