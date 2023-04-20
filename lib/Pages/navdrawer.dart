import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth/registration.dart';

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
  String selectedImagePath = "";

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
                          /*const Icon(
                            Icons.account_circle_rounded,
                            size: 72,
                            color: Color(0xFFFFFFFF),
                          ),*/
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
                                            '${datare['profileimage']}',
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
                                      '${datare['name']}',
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
                                      '${datare['phone']}',
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
                            size: 25,
                          ))
                    ],
                  )),
            ),
            // Main graph
            ListTile(
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
                'Today\'s Consumtion',
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
              onTap: () {
                FirebaseAuth.instance.signOut();
                // retrive.signOut();
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
            )),
          ],
        ),
      ),
    );
  }

  /*Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text('Select Image From !'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_path:-');
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No Image Selected !')));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: const [
                                  Icon(Icons.linked_camera_rounded, size: 50),
                                  Text('Gallery')
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            // print('Image_path:-');
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('No Image Saelected !')));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.linked_camera_outlined,
                                    size: 50,
                                  ),
                                  Text('Camera')
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 100);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }*/
}
