import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_auth/circularSetDailyLimit.dart';
import 'package:otp_auth/qrCodeScanner.dart';
import 'package:otp_auth/registration.dart';
import 'package:otp_auth/setDilyLimit.dart';

class HomePageAlter extends StatelessWidget {
  const HomePageAlter({super.key});

  @override
  Widget build(BuildContext context) {
    var indexClicked = 0;
    final pages = [
      const Center(
          // child: NavMainScreen(),
          ),
      const Center(
        child: QrCodeScanner(),
      ),
      const Center(
        child: CircularSetDailyLimit(),
      ),
      const Center(
        child: SetDailyLimit(),
      )
    ];
    DateTimeRange rangeDate = DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 7)),
        end: DateTime.now());
    final difference = rangeDate.duration;
    final curr = FirebaseAuth.instance.currentUser!;
    // willpopscope toast message
    final start = rangeDate.start;

    final end = rangeDate.end;
    DateTime timeBackPreesed = DateTime.now();
    return WillPopScope(
        onWillPop: () async {
          final differwnce = DateTime.now().difference(timeBackPreesed);
          final isExitWarrning = differwnce >= const Duration(seconds: 2);

          timeBackPreesed = DateTime.now();
          if (isExitWarrning) {
            Fluttertoast.showToast(
              msg: 'Press back again to exit',
            );
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
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
          body: pages[indexClicked],
          drawer: Drawer(
            child: Material(
              color: const Color(0xFFFFFFFF),
              child: ListView(
                children: [
                  DrawerHeader(
                      child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    padding: const EdgeInsets.all(5),
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFF4A89D2),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(10, 10),
                              blurRadius: 20,
                              color: const Color(0xFF000000).withOpacity(0.25))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.account_circle_rounded,
                            size: 62, color: Color(0xFFFFFFFF)),
                        const SizedBox(width: 0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // user data is provided by placing userId in doc()
                            FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(curr.uid)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text(
                                    'Something went wrong',
                                    style: TextStyle(fontSize: 12),
                                  );
                                }
                                if (snapshot.hasData &&
                                    !snapshot.data!.exists) {
                                  // print(curr.uid);
                                  // print('hello');
                                  return const Text(
                                    'Document does not exist',
                                    style: TextStyle(fontSize: 10),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map<String, dynamic> datare = snapshot.data!
                                      .data() as Map<String, dynamic>;
                                  print(curr);
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${datare['name']}',
                                        style: const TextStyle(
                                            fontFamily: 'dmsans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${datare['phone']}',
                                        style: const TextStyle(
                                            fontFamily: 'dmsans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Color(0xFFFFFFFF)),
                                      ),
                                    ],
                                  );
                                }
                                return const Text('Loading...');
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/edit_update');
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFFFFFFFF),
                              size: 31,
                            ))
                      ],
                    ),
                  )),
                  ListTile(
                    onTap: () {
                      // setState(() {
                      //   indexClicked = 0;
                      // });
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.home_filled,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'dmsans',
                          color: Color(0xFF181D27)),
                    ),
                  ),
                  // qrcode
                  ListTile(
                    onTap: () {
                      // setState(() {
                      //   indexClicked = 1;
                      // });
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Add Device',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'dmsans',
                          color: Color(0xFF181D27)),
                    ),
                  ),
                  // Set daily Limit
                  ListTile(
                    onTap: () {
                      // setState(() {
                      //   indexClicked = 2;
                      // });
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.opacity_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Set Daily Limit',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'dmsans',
                          color: Color(0xFF181D27)),
                    ),
                  ),
                  // Today's Consumption
                  ListTile(
                    onTap: () {
                      // setState(() {
                      //   indexClicked = 3;
                      // });
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.percent_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Today\'s Consumption',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'dmsans',
                          color: Color(0xFF181D27)),
                    ),
                  ),
                  // Divider
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    thickness: 3,
                  ),
                  // Log Out
                  ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'dmsans',
                          color: Color(0xFF181D27)),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registration()));
                    },
                  ),
                  const SizedBox(height: 150),
                  const Center(
                    child: Text(
                      'Version 1.0',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'dmsans'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
