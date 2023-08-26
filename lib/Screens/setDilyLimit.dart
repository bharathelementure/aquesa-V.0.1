// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, file_names, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:otp_auth/Screens/home.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../controllers/pop_notification.dart';

// String? stringResponse;

class SetDailyLimit extends StatefulWidget {
  // final volumeValue;
  const SetDailyLimit({
    Key? key,
  }) : super(key: key);

  @override
  State<SetDailyLimit> createState() => _SetDailyLimitState();
}

String? stringResponse;
Map? rty;

class _SetDailyLimitState extends State<SetDailyLimit> {
  final curr = FirebaseAuth.instance.currentUser;
  final now = DateTime.now;
  Future apiConsumption() async {
    http.Response response;
    response = await http.post(Uri.parse("http://192.168.0.126:8080/csm"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
      });
      return response.toString();
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    // apiConsumption();
    super.initState();
    Future<Object> consumptionApi() async {
      try {
        final body = {'customerId': curr!.uid};
        final jsonString = json.encode(body);
        final uri = Uri.parse(
            "https://845gpwqyuf.execute-api.ap-south-1.amazonaws.com/totalConsumption");
        final header = {HttpHeaders.contentTypeHeader: "application/json"};
        final http.Response response =
            await http.post(uri, headers: header, body: jsonString);
        if (response.statusCode == 200) {
          print(response.body);
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
          print('No internet connection');
          Fluttertoast.showToast(msg: 'No Internet connection');
          return "No internet connection";
        }
        return const CircularProgressIndicator();
      }
    }

    /*Future<Object> consumptionApi() async {
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
    }*/

    var adf = consumptionApi();
    print(adf);

    print("hii");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A70A1),
      // drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A70A1),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
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
                  title: Text(
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
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.notifications_outlined,
          //       color: Color(0xFFFFFFFF),
          //       size: 26,
          //     ))
        ],
      ),
      /*appBar: AppBar(
        centerTitle: true,
        //drop down items
        /*title: DropdownButton(items:
      [DropdownMenuItem(child: Text('16 sep 2022',style:
      TextStyle(fontFamily: 'raleway',fontSize: 12,fontWeight: FontWeight.w500,
          color: Color(0xFF2A3F74)),),value: 'one',),
        DropdownMenuItem(child: Text('17 sep 2022',style:
        TextStyle(fontFamily: 'raleway',fontSize: 12,fontWeight: FontWeight.w500,
            color: Color(0xFF2A3F74)),),value: 'two',)],
          onChanged: (String ) {setState(() => _value = _value);},),*/
        elevation: 0,
        actions: [
          PopUpMen(
              menuList: const [
                /*PopupMenuItem(child: ListTile(
      leading: Icon(CupertinoIcons.person),
      title: Text('My Profile'),
    )),
    PopupMenuItem(child: ListTile(
    leading: Icon(CupertinoIcons.square_arrow_left),
    title: Text('Log Out'),
    )),
    PopupMenuDivider(),
    PopupMenuItem(child: Text('Settings'))*/
              ],
              icon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF2A3F74),
                    size: 26,
                  )))
        ],
        backgroundColor: const Color(0xFFFFFFFF),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF5075A9),
                size: 27,
              ),
            );
          },
        ),
      ),*/
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 26,
              ),
              const Text(
                "Today's Consumption",
                style: TextStyle(
                    fontFamily: 'raleway',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF)),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                DateFormat('E, d MMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                    fontFamily: 'dmsans',
                    fontSize: 21,
                    fontWeight: FontWeight.w200,
                    color: Color(0xFFFFFFFF)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 42,
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // stringResponseconsump != null
                            //     ? "$stringResponseconsump"
                            //     : "00.0",
                            rty != null
                                ? rty!["tatalconsumption"].toString()
                                : "00.0",
                            style: const TextStyle(
                                fontFamily: 'inter',
                                fontSize: 50,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),
                          ),
                          /*Text(
                            '69.7',
                            // stringResponse.toString(),
                            // widget.volumeValue.ceil().toString(),
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 100,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFFFFFF)),
                          ),*/
                          /* const Text(
                            '%',
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontSize: 50,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF)),
                          ),*/
                        ],
                      )
                    ],
                  )),
              const SizedBox(
                height: 0,
              ),
              const Text(
                'Litres',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    fontFamily: 'raleway',
                    color: Color(0xFFFFFFFF)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 155,
              ),
              WaveWidget(
                config: CustomConfig(durations: [
                  18000,
                  30000,
                  60000
                ], heightPercentages: [
                  0.0064,
                  0.0074,
                  0.0084
                  /*-widget.volumeValue * 0.0064,
                  -widget.volumeValue * 0.0074,
                  -widget.volumeValue * 0.0084*/
                ], colors: [
                  const Color(0xFFAAD7FB),
                  const Color(0xFF94CFFF),
                  const Color(0xFFA5D4F9)
                ]),
                size: const Size(double.infinity, 128),
                waveAmplitude: 35,
                backgroundColor: const Color(0xFF3A70A1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
