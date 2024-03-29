import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  // final String docId;
  const NavDrawer({
    Key? key,
  }) : super(key: key);

  static const String appliences = "Owner";

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  double volumeValue = 10;

  // camera
  // String selectedImagePath = "";

  // current user data fetched
  final curr = FirebaseAuth.instance.currentUser;
  // final idtoken = curr!.getIdToken().then((value) => value);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color(0xFFFFFFFF),
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.all(0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // user data is provided by placing userId in doc()
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(curr?.uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text(
                                  'Something went wrong',
                                  style: TextStyle(fontSize: 12),
                                );
                              }
                              if (snapshot.hasData && !snapshot.data!.exists) {
                                debugPrint("${curr!.getIdToken()}");
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
                                debugPrint("curr:- $curr");
                                curr!
                                    .getIdTokenResult()
                                    .then((value) => debugPrint("$value"));
                                // print(curr!.refreshToken);
                                debugPrint("Hello");
                                debugPrint("Hello Hello");
                                curr!
                                    .getIdToken()
                                    .then((value) => debugPrint("$value"));
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            '${datare['photoURL']}',
                                            scale: 30,
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return const Icon(
                                                Icons.account_circle_rounded,
                                                size: 82,
                                                color: Color(0xFFFFFFFF),
                                              );
                                            },
                                          )),
                                    ),
                                    Text(
                                      '${datare['displayName']}',
                                      style: const TextStyle(
                                          fontFamily: 'dmsans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${datare['phoneNumber']}',
                                      style: const TextStyle(
                                          fontFamily: 'dmsans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
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
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, '/edit_update');
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFFFFFFFF),
                            size: 25,
                          ))
                    ],
                  )),
            ),
            // add qrcode
            ListTile(
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
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/qrCodeScanner');
              },
            ),
            // Set daily limit
            ListTile(
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
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/circularsetDailyLimit');
              },
            ),
            // Today's Consumption
            ListTile(
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
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/setDaily');
              },
            ),
            // Utility valve controller
            ListTile(
              leading: const Icon(
                Icons.format_color_fill,
                size: 20,
                color: Colors.black,
              ),
              title: const Text(
                'Utility Valve Controller',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'dmsans',
                    color: Color(0xFF181D27)),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/utility_valve_controller');
              },
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
              thickness: 3,
            ),
            // Log out
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
                Navigator.of(context).pop();
                await FirebaseAuth.instance.signOut();
              },
            ),
            // Delete User Account
            ListTile(
              leading: const Icon(
                Icons.delete_forever_outlined,
                size: 20,
                color: Colors.black,
              ),
              title: const Text(
                'Delete Account',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'dmsans',
                    color: Color(0xFF181D27)),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          icon: const Icon(Icons.delete_forever_sharp,
                              size: 50, color: Colors.black),
                          title: const Text(
                            'Are you sure?',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'dmsans'),
                          ),
                          content: const Text(
                            'Do you really want to delete this account. This account cannot be restore.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'dmsans'),
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'dmsans'),
                                )),
                            TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await curr!.delete();
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(curr!.uid)
                                      .delete();
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'dmsans'),
                                ))
                          ],
                        ));
              },
            ),
            const SizedBox(height: 150),
            const Center(
                child: Text(
              'Version 1.0 beta',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'dmsans'),
            )),
          ],
        ),
      ),
    );
  }
}
