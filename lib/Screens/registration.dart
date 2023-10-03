import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:otp_auth/Pages/create_account_page.dart';
import 'package:otp_auth/Pages/sigin_in_page.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  DateTime timeBackPressed = DateTime.now();
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this will give total height and width of the device
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
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                backgroundColor: const Color(0xFF12172B),
                body: NestedScrollView(
                  headerSliverBuilder: (context, innerBOxIsScrolled) => [
                    const SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        floating: true,
                        flexibleSpace: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TabBar(
                                  labelColor: Color(0xffFFFFFF),
                                  unselectedLabelColor: Color(0xff676C77),
                                  indicatorColor: Color(0xff676C77),
                                  indicatorWeight: 2,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        "SIGN IN",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'raleway',
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'CREATE ACCOUNT',
                                        style: TextStyle(
                                            fontFamily: 'raleway',
                                            fontSize: 14),
                                      ),
                                    )
                                  ]),
                            ]))
                  ],
                  body: Container(
                      color: const Color(0xffFFFFFF),
                      child: TabBarView(children: [
                        MyPhone(
                          onClickedSignUp: () {},
                        ),
                        CreateAcountPage(
                          onClickedSignIn: () {},
                        )
                      ])),
                ))));

    /*DefaultTabController(
        length: 2, child: Scaffold(
      backgroundColor: Color(0xFF12172B),
      appBar: PreferredSize( preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(color: Color(0xFF72AFDE),child: SafeArea(child: Column(
        children: [Expanded(child: Container()),TabBar(labelColor: Color(0xFFFFFFFF),
          unselectedLabelColor: Color(0xFF676C77),indicatorColor: Color(0xFF676C77),
          indicatorWeight: 2,
          tabs:
        [Text("SIGNIN" ,style: TextStyle(
          fontFamily: 'raleway',fontSize: 14),), Text("CREATEACOUNT",
          style: TextStyle(fontFamily: 'raleway',
            fontSize: 14,))],)]
      )),),),resizeToAvoidBottomInset: false,
      body: Container(color: Color(0xFFFFFFFF),
        child:
      TabBarView(children: [SignInPage(),CreateAcountPage(),]),)));*/
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: ((context) => CupertinoAlertDialog(
            title: const Text('No Connection'),
            content: const Text('Please check your internet connection'),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancel');
                    setState(() => isAlertSet = false);
                    isDeviceConnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceConnected) {
                      showDialogBox();
                      setState(() => isAlertSet = true);
                    }
                  },
                  child: const Text('OK'))
            ],
          )));
}
