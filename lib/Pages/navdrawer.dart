import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth/registration.dart';
import 'package:otp_auth/setDilyLimit.dart';

class NavDrawer extends StatefulWidget {
  // final String docId;
  const NavDrawer({Key? key,}) : super(key: key);

  static const String appliences = "Owner";

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  double volumeValue = 10;
  final retrive = FirebaseAuth.instance;
  /*late String _uid;
  late String _name;
  late String _email;
  late String _phoneNumber;*/

  // String? get docId => null;
  /*@override
  void initState() {
    super.initState();
    setState(() {});
    getData();
  }*/

  /*Future<UserMode> getUserDetails(String email) async {
    final snap = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final userData = snap.docs.map((e) => UserMode.fromSnapshot(e)).single;
    return userData;
  }*/

  /*void getData() async {
    User? curre = FirebaseAuth.instance.currentUser;
    _uid = curre!.uid;
    final DocumentSnapshot docUser =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    _name = docUser.get('name');
    print(curre);
    print('hello');
    // print('curre.email ${curre.displayName}');
  }*/

  final curr = FirebaseAuth.instance.currentUser!;
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
                      const Icon(
                        Icons.account_circle_rounded,
                        size: 62,
                        color: Color(0xFFFFFFFF),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // List of user can be find
                          /*StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text('Loading..');
                                }
                                return ListView(
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    return ListTile(title: Text(data['name'],style: const TextStyle(
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF)),),
                                    subtitle: Text(data['phone']),);
                                  }
                                ).toList().cast());
                              })*/
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          // userdata by index[0]
                          /*StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              print(snapshot.requireData.docs
                                  .asMap()[0]!['phone']
                                  .toString());
                              print(snapshot.requireData.docs);
                              print('hello');
                              print(curr);
                              print(snapshot.data!.docs.asMap()[0]!['phone']);
                              return Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // snapshot
                                      //     .inState(ConnectionState.active)
                                      //     .data!
                                      //     .docs[1]
                                      //     .get('name'),
                                      snapshot.data!.docs[1]['name'],
                                      style: const TextStyle(
                                          fontFamily: 'dmsans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      snapshot.data!.docs[1]['phone']
                                          .toString(),
                                      // snapshot.requireData.docs
                                      //     .asMap()[0]!['phone']
                                      //     .toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'dmsans',
                                          color: Color(0xFFABABAB)),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),*/
                          /*Text(
                            curr.displayName!,
                            // 'Nagathihalli Bharath',
                            style: const TextStyle(
                                fontFamily: 'dmsans',
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Color(0xFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            curr.phoneNumber!,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'dmsans',
                                color: Color(0xFFABABAB)),
                          ),*/
                          /*Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [RadioListTile(title: Text('Owner'),value: "Owner",
              groupValue: appliences, onChanged: (value){}),
            RadioListTile(title: Text('Tenant',style: TextStyle(fontFamily: 'raleway',
            fontWeight: FontWeight.w700,fontSize: 12,color: Color(0xFF181D27)),),
                value: "Tenant", groupValue: appliences, onChanged: (value){})],)*/
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
                            size: 31,
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
              onTap: () async {
                Navigator.of(context).pop();
                var nav = await Navigator.pushNamed(context, '/qrCodeScanner');
                if (nav == true || nav == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/graph', (Route<dynamic> route) => false);
                }
                // Navigator.of(context).push(MaterialPageRoute(
                // builder: (context) => const QrCodeScanner()));
                // Navigator.pushNamed(context, '/qrCodeScanner');
              },
            ),
            // Main graph
            ListTile(
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
                var nave = await Navigator.pushNamed(context, '/graph');
                if (nave == true || nave == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/graph', (Route<dynamic> route) => false);
                }
                // Navigator.pushNamed(context, '/graph');
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
                var navi = await Navigator.pushNamed(
                    context, '/circularsetDailyLimit');
                if (navi == true || navi == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/graph', (Route<dynamic> route) => false);
                }
                // Navigator.pushNamed(context, '/circularsetDailyLimit');
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
                'Today\'s Consumtion',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'dmsans',
                    color: Color(0xFF181D27)),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                var navo = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SetDailyLimit(
                          volumeValue: volumeValue,
                        )));
                if (navo == true || navo == null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/graph', (Route<dynamic> route) => false);
                }
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => SetDailyLimit(
                //           volumeValue: volumeValue,
                //         )));
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
                await retrive.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Registration()));
              },
            ),
            /*//add house
            const SizedBox(
              height: 0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(5),
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(10, 10),
                        blurRadius: 20,
                        color: const Color(0xFF000000).withOpacity(0.25))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/qrCodeScanner');
                      },
                      child: const Text(
                        '+ Add Device',
                        style: TextStyle(
                            fontFamily: 'ralwey',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000)),
                      ))
                ],
              ),
            ),
            // Home Screen
            const SizedBox(height: 7),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(0),
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFFFFF),
                          elevation: 0),
                      onPressed: () {
                        Navigator.pushNamed(context, '/graph');
                      },
                      icon: const Icon(
                        Icons.home_filled,
                        color: Color(0xFF555555),
                        size: 21,
                      ),
                      label: const Text(
                        'Main Graph',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'dmsans',
                            color: Color(0xFF181D27)),
                      )),
                ],
              ),
            ),
            // Set Daily lemit
            const SizedBox(height: 0),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(0),
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFFFFF),
                          elevation: 0),
                      onPressed: () {
                        Navigator.pushNamed(context, '/circularsetDailyLimit');
                      },
                      icon: const Icon(
                        Icons.opacity_outlined,
                        color: Color(0xFF555555),
                        size: 21,
                      ),
                      label: const Text(
                        'Set Daily Limit ',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'dmsans',
                            color: Color(0xFF181D27)),
                      )),
                ],
              ),
            ),
            // Todays Consumption
            const SizedBox(height: 0),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(0),
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFFFFF),
                          elevation: 0),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SetDailyLimit(
                                  volumeValue: volumeValue,
                                )));
                      },
                      icon: const Icon(
                        Icons.percent_outlined,
                        color: Color(0xFF555555),
                        size: 21,
                      ),
                      label: const Text(
                        'Today\'s Consumption ',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'dmsans',
                            color: Color(0xFF181D27)),
                      )),
                ],
              ),
            ),
            // Log out
            const SizedBox(height: 0),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(0),
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFFFFF),
                          elevation: 0),
                      onPressed: () async {
                        await retrive.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registration()));
                      },
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFF555555),
                        size: 21,
                      ),
                      label: const Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'dmsans',
                            color: Color(0xFF181D27)),
                      )),
                ],
              ),
            ),*/
            // /*more
            /*SizedBox(height: 0,),Text('More',style: TextStyle(fontSize: 14,
        fontWeight: FontWeight.w600,fontFamily: 'dmsans',color: Color(0xFF181D27)),),
            //help and support
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 2,
              color: Colors.blueGrey,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(0),
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.help_outline_rounded,
                    color: Color(0xFF0601B4),
                    size: 21,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Help & Support',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'dmsans',
                              color: Color(0xFF181D27)),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xFFA3A3A3),
                        size: 15,
                      ))
                ],
              ),
            ),
            //about app
            const SizedBox(
              height: 0,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.all(0),
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(5),
                /*boxShadow: [BoxShadow(offset: Offset(0, 10),blurRadius: 20,//boxShadow with background colors box
                color: Color(0xFF000000).withOpacity(0.25))]*/
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFF0601B4),
                    size: 21,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'About App',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'dmsans',
                              color: Color(0xFF181D27)),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xFFA3A3A3),
                        size: 15,
                      ))
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
