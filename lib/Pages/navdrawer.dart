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
                                          )
                                          /*CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                '${datare['profileimage']}'),
                                            radius: 80,
                                            onBackgroundImageError:
                                                (error, stackTrace) {
                                              Error();
                                              const Icon(
                                                  Icons.account_circle_rounded);
                                            },
                                          )*/
                                          ),
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
            // Main graph
            /*ListTile(
              // trailing: const Icon(Icons.arrow_forward_ios_rounded,
              // size: 20, color: Colors.black),
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
              onTap: () async {
                Navigator.of(context).pop();
                // var nave = await Navigator.pushNamed(context, '/graph');
                // if (nave == true || nave == null) {
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //       '/graph', (Route<dynamic> route) => false);
                // }
                Navigator.pushNamed(context, '/graph');
              },
            ),*/
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
              onTap: () async {
                Navigator.of(context).pop();
                // var nav = await Navigator.pushNamed(context, '/qrCodeScanner');
                // if (nav == true || nav == null) {
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //       '/graph', (Route<dynamic> route) => false);
                // }
                // Navigator.of(context).push(MaterialPageRoute(
                // builder: (context) => const QrCodeScanner()));
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
              onTap: () async {
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
              onTap: () async {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/setDaily');
                // var navo = await Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const SetDailyLimit()));
                // if (navo == true || navo == null) {
                //   Navigator.of(context).pushNamedAndRemoveUntil(
                //       '/graph', (Route<dynamic> route) => false);
                // }
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
                await FirebaseAuth.instance.signOut();
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const Registration()));
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
