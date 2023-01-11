import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth/models/userModels.dart';
import 'package:otp_auth/registration.dart';
import 'package:otp_auth/setDilyLimit.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  static const String appliences = "Owner";

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  double volumeValue = 10;
  final retrive = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Future creuse = readUser();
    print(creuse.runtimeType);
    print('');
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
                          /*StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Create Account')
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
                                    return ListTile(title: Text(data['Name'],style: const TextStyle(
                                              fontFamily: 'dmsans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color: Color(0xFFFFFFFF)),),
                                    subtitle: Text(data['phone']),);
                                  }
                                ).toList().cast());
                              })*/
                          // user data is provided by id mentioning
                          /*FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc('Ou6i8ct0bddtgcfdC5cc349N7833')
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<
                                        DocumentSnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              print('snapshot data');
                              print(snapshot.data!.data());
                              /*if (snapshot.hasError) {
                                return const Text('error');
                              } else */if (snapshot.hasData) {
                                final userCreate = snapshot.data!.data();
                                print(userCreate?['Name']);
                                // print(userModel);
                                return Text(
                                  userCreate?['Name'],
                                  style: const TextStyle(
                                      fontFamily: 'dmsans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Color(0xFFFFFFFF)),
                                );
                                // return userCreate == null
                                //     ? const Center(child: Text('No User'))
                                //     : buildUser(userModel);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc('Ou6i8ct0bddtgcfdC5cc349N7833')
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<
                                        DocumentSnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              print('snapshot data');
                              print(snapshot.data!.data());
                              /*if (snapshot.hasError) {
                                return const Text('error');
                              } else*/ if (snapshot.hasData) {
                                final userCreate = snapshot.data!.data();
                                print(userCreate?['phone']);
                                // print(userModel);
                                return Text(
                                  userCreate?['phone'],
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'dmsans',
                                      color: Color(0xFFABABAB)),
                                );
                                // return userCreate == null
                                //     ? const Center(child: Text('No User'))
                                //     : buildUser(userModel);
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),*/
                          // current user data
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .snapshots(),
                            builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              print(snapshot.data!.docs.asMap()['name']);
                              return Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [Text(snapshot.data!.docs[0]['name']),
                                    // SizedBox(height: 8),
                                    // Text(snapshot.data!.docs[1][''])
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          /*Text(
                            '$creuse',
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
                          const Text(
                            '+91 9686439332',
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: Color(0xFFFFFFFF),
                            size: 31,
                          ))
                    ],
                  )),
            ),
            //add house
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
            // Set Daily lemit
            const SizedBox(
              height: 7,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                    Icons.opacity_outlined,
                    color: Color(0xFF555555),
                    size: 21,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/circularsetDailyLimit');
                          },
                          child: const Text(
                            'Set Daily Limit',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'dmsans',
                                color: Color(0xFF181D27)),
                          )),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/circularsetDailyLimit');
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xFFA3A3A3),
                        size: 15,
                      ))
                ],
              ),
            ),
            // Today's Consumption
            const SizedBox(
              height: 7,
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
                    Icons.percent_outlined,
                    color: Color(0xFF555555),
                    size: 21,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SetDailyLimit(
                                      volumeValue: volumeValue,
                                    )));
                          },
                          child: const Text(
                            'Today\'s Consumtion',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'dmsans',
                                color: Color(0xFF181D27)),
                          )),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SetDailyLimit(
                                  volumeValue: volumeValue,
                                )));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xFFA3A3A3),
                        size: 15,
                      ))
                ],
              ),
            ),
            //bill payments
            /*const SizedBox(
              height: 7,
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
                    Icons.receipt_long_outlined,
                    color: Color(0xFF555555),
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
                          'Bill Payments ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'dmsans',
                              color: Color(0xFF181D27)),
                        ),
                      ), /*
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Manage your bills',
                        style: TextStyle(
                            fontFamily: 'dmsans',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xFFABABAB)),
                      )*/
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/paymentsInvoices');
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xFFA3A3A3),
                        size: 15,
                      ))
                ],
              ),
            ),*/
            //payments settings
            /*const SizedBox(
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
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF555555),
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
                          'Payment Settings ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'dmsans',
                              color: Color(0xFF181D27)),
                        ),
                      ), /*
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Manage your account ',
                        style: TextStyle(
                            fontFamily: 'dmsans',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xFFABABAB)),
                      )*/
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
            //log out
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
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFF555555),
                    size: 21,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await retrive.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Registration()));
                        },
                        child: const Text(
                          'Log Out ',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'dmsans',
                              color: Color(0xFF181D27)),
                        ),
                      )
                      /*SizedBox(
                        height: 10,
                      ),
                      Text(
                        'To secure account',
                        style: TextStyle(
                            fontFamily: 'dmsans',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xFFABABAB)),
                      )*/
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        await retrive.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registration()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Color(0xFFA3A3A3),
                        size: 15,
                      ))
                ],
              ),
            ),
            /*more
        SizedBox(height: 0,),Text('More',style: TextStyle(fontSize: 14,
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

  Future readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection("Account Created")
        .doc();
    final snapshot = await docUser.get();
    print('');
    print(snapshot.get('Name'));
    print('');
    //  if (snapshot.exists) {
    //    return snapshot.get('Name');
    //     // return UserModel.fromJson(snapshot.data()!);
    //   }
    // final realdata = snapshot.get('Name');
    // return snapshot;
  }

  Widget buildUser(UserModel userModel) => ListTile(
        title: Text(userModel.Name.toString()),
        subtitle: Text(userModel.phone.toString()),
      );
}
